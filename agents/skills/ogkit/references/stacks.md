# Per-stack idioms

Four things differ by stack: where `<head>` lives, how to get the canonical URL, how to URL-encode, and how to detect development. Everything else in SKILL.md is the same everywhere. Snippets use `ACME` and `acme.com` as placeholders; replace them with the site's real brand and host.

## Rails (ERB)

The proven reference. Helper in `app/helpers/og_card_helper.rb`, everything else in `app/views/layouts/application.html.erb` (or the marketing layout if there is one).

```ruby
module OgCardHelper
  HOST = "https://acme.com"
  OGKIT_ENDPOINT = "https://ogkit.dev/img/"
  OGKIT_RENDER_PARAM = "ogkit-render"
  HEADLINE_LIMIT = 60
  SUBLINE_LIMIT = 130

  def ogkit_image_url(page_url)
    key = ENV["OGKIT_API_KEY"].presence
    return unless key

    separator = page_url.include?("?") ? "&" : "?"
    versioned = "#{page_url}#{separator}ogv=#{ENV.fetch("OGKIT_CACHE_VERSION", "v1")}&#{OGKIT_RENDER_PARAM}=1"
    "#{OGKIT_ENDPOINT}#{key}.jpeg?url=#{CGI.escape(versioned)}"
  end

  def ogkit_render_request?
    request.query_parameters.key?(OGKIT_RENDER_PARAM)
  end

  # "Pricing | Acme" -> "Pricing". A brand-only title gets the default tagline.
  def og_card_headline(page_title)
    headline = CGI.unescapeHTML(page_title.to_s).split(/\s+[|·—-]\s+/).reject { |s| s.match?(/\AAcme\b/) }.last.to_s.strip
    headline = "Acme does the thing." if headline.blank?
    truncate(headline, length: HEADLINE_LIMIT, separator: " ", omission: "")
  end

  # Cut on a sentence, never mid-clause.
  def og_card_subline(description)
    text = CGI.unescapeHTML(description.to_s).strip
    kept = text.split(/(?<=[.?!])\s+/).each_with_object([]) do |sentence, taken|
      break taken if (taken + [ sentence ]).join(" ").length > SUBLINE_LIMIT
      taken << sentence
    end
    kept.any? ? kept.join(" ") : truncate(text, length: SUBLINE_LIMIT, separator: " ")
  end

  LOGO_SVG = Rails.root.join("app/assets/images/logo.svg").read.sub(/\A<\?xml.*?\?>\s*/m, "").freeze

  def og_card_logo
    raw LOGO_SVG.sub("<svg", %(<svg width="260" height="56"))
  end
end
```

Layout `<head>`:

```erb
<% og_image = ogkit_image_url(canonical_url) || "https://acme.com/og-card.png" %>
<meta property="og:image" content="<%= og_image %>">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta property="og:image:alt" content="<%= og_card_headline(page_title) %>">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:image" content="<%= og_image %>">
<% if Rails.env.development? %>
  <script defer src="https://cdn.jsdelivr.net/npm/ogkit@1"></script>
<% end %>
<% if Rails.env.production? && !ogkit_render_request? %>
  <%# analytics, chat widget, tracking %>
<% end %>
```

End of `<body>`:

```erb
<template data-og-template>
  <div style="width:1200px;height:630px;display:flex;flex-direction:column;box-sizing:border-box;overflow:hidden;background-color:#fbfaf8;font-family:'Manrope',ui-sans-serif,system-ui,sans-serif;">
    <div style="flex:1 1 auto;min-height:0;display:flex;flex-direction:column;padding:72px 88px;box-sizing:border-box;">
      <%= og_card_logo %>
      <div style="flex:1 1 auto;min-height:0;display:flex;flex-direction:column;justify-content:center;">
        <div style="max-width:1000px;max-height:222px;overflow:hidden;font-size:64px;line-height:1.15;font-weight:600;letter-spacing:-0.03em;color:#1c1c1c;text-wrap:balance;"><%= og_card_headline(page_title) %></div>
        <div style="margin-top:22px;max-width:900px;max-height:84px;overflow:hidden;font-size:27px;line-height:1.55;color:#6b6b6b;text-wrap:pretty;"><%= og_card_subline(content_for(:description)) %></div>
      </div>
    </div>
    <div style="flex:0 0 96px;display:flex;align-items:center;justify-content:space-between;padding:0 88px;background-color:#1c1c1c;color:#fff;font-size:26px;">
      <span style="font-weight:700;">acme.com</span>
      <span style="color:#a3a3a3;">One line the site already says.</span>
    </div>
  </div>
</template>
```

