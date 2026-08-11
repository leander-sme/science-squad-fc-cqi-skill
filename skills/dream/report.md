# The dream report

The report is an artifact — a private web page on claude.ai only its owner can see unless
they share it. They read it, click Keep or Skip on each proposal, then press the save
button. That produces a small file I read back to apply their decisions.

Publish with `capabilities: {downloads: true}` and favicon `🌙` (keep the same favicon
every day — the tab is found by its icon). Write the page to
`~/Dream Reports/<date>.html`, then publish that path.

Point them at the report by its visible name — **the `Dream Reports` folder in the
home folder** — never by the `~/.claude/...` path. That folder is hidden in Finder, so
naming it sends them looking for something they cannot see.

Title: `Dream — <D Month YYYY>`, e.g. `Dream — 6 August 2026`.

## Structure

**Top line.** One sentence, plain: how many sessions were looked at, over what dates,
and how many proposals came out. Then anything auto-fixed, as a short list — or "Nothing
needed fixing automatically."

**Proposals.** One card each, numbered, in descending order of how much difference it
would make. Each card carries:

- A plain-English heading — what the change does, not what it is
- A badge: **New note** / **Update** / **Remove**
- The file it touches, and the line that would change in the index
- The evidence: a short verbatim quote of what the user actually said, with its date.
  Quote them, never me. If the only evidence is my own summary of a conversation, the
  proposal is not strong enough — drop it.
- For a new note, the full proposed text, so they are approving the actual words
- Keep / Skip buttons, neither pre-selected — they choose both ways explicitly

**By hand.** A closing section for anything that needs changing in `CLAUDE.md` or
`.claude/rules/*`, which I never touch. Say what needs to change and where. Omit the
section entirely if there is nothing.

## Design

Dark navy/slate. Readable at speed: generous spacing, clear card boundaries, the badge
colour-coded (new = green, update = amber, remove = red). Must work on a phone. Respect
the viewer's light/dark toggle — style both, dark as the default.

## The save button

One button at the bottom: **Save my decisions**. It writes

- `filename`: `dream-decisions-<YYYY-MM-DD>.json`
- `data`: `{"date": "<YYYY-MM-DD>", "decisions": [{"id": 1, "keep": true}, ...]}`

Include every proposal, including untouched ones (`"keep": null`).

**Use `window.showSaveFilePicker`, not a download.** A browser download always lands in
`~/Downloads`, and macOS blocks Claude Code from reading that folder — so the decisions
file arrives somewhere it can never be read. The file picker lets them choose
`Dream Reports` instead. Pass `id: 'dreamReports'` so Chrome reopens the dialog in the
same folder every time; after the first save they only have to press Save.

```js
const h = await window.showSaveFilePicker({
  id: 'dreamReports',
  suggestedName: filename,
  types: [{description: 'Dream decisions', accept: {'application/json': ['.json']}}]
});
const w = await h.createWritable();
await w.write(JSON.stringify(data, null, 2));
await w.close();
```

Keep a plain `Blob` + `a.download` fallback for browsers without the picker, but say in
its success message that Downloads may be unreadable. Cancelling the dialog throws
`AbortError` — report that as *"Save cancelled — nothing was written"*, never as a
failure.

After a successful save, show: *"Saved. Tell Claude 'apply my dream decisions'."*

## Applying them

`~/Dream Reports/dream-decisions-<date>.json` is the input. If it is not there, check
`~/Downloads/` too — but macOS may block Terminal from `~/Downloads`, and a permission
block returns `Operation not permitted`, not `No such file`, so it says nothing about
whether the file exists. Never report the file as missing on the strength of that error.
Pasted decisions in the chat are an equally valid input.

Apply every `keep: true`
proposal exactly as the report worded it, update the `MEMORY.md` index to match, and
leave `keep: false` and `keep: null` alone. Then say in one short list what changed.
