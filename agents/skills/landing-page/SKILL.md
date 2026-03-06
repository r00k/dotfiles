---
name: landing-page
description: "Builds minimal, high-taste landing pages for new product ideas. Use when asked to create a landing page, splash page, or signup page for a new project."
---

# Landing Page Builder

Builds minimal, polished single-page landing sites for new product ideas.

## Design Principles

- **Minimalist above all.** One page, one CTA. Eyebrow → headline → subtext → email form → footnote. No feature grids, no testimonials, no pricing sections.
- **No navbar, no footer.** Just centered content.
- **No AI buzzwords.** Describe what the product *does*, not what technology it uses.

## Tech Stack

- **Single HTML files** — no build step, no framework, no bundler
- **Tailwind CSS via CDN** (`https://cdn.tailwindcss.com`) with inline `tailwind.config`
- **Google Fonts** loaded via `<link>` tags with `preconnect`
- **Express server** (`server.js`) for the signup API endpoint
- **Resend** for email notifications on new signups
- **Static file serving** via Express (`express.static`)
- **Flat-file storage** (`signups.json`) — no database
- Favicon as inline SVG file (`favicon.svg`)

## Page Structure

### index.html
1. Eyebrow (icon + short audience label)
2. H1 headline with accent-colored key phrase
3. One-sentence value prop paragraph
4. Email signup form (email input + submit button)
5. Low-pressure footnote
6. JS: POST to /api/signup, then redirect to /thanks.html

### thanks.html
- Shares same Tailwind config, fonts, and color scheme as index.html
- Short, personality-forward headline (not "Thank you for signing up!")
- Brief follow-up message
- Back link to home page

### server.js
- Express app serving static files from project root
- POST /api/signup: validates email, appends to signups.json, sends notification via Resend, returns { success: true }

## Workflow

### Step 1: Understand the product
Ask what the product does, who it's for, and what the desired CTA is. Get the one-sentence pitch. Figure out the right aesthetic for this specific product.

### Step 2: Generate the landing page
Create `index.html` with the full structure. Include OG/Twitter meta tags from the start.

### Step 3: Present variations for micro-decisions
When the user needs to choose between options (eyebrow text, icon style, color palette, etc.), create a `variations.html` file that shows all options side-by-side in labeled cards. Let the user pick visually. Then apply their choice to `index.html` and delete the variations file.

### Step 4: Build the confirmation page
Create `thanks.html` matching the same design system.

### Step 5: Wire up the backend
Create `server.js` with Express + Resend. Create `package.json` with only the needed deps.

### Step 6: Create the favicon
Extract or create a simple SVG icon related to the product domain. Save as `favicon.svg`.

### Step 7: Iterate on copy
Expect rapid small changes. Apply them immediately. If he says "revert," undo the last change instantly.

### Step 8: Ship
When Ben says "ship," commit and push. Use descriptive commit messages. Only stage files related to the current change.

## OG / Social Previews

- Always include `og:title`, `og:description`, `og:image`, `og:type`
- Always include `twitter:card` (summary_large_image), `twitter:title`, `twitter:description`, `twitter:image`

## Anti-Patterns

- No hero images or illustrations
- No multi-section layouts
- No navbar or footer
- No JavaScript frameworks
- No animations beyond hover states
- No database — flat JSON file for signups
