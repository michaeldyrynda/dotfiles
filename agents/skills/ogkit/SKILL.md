---
name: ogkit
description: Add per-page Open Graph images to any website with OG Kit (ogkit.dev), in any framework or language. Detects the stack, writes an OG template that reuses the site's own fonts, colors and logo, wires the og:image and twitter:image meta tags to ogkit.dev, adds the dev-only preview script, verifies the card with ?ogkit-render, and hands the user the short list of things only they can do (create the API key, set it in production, bump the cache version). Use whenever the user says "ogkit", "OG Kit", "og image", "open graph image", "social preview image", "social card", "link preview", "twitter card", "dynamic og:image", "our links look bad when shared", or wants per-page share images without running a headless browser themselves. Harness-agnostic, so it works in Claude Code, Codex, Cursor and any other agent host.
argument-hint: [api-key]
---

# OG Kit

OG Kit (https://ogkit.dev) turns a `<template data-og-template>` block on a page into that page's Open Graph image. Its browser fetches the page, swaps the body for the template at 1200x630, screenshots it, and serves the JPEG from `https://ogkit.dev/img/KEY.jpeg?url=ENCODED_PAGE_URL`. No image library, no headless Chrome in your stack. The card is plain HTML rendered with the site's own CSS and fonts, which is why it matches the brand.

You are implementing this, not explaining it. The user should only have to create the API key. Everything else lands in their code.

Arguments: `$ARGUMENTS`. If it contains an API key, use it and skip the key question.

## How the renderer behaves (design around this)

- It fetches the page with user agent `OGKit/1.0 (+https://ogkit.dev)` and gives it 30 seconds.
- It reads `template.innerHTML`, replaces `document.body.innerHTML` with `<div style="height:630px;width:1200px">` + template, and strips the `class` and `style` attributes from `<body>`. Body backgrounds vanish. The template must paint its own.
- The `<head>` stays, so stylesheets and `@font-face` rules still apply inside the template. It waits for images and for `document.fonts.ready`, capped at about 1.2 seconds.
- It renders on Ubuntu. Generic `font-sans` / `font-serif` fall back to Ubuntu system fonts, not the macOS ones the user sees locally.
- It caches an image per URL forever. Errors (missing template, timeout, Cloudflare challenge) are cached for 1 hour.
- The `?ogkit-render` query parameter is a presence check. `?ogkit-render` and `?ogkit-render=1` both trigger it.

## Step 0: Ask only what the repo cannot tell you

Look before you ask. Grep env files, credentials and config for `OGKIT_API_KEY` first. Then ask at most these three questions, in one message, skipping any you already know:

1. **API key.** Created at ogkit.dev under API Keys, locked to the production host (`example.com`, not `www.example.com` unless that is canonical). The key is public: it ships inside the og:image URL. A wildcard `*` key is a Pro feature and needs a server-side secret and an HMAC signature. Ask for the key or tell the user to create one now.
2. **Which pages.** Default: every public, server-rendered page (home, marketing, pricing, blog, docs, guides). Never authenticated app pages. Never pages whose URL carries a token (unsubscribe, confirm, magic links), because the URL is sent to a third party.
3. **Cutover.** Default: point og:image at OG Kit now, with the existing static image as the fallback when the key is unset. Cautious option: ship the template only, keep the current og:image, check `https://ogkit.dev/img/KEY.jpeg?url=...` by hand, flip the meta tags later.

Do not ask about the design. Derive it from the site.

## Step 1: Read the stack

Find and note, before writing anything:

- Framework and templating language. Where `<head>` lives (the layout). How title, meta description and canonical URL are set today, and by whom (controller, frontmatter, `generateMetadata`, a `Head` component).
- The existing og:image and twitter:image tags. There must be exactly one place that emits them afterwards. A layout and a React `<Head>` both emitting og:image is the most common bug.
- The environment-detection idiom (`Rails.env.development?`, `@env('local')`, `process.env.NODE_ENV`, `import.meta.env.DEV`, `hugo.IsDevelopment`) and the env-var convention (`.env`, `.env.example`, credentials).
- Which webfonts the layout actually loads, by family name. The canonical production host. The logo as SVG. Brand colors and one distinctive visual motif (dot grid, corner marks, a dark footer band, a border style).
- Anything in the layout that must not run during the OG Kit fetch: analytics, chat widgets, cookie banners, visitor identification.
- Is the site behind Cloudflare with a challenge? Is it a Next.js app that already has `opengraph-image.tsx`?

**Laravel:** use the official package, `composer require ogkit/ogkit-laravel`, with `@ogTemplate`, `@ogMeta` and `@ogPreview`. Do not hand-roll it. Guide: https://ogkit.dev/docs/laravel.md

**Next.js:** the framework already ships a native alternative (`opengraph-image.tsx` with `ImageResponse`), and file-based metadata overrides `generateMetadata`, so existing `opengraph-image.*` files must be removed for OG Kit to take effect. Say this to the user before touching it. OG Kit wins when they want real CSS, real webfonts and real components instead of Satori's flexbox subset.

Read `references/stacks.md` for the exact idioms of the detected stack.

## Step 2: One helper that builds the image URL

Write one function, in the language of the stack, and call it from the layout. It encodes every rule below. Do not inline this logic in a template.

```
ogkit_image_url(page_url):
  key = env OGKIT_API_KEY;  return null if blank        # null means: use the static fallback
  versioned = page_url + (has "?" ? "&" : "?") + "ogv=" + env OGKIT_CACHE_VERSION (default "v1") + "&ogkit-render=1"
  return "https://ogkit.dev/img/" + key + ".jpeg?url=" + urlencode(versioned)
```

- `page_url` is the canonical URL on the production host. Never the request host. A staging or preview hostname inside og:image makes OG Kit render a page nobody should see, and the image is then cached forever against it.
- `ogv=` is the cache lever. OG Kit caches per URL forever, so a template edit only reaches already-shared links when the URL changes. Bumping `OGKIT_CACHE_VERSION` regenerates every card.
- `ogkit-render=1` marks the fetch so the layout can skip analytics and widgets (Step 5). Presence is what matters.
- No key means the static fallback. Development, test and CI then never touch ogkit.dev.
- Wildcard keys: `signature = HMAC-SHA256(secret, versioned)` over the raw page URL, appended as `&signature=`. Sign the page URL, never the ogkit.dev URL. Secret stays on the server.
- Return null for token-bearing pages (Step 0, question 2).

## Step 3: Meta tags

In the layout, emit once, using the helper result or the static fallback:

```html
<meta property="og:image" content="IMAGE_URL">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta property="og:image:alt" content="HEADLINE">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:image" content="IMAGE_URL">
```

Keep the existing og:title, og:description, og:url and twitter:title tags. Remove og:image from anywhere else it was emitted. The image must be `.jpeg`; no other format exists.

## Step 4: The template

Put `<template data-og-template>` at the end of `<body>` in the same layout, gated on the same condition as the ogkit meta tag. Rules learned from shipping this on several sites:

- **Root element is 1200x630 and paints its own background.** `width:1200px;height:630px;box-sizing:border-box;overflow:hidden;background:...`. The body's classes are gone at render time.
- **Inline styles, not utility classes.** The stylesheet is inherited, so `@font-face` works and `font-family:'Manrope'` resolves. But utility classes are a gamble: purged by the CSS build, or responsive, or scoped to a component the layout never renders. Fixed pixel values in `style=""` render identically in the user's browser and in OG Kit's.
- **Name the real font.** Use the family the site loads (`font-family:'Bricolage Grotesque',ui-sans-serif,system-ui,sans-serif`). Never a bare generic family.
- **Inline the logo SVG.** Read the file server-side, strip the XML prolog and `<defs>`, fold `class="cls-1"` into `fill="#hex"`, set explicit width and height. No `<img src="/logo.svg">`: OG Kit never promises how a relative path resolves.
- **Headline and subline are the only dynamic parts.** Headline is the page title with the brand suffix stripped (`"Pricing | Acme"` becomes `"Pricing"`; a bare brand-only title becomes a default tagline). Subline is the meta description cut at a sentence boundary, never mid-clause. Both come from the same values the `<head>` already uses, so a new page needs no extra wiring.
- **Clamp twice.** Cut the strings server-side to what fits (roughly 60 to 85 characters for a 64 to 72px headline, 120 to 130 for a 27 to 29px subline) and give each block `max-height` plus `overflow:hidden` in case a wrap lands worse than the count says. Test with the longest title on the site.
- **Unescape once.** Values that already passed through HTML escaping (Rails `content_for`, for example) must be unescaped before the template escapes them again, or an apostrophe renders as `&#39;`.
- **Match the site, do not redesign it.** Same font, same two or three brand colors, one motif the site already uses, the domain in a footer or corner. The card should look like a crop of the website. Do not introduce gradients, new colors or a new typeface.
- **Everything the template needs must be reachable from the page.** Fonts via the layout's `<link>` or `@font-face`, images via absolute URLs or inline SVG.

Keep the template small. Logo, headline, subline, footer band. A card that reads at thumbnail size beats one that shows off.

## Step 5: Preview script and a quiet fetch

Add the preview script in development only:

```html
<script defer src="https://cdn.jsdelivr.net/npm/ogkit@1"></script>
```

Production needs no script; OG Kit injects its own. Then wrap analytics, chat widgets, cookie banners and visitor identification in a `not ogkit render request` check (the `ogkit-render` query param is present). Otherwise every card render counts as a pageview, and a chat bubble or cookie bar ends up in the screenshot.

## Step 6: Env, tests, docs

- `.env.example`: `OGKIT_API_KEY=` (comment: public, domain-locked; unset falls back to the static image) and `OGKIT_CACHE_VERSION=v1` (comment: bump after editing the template).
- Test setup deletes both vars so the fallback path is the deterministic default. Add tests where the project has them: key set renders the ogkit URL of the canonical page with `ogv` and `ogkit-render=1`; key unset renders the static fallback and nothing points at ogkit.dev; a staging request host never leaks into og:image; the render request omits tracking scripts.
- Add three lines to the project's agent instructions file (`CLAUDE.md`, `AGENTS.md`, or equivalent): cards come from the template in the layout; bump `OGKIT_CACHE_VERSION` after editing it; preview with `?ogkit-render`; never emit og:image anywhere else.

## Step 7: Verify, in a browser, before you say it works

1. Start the dev server. Open a public page with `?ogkit-render` appended. The body must be replaced by the card at 1200x630.
2. Check the webfont loaded (not a fallback), the logo drew, nothing overflows. Repeat with the page that has the longest title and the one with the longest description. Take a screenshot if a browser tool is available and show it.
3. View source of a page. `og:image` and `twitter:image` must be identical and appear once. Decode the `url` parameter: canonical host, `ogv=v1`, `ogkit-render=1`.
4. Run the test suite.
5. If the key is already in the local env and the page is deployed, open `https://ogkit.dev/img/KEY.jpeg?url=ENCODED_URL` directly and look at the JPEG.

Do not report success from reading the code.

## Step 8: Hand-off

End with a short numbered list of what remains for the user. Only the items that apply:

1. Create the API key at ogkit.dev (API Keys, domain = production host) if not done.
2. Set `OGKIT_API_KEY` and `OGKIT_CACHE_VERSION=v1` in the production environment (name the host: Heroku, Hatchbox, Vercel, Fly, Railway, and so on). Staging gets no key, or its own key.
3. Deploy, then open `https://ogkit.dev/img/KEY.jpeg?url=ENCODED_CANONICAL_URL` once and check `https://ogvalidator.com/?url=example.com`.
4. Behind Cloudflare with challenges: add a WAF custom rule, User Agent contains `OGKit`, action Skip.
5. After any future edit to the template, bump `OGKIT_CACHE_VERSION`. Social platforms cache separately; share a URL with `?v=2` or use their debug tools to refresh.
6. Plan limits: free is 25 pages, Basic 1,000, Pro 10,000 plus wildcard keys. A page is one unique URL.

## Gotchas

- A missing-template or timeout error is cached for 1 hour against that URL. Bump `ogv` to retry immediately.
- The page must be publicly reachable. Basic auth, Vercel deployment protection, or a staging allowlist means no image.
- Each key is locked to one host. `blog.example.com` needs its own key or a wildcard key.
- Static sites (Hugo, Jekyll, Astro static, Eleventy) have no runtime env. The cache version becomes a site-config constant and the canonical URL comes from the site's base URL setting. See `references/stacks.md`.
- SPAs: the template may be rendered by client-side JavaScript (OG Kit reads it after scripts run), but the meta tags must be in the server-rendered HTML, because social scrapers do not run JavaScript.