Tests (`test/test_helper.rb` deletes `OGKIT_API_KEY` and `OGKIT_CACHE_VERSION` globally; a `with_ogkit` helper sets them for one block):

```ruby
test "og:image is the ogkit render of the canonical url" do
  with_ogkit(key: "og_test_key", version: "v7") do
    host! "acme.com"
    get "/pricing"
  end
  escaped = CGI.escape("https://acme.com/pricing?ogv=v7&ogkit-render=1")
  assert_includes response.body, %(property="og:image" content="https://ogkit.dev/img/og_test_key.jpeg?url=#{escaped}")
end

test "without a key nothing points at ogkit" do
  get "/pricing"
  assert_includes response.body, %(property="og:image" content="https://acme.com/og-card.png")
  assert_not_includes response.body, "ogkit.dev"
end

test "a staging host never leaks into og:image" do
  with_ogkit { host! "staging.acme.com"; get "/pricing" }
  assert_not_includes response.body[/og:image" content="([^"]+)"/, 1], "staging"
end
```

Rails + Inertia: the Blade/ERB layout still owns `<head>`. Pull headline and subline from the SSR-rendered head (`inertia_ssr_head`, parsed with Nokogiri) so pages need no extra props, and never add og:image inside a React `<Head>`.

## Laravel

Use the package. `composer require ogkit/ogkit-laravel`, `OGKIT_API_KEY=` in `.env`, then in the layout:

```blade
<head>
    @ogPreview
    @ogMeta($title, $description, $canonicalUrl)
</head>
<body>
    {{-- page --}}
    @ogTemplate
        <div style="width:1200px;height:630px;...">...</div>
    @endOgTemplate
</body>
```

Wildcard keys: set `OGKIT_SECRET_KEY` and the package signs automatically. Cache version: the package has no `ogv` concept, so pass `$canonicalUrl . '?ogv=' . config('ogkit.cache_version')` as the third argument to `@ogMeta` and add that config key. Inertia: `->withViewData(['ogTitle' => ..., 'ogDescription' => ...])` from the controller and gate the template on `isset($ogTitle)`. Full guide: https://ogkit.dev/docs/laravel.md

## Next.js (App Router)

Say this first: Next.js ships `opengraph-image.tsx` natively, and file-based metadata overrides `generateMetadata`. To use OG Kit, delete every `opengraph-image.*` and `twitter-image.*` file. Confirm with the user.

`lib/ogkit.ts`:

```ts
const HOST = "https://acme.com"

export function ogkitImageUrl(path: string): string | null {
  const key = process.env.OGKIT_API_KEY
  if (!key) return null
  const page = new URL(path, HOST)
  page.searchParams.set("ogv", process.env.OGKIT_CACHE_VERSION ?? "v1")
  page.searchParams.set("ogkit-render", "1")
  return `https://ogkit.dev/img/${key}.jpeg?url=${encodeURIComponent(page.toString())}`
}
```

In each page's `generateMetadata` (or a shared helper that every public page calls):

```ts
const image = ogkitImageUrl("/pricing") ?? `${HOST}/og-card.png`
return {
  title, description,
  alternates: { canonical: `${HOST}/pricing` },
  openGraph: { title, description, url: `${HOST}/pricing`, images: [{ url: image, width: 1200, height: 630, alt: headline }] },
  twitter: { card: "summary_large_image", title, description, images: [image] },
}
```

Root layout (server component): render `<template data-og-template>` at the end of `<body>` with the headline and subline read from the same source `generateMetadata` uses (a route segment config, a shared page registry, or `headers()`). Preview script: `{process.env.NODE_ENV === "development" && <script defer src="https://cdn.jsdelivr.net/npm/ogkit@1" />}`. Gate analytics on the `ogkit-render` search param via `searchParams` in the page or a small client component that checks `window.location.search`. Vercel: production must not have Deployment Protection on the canonical host.

## Astro

`src/lib/ogkit.ts` mirrors the Next.js helper with `import.meta.env.OGKIT_API_KEY`. In the layout: canonical is `new URL(Astro.url.pathname, Astro.site)`, encode with `encodeURIComponent`, development check is `import.meta.env.DEV`. Static output has no runtime env, so the key and cache version are build-time values from `.env`; bumping the version means a rebuild.

## Django

`templatetags/ogkit.py`:

```python
import os
from urllib.parse import quote
from django import template

