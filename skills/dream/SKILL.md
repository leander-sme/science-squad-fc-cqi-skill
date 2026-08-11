---
name: dream
description: Review recent Claude sessions and propose updates to the user's memory files — new facts worth keeping, corrections, stale or wrong notes, and duplicates. Produces a report they approve by clicking. Runs automatically once each morning; can also be invoked by hand. Proposes, never rewrites memory without approval.
---

# Dream

Distil what happened across recent sessions into durable memory, so the next day's
sessions start better informed than today's did.

Runs unattended most mornings. Assume nobody is watching: never ask a question, never
wait for input. Produce the report and stop.

## The memory layout

Learn this before proposing anything.

| Thing | Where |
|---|---|
| Memory files | `~/.claude/projects/<project-dir>/memory/` |
| Index | `MEMORY.md` in that same directory |
| Standing rules (**never edit**) | `~/CLAUDE.md`, `~/.claude/rules/*.md`, any project `CLAUDE.md` |

`<project-dir>` is a slug of the working directory, so find it rather than assuming it:
`ls ~/.claude/projects/*/memory/MEMORY.md`. If more than one comes back, use the one
whose slug matches the home folder — that is the personal memory. Never write into a
different project's memory directory.

One fact per file. Filename is a kebab-case slug matching the `name:` field. Frontmatter:

```
---
name: <short-kebab-case-slug>
description: <one line, used to judge relevance during recall>
metadata:
  type: user | feedback | project | reference
---
```

Body holds the fact. For `feedback` and `project` types, follow it with **Why:** and
**How to apply:** lines. Cross-link related memories inline with `[[wikilinks]]`.

`MEMORY.md` is an index and nothing else — one line per memory, `- [Title](file.md) — hook`,
grouped under `##` category headings. It never holds memory content and has no frontmatter.
Every file needs exactly one index line; every index line needs a file.

## Steps

**1. Set the window.** Read `~/.claude/dream/last-run`. Use the date it holds as the
start of the window. If it is missing, use yesterday.

**2. Extract.** `python3 ~/.claude/skills/dream/extract.py <YYYY-MM-DD>` — returns
the user's own messages across every session in the window, oldest first, as JSON.
Read the script's output, not the raw transcripts. Raw `.jsonl` files are enormous and
reading them directly will exhaust the context for no benefit.

**3. Read what already exists.** Read `MEMORY.md` in full — it is the index and it is
short. Then open only those individual memory files a candidate proposal actually
touches. Do not read the whole memory directory.

**4. Judge.** Look for:

- **Corrections** — they told me I had something wrong, or overrode an approach. These
  are the highest-value finds; they are what stops the same mistake recurring.
- **Repetition** — a fact, preference or constraint stated more than once.
  Once is a candidate, twice is a memory.
- **Stale or wrong** — an existing memory contradicted by something in the window, or
  describing a tool, path or project state that has since changed.
- **Duplicates** — two memories covering the same ground, or two that disagree.
- **Cross-session patterns** — something visible only by looking across several
  sessions at once. This is the whole reason dreaming exists; a single session's
  agent cannot see these. Look for them deliberately.

Do **not** propose:

- Anything already recorded in `CLAUDE.md`, `.claude/rules/*.md`, git history, or the
  code and vault themselves
- Anything that only mattered inside one conversation
- Task completions, or a narration of what was done — those are handover material,
  not memory

Convert every relative date to an absolute one.

**5. Auto-apply only tiny safe fixes.** Without asking: typos, broken `[[wikilinks]]`,
and `MEMORY.md` index lines pointing at a file that no longer exists. Nothing else.
List what was auto-applied in the report so it can be seen.

Never edit `~/CLAUDE.md` or `.claude/rules/*`. Where one of those needs changing, raise
it in the report as a by-hand job.

**6. Write the report.** Build it as an artifact — see `report.md` in this skill
directory for the required structure and the decisions-file contract. Save a copy of
the proposals to `~/Dream Reports/<date>.json` first, so nothing is lost if
publishing fails.

The Save button must write via `window.showSaveFilePicker` into `~/Dream Reports/`, not
via a download — macOS blocks Claude Code from reading `~/Downloads`, so a downloaded
decisions file can never be read back. `report.md` has the exact code. When handing over,
say the dialog will open in `Dream Reports` and they just press Save. Saying the
choices in the chat always works too — never offer the button as the only route.

**7. Stamp.** Write today's date to `~/.claude/dream/last-run`.

## Applying decisions

When they come back with a decisions file (`~/Dream Reports/dream-decisions-<date>.json`)
or pasted decisions: apply every approved proposal exactly as written in the report,
update `MEMORY.md` index lines to match, and report what changed in one short list.
Apply nothing that was rejected, and nothing that was not in the report.

## How to word everything

Assume an expert in their own subject who is not a computing specialist. The report is
read at the start of the day, quickly.

- No unexplained jargon. If a technical term genuinely earns its place, gloss it in
  plain words the first time it appears — "a hook (a rule that makes something run
  automatically at a set moment)". Don't gloss the same term twice.
- Prefer the ordinary word: "file" not "artefact", "runs automatically" not "executes",
  "saved note" not "memory object".
- Say what a change means for them, not what it is structurally. Not "DELETE node with
  stale frontmatter" but "Remove this note — it says your GitHub token only works for
  SaveMyExams, which stopped being true when you added the second account."
- One or two sentences per proposal. If it needs more, it is probably two proposals.
- No filler, no apologising, no restating the question back.

## Done when

- Every proposal names its type, its target file, its `MEMORY.md` index change, and
  carries a short verbatim quote from the transcript as evidence
- No memory file has been changed except the tiny safe fixes listed in the report
- `CLAUDE.md` and `.claude/rules/*` are untouched
- The report is published and its URL reported
- `~/.claude/dream/last-run` holds today's date
