# Science Squad Skills

Shared Claude Code skills for the Save My Exams Science Squad.

One skill so far — **`cqi-flashcard`** — plus the two agents it depends on. More will follow the same layout.

---

## What's here

```
skills/
  cqi-flashcard/
    SKILL.md                              the procedure — run this
    reference/
      flashcard-cqi-reference.md          the rubric — the substance of the review
      sensitivity-cqi-reference.md        the Sensitive criterion in depth
agents/
  spec-grounder/AGENT.md                  mandatory gate, step 3a
  cqi-verifier/AGENT.md                   mandatory gate, step 6
install.sh                                copies the skills and agents into ~/.claude/
```

The two agents are **not optional**. `cqi-flashcard` halts at step 3a and again at step 6 without them, because no spec claim may be scored until `spec-grounder` has adjudicated it against the syllabus, and no review reaches Leander without `cqi-verifier` having tried to break it first.

---

## Install

Public, so you need no GitHub account and no invitation to read it — just `git`:

```bash
git clone https://github.com/leander-sme/science-squad-skills.git ~/science-squad-skills
cd ~/science-squad-skills
./install.sh
```

To open a PR against it you do need a GitHub account of your own, and `git` authenticated as you — `gh auth login` if you have the GitHub CLI, otherwise an SSH key or a personal access token.

If the clone ever comes back `Repository not found`, that is almost always access rather than a missing repo — GitHub returns 404 rather than 403 for a private repo you cannot see. If this has gone private since, ask Leander for an invitation.

Then restart Claude Code and check it registered:

```
/cqi-flashcard
```

`install.sh` copies `skills/*` into `~/.claude/skills/` and `agents/*` into `~/.claude/agents/`. It refuses to overwrite an existing folder unless you pass `--force`, so a local version you have been editing is never silently clobbered.

To update later: `git pull && ./install.sh --force`.

---

## cqi-flashcard — before your first run

The skill's own *What you need before your first run* table is the authority — this is the short version.

| You need | For |
|---|---|
| **`sme-content` MCP** | Fetching sets, cards and revision notes. Nothing works without it |
| **`notebooklm` MCP** | The syllabus authority behind every scope, coverage and tier claim |
| **The course's PP Checker notebook** | [Registry on Notion](https://www.notion.so/save-my-exams/PP-Checkers-293847b30a5f80488aa5c382bdfd85b9). No notebook for your course? `/pp-checker` builds one |

The review writes a Markdown report to a **`CQI Reports`** folder in your home folder — one file per review, and that file is the record. Nothing is logged centrally: what gets recorded against a set is a **pass or a fail**, not a score, and the score exists to tell you how much editing gets you there.

The Development Editor Obsidian vault is **not** required. It gives you a second index over the report. The skill says where the vault step is optional.

---

## cqi-flashcard — running it

```
/cqi-flashcard flst_xxxxxxxxxxxx        # one set
/cqi-flashcard CIE IGCSE Co-ordinated Sciences 0654    # course sweep, 10% sampled
```

A single set is about half an hour. A course sweep is a few hours and 80–120k tokens — the skill quotes the cost and waits for a go-ahead before it starts.

---

## cqi-flashcard — two things that surprise people

**It never edits anything** — including when the set is your own. Not Cobalt, not a typo it passes on the way. A review produces findings, scores and a paste-ready fix list, and stops. Most sets in the estate are published, so an edit goes live immediately and lands in every course referencing the set. Then you edit, as a separate deliberate pass: a reviewer who fixes as they read stops reviewing, and the set comes out passing because it was edited rather than because it was good.

**It never stops to ask.** Anything you cannot settle gets scored on your best call and parked in the report's `Queries` section, with what changes if Leander overturns you. She reads that section once at the end. Only three stops are permitted in a whole review, and the skill names them. If your run came back with questions in it, it did not follow the skill.

---

## dream — moved

`dream` used to live here. It is now its own repo, so it can be shared with anyone
without carrying the CQI rubric along with it:

**https://github.com/leander-sme/claude-dream**

---

## Changing a skill

Rulings are batched to the end of a run, never applied mid-review — a skill that changes between two batches has scored two batches by two different rubrics.

Once Leander has ruled, open a PR. Where a ruling touches both the procedure and the rubric, change **both in the same commit**, and grep for the older contradicting line before adding the new one. A new rule sitting next to a stale one is worse than no rule at all.

The `reference/` copies of the rubric are now the master copies. Do not edit them in Obsidian and expect the change to reach anyone.