register = template.Library()
HOST = "https://acme.com"

@register.simple_tag
def ogkit_image_url(path):
    key = os.environ.get("OGKIT_API_KEY")
    if not key:
        return ""
    sep = "&" if "?" in path else "?"
    page = f"{HOST}{path}{sep}ogv={os.environ.get('OGKIT_CACHE_VERSION', 'v1')}&ogkit-render=1"
    return f"https://ogkit.dev/img/{key}.jpeg?url={quote(page, safe='')}"
```

Template: `{% load ogkit %}{% ogkit_image_url request.path as og_image %}` then `{{ og_image|default:"https://acme.com/og-card.png" }}`. Development check: `{% if debug %}` requires the `debug` context processor and `INTERNAL_IPS`; a `settings.DEBUG` value passed through a context processor is more reliable. Render check: `request.GET` contains `ogkit-render`.

## Express, Fastify, Hono with a template engine

Same helper as Next.js in `lib/ogkit.js`. Put the image URL and `isOgkitRender = "ogkit-render" in req.query` on `res.locals` in one middleware so every view sees them. Development check: `process.env.NODE_ENV !== "production"`. Encode with `encodeURIComponent`.

## Hugo

`layouts/partials/ogkit.html`:

```go-html-template
{{ $key := site.Params.ogkitApiKey }}
{{ if $key }}
  {{ $page := printf "%s?ogv=%s&ogkit-render=1" .Permalink (site.Params.ogkitCacheVersion | default "v1") }}
  {{ $img := printf "https://ogkit.dev/img/%s.jpeg?url=%s" $key ($page | urlquery) }}
  <meta property="og:image" content="{{ $img }}">
  <meta name="twitter:image" content="{{ $img }}">
{{ else }}
  <meta property="og:image" content="{{ "og-card.png" | absURL }}">
{{ end }}
{{ if hugo.IsDevelopment }}<script defer src="https://cdn.jsdelivr.net/npm/ogkit@1"></script>{{ end }}
```

Key and version live in `config.toml` under `[params]`; `.Permalink` already uses `baseURL`, so set `baseURL` to the canonical production host. Headline is `.Title`, subline is `.Description | default .Summary`, both clamped with `truncate`.

## Jekyll

In `_config.yml`: `ogkit_api_key:` and `ogkit_cache_version: v1`. In the head include:

```liquid
{% if site.ogkit_api_key %}
  {% capture page_url %}{{ page.url | absolute_url }}?ogv={{ site.ogkit_cache_version }}&ogkit-render=1{% endcapture %}
  {% capture og_image %}https://ogkit.dev/img/{{ site.ogkit_api_key }}.jpeg?url={{ page_url | url_encode }}{% endcapture %}
{% else %}
  {% capture og_image %}{{ "/og-card.png" | absolute_url }}{% endcapture %}
{% endif %}
{% if jekyll.environment == "development" %}<script defer src="https://cdn.jsdelivr.net/npm/ogkit@1"></script>{% endif %}
```

Eleventy is the same shape with a custom `urlencode` filter added in the config file.

## SPAs and anything client-rendered

OG Kit reads the template after JavaScript runs, so a React, Vue or Svelte component may render `<template data-og-template>` itself. The meta tags may not: social scrapers do not execute JavaScript, so og:image must be in the HTML the server sends. If the app has no server rendering at all, put the meta tags and template in the static `index.html` shell with a fixed headline per route via a small server rewrite, or use a prerender step. Say plainly when a stack cannot serve per-page meta tags; OG Kit cannot fix that.
