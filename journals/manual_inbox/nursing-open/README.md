# Nursing Open manual official-page inbox

Wiley blocks automated access to Nursing Open pages with a Cloudflare challenge. Use this folder to place official pages saved through a normal browser session.

## Pages to save

Open each page in your browser, wait until the real Wiley page loads, then save it as either complete HTML or PDF:

1. `https://onlinelibrary.wiley.com/journal/20541058`
2. `https://onlinelibrary.wiley.com/page/journal/20541058/homepage/author-guidelines`
3. `https://onlinelibrary.wiley.com/page/journal/20541058/homepage/open-access`

Recommended filenames:

- `nursing-open-journal-page.html`
- `nursing-open-author-guidelines.html`
- `nursing-open-open-access.html`

After the files are placed here, import them with:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/import-manual-journal-page.ps1 -Slug nursing-open -Url "https://onlinelibrary.wiley.com/page/journal/20541058/homepage/open-access" -FilePath "journals/manual_inbox/nursing-open/nursing-open-open-access.html"
```

The import script copies the page into `journals/raw_pages/nursing-open/` and records it as `manual_ok` in `journals/official-source-log.csv`.
