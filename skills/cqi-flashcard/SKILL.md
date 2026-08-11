---
name: cqi-flashcard
description: Run a CQI review on a Cobalt flashcard set — score against the 10 criteria, ground against the revision note, and produce a scored report and fix list. Report-only, never edits.
user_invocable: true
arguments: "[flst_… | subtopic name | course + topic]"
---

# Flashcard CQI

Review a flashcard set against the 10 CQI criteria. Produce findings, a score and a paste-ready fix list — and stop.

## New to this skill? Read this first

**What it does.** Given a flashcard set ID — or a course, for a sampled sweep — it scores each set out of 50 against the CQI criteria, grounds every spec claim against the syllabus, writes a report with a paste-ready fix list, and identifies **author themes**: defects that recur across everything one author has made. The themes are the point. A fix list mends one set; a theme prompt lets an author sweep their whole back catalogue.

**Roughly how a run goes.** Resolve the set → size the sample if it is a course sweep → open the syllabus notebook → fetch cards → check them against the revision note → send the spec claims to `spec-grounder` → score → write the report → run `cqi-verifier` → report themes. On a single set that is about half an hour. A course sweep is a few hours and a lot of tokens.

> [!info] 🎯 You are most likely reviewing your own set
> The Development Editor no longer runs flashcard CQIs centrally — **authors run this skill on their own sets**. The score is the thing you work to: review, get the number, edit until it passes. Nothing is logged to a central record; the verdict that gets recorded is a **pass or a fail**, not a score.
>
> That does not soften the report-only rule below, and the reason is worth understanding. **Review first, edit second, and never in the same pass.** A reviewer who fixes as they read stops reviewing — they score the card they have just mended rather than the card the student saw, and the set comes out passing because it was edited, not because it was good. Finish the review, close it, *then* open a fresh pass and act on the fix list.

**Two habits that are unlike most skills, and both are deliberate:**

- **It never edits anything.** Not Cobalt, not a typo. See the report-only box below — it is the rule the whole skill is built around.
- **It never stops to ask.** Uncertainty gets scored on your best call and parked in a `Queries` section for Leander to read at the end. Only three stops are permitted in a whole review; they are listed below.

> [!info] 👥 Who is who in this document
> **You** are the reviewer running the skill — anyone in the Science Squad.
> **Leander** is the CQI owner. Where this document says a call is "Leander's alone", it means exactly that: you score your best reading, park it under `Queries`, and she decides. Do not read it as "the reviewer's discretion" — those calls are the ones deliberately taken out of the reviewer's hands, so that a review is repeatable between people. Send her the `Queries` section when the review is done; do not wait on it before finishing.

### What you need before your first run

| Requirement | Why | If you don't have it |
|---|---|---|
| **`sme-content` MCP** | `getFlashcardSet`, `findRevisionNote`, `getCourseStructure` | Nothing works. Get it connected first |
| **`notebooklm` MCP** | The syllabus authority for every spec claim | Step 1b tells you how to run *fenced* — but say so in the report |
| **`spec-grounder` + `cqi-verifier` agents** | Two mandatory gates, steps 3a and 6 | Install them from `agents/` in this repo — see the README |
| **The course's PP Checker notebook** | Step 1b | Registry: [PP Checkers on Notion](https://www.notion.so/save-my-exams/PP-Checkers-293847b30a5f80488aa5c382bdfd85b9). If the course has none, `/pp-checker` builds one |

### Proposing a change to this skill

It is shared now, so a ruling you are given mid-run **is not yours to write straight into the file** — that would fork it for everyone else silently. Collect rulings under *Rulings needed* in the closing report (step 5), and once Leander has ruled, open a PR against this repo. Change the skill **and** the rubric in `reference/` in the same commit where a ruling touches both, and grep for the older contradicting line before you add the new one — a new rule sitting beside a stale one is worse than no rule.

> [!danger] 🚫 Report-only. No exceptions.
> **Never write to Cobalt from this skill.** No `updateFlashcard`, no `createFlashcards`, no `updateFlashcardSet` — not even to correct a stray space inside bold markup. The fix belongs to the author. Where a tweak is small enough to make directly rather than send back, that is an **editorial call and it is Leander's alone**. Never make it, never propose making it as part of a review.
>
> **A review that ends in a write is a review that went wrong.**
>
> Most sets in the estate are **published**. An edit goes live immediately and lands in **every** course referencing the set.

> [!danger] 🅿️ Never ask mid-run — park it *(Leander, 30 July 2026)*
> **A CQI is a half-hour job. It stops being one the moment the reviewer needs Leander in the loop to finish a set.** Every uncertainty that surfaces mid-run gets **scored on your best call and written into the `Queries` section** — it never becomes a question in chat, and it never halts the batch.
>
> She reads it once, at the end, and decides which ones she cares about. Most she will ignore, and that is the correct outcome: the section exists so that *not deciding* is free. A question in chat costs her a context switch whether or not it mattered.
>
> **Three stops are permitted in the whole review, all of them before or after the proofing, none of them inside it:**
> 1. the **token go-ahead** before a bulk sweep (step 1a)
> 2. **no reachable notebook** (step 1b) — it degrades every set, so it is settled before the first card
> 3. the **stage A hold** on a staged run (step 1a)
>
> **Everything else parks.** Rendering you cannot see, a spec claim the grounder could not settle, a calibration case the table seems to get wrong, a qualification off the staging list, a theme band — all of it is a `Queries` entry with your call already in it. See *The Queries section* in step 5.
>
> **Rulings are batched to the end of the run, never applied mid-review.** Where Leander's answer to a query would change this skill or the rubric, that is a **post-run edit made once**, after she has ruled on the whole `Queries` section — not a skill rewrite between two batches. Collect them under *Rulings needed* in the closing report and raise the survivors in a single PR (see *Proposing a change to this skill* above, which governs *where* a ruling goes and *who* commits it — this box governs *when*).

## Before you start

Read the rubric. It is the substance of this skill and it is not reproduced here:

**`reference/flashcard-cqi-reference.md`** — bundled alongside this file, in the same skill folder.

Everything below is the *procedure*. The rules — card anatomy, format, absolutes vs conventions, what not to flag — live in that file. **Do not attempt a review without reading it**; the procedure below tells you when to score, not what a good card is.

> [!info] 📌 The CQI Notion page is the source of truth
> The rubric's authority is the CQI Notion page (`6bbed885ff644045846080e43fee1a23`), last revised by Astrid & Caroline **17 July 2026**. Where that page and either the bundled rubric or this skill disagree, **the page wins** — score to the page and flag the divergence to Leander. Key rules from that revision, all applied below: **one defect, one criterion**; alt text and subtitles scored under **Structured**; the Formatted bar raised (a clean page is a 4, layout that actively aids understanding is a 5); Sensitive judged against a **realistic candidate** for the spec rather than a worldwide reader; SEO **not** numerically scored; and AI-assisted content scored against the spec with active scepticism. The CQI does not apply to Stage 5 (SmartMark) or Stage 8 (Project Hero).

## Procedure

### 1. Resolve the set

Given a `flst_…`, go straight to step 2. Otherwise:

- `getCourseStructure` → find the module, topic and subtopic
- `searchFlashcardSets` on the subtopic → get the `flst_…`

### 1a. Size the sample — 10% of the course, stratified

Given a single `flst_…`, this step does not apply. It governs a **course-wide** review.

> [!check] 📐 The sampling rule
> **Sample 10% of the course's flashcard sets**, rounded to the nearest whole set. **There is one set per subtopic**, so the subtopic count *is* the set count — you do not need to enumerate the sets to size the sample.
>
> On a **large advanced course** the 10% is drawn in two stages — **half first, then Leander decides**. See *Staged sampling* below. The target is still 10%; what changes is that the second half is earned rather than assumed.

**Spread the sample proportionally across sections**, and across topics within a section. A clustered sample reads one section, not a course — and it is worthless for the thing sampling is *for*, which is **author themes** (step 7). Themes only surface when the sample crosses enough authors to show that a defect tracks the author rather than the science.

Work out the allocation before fetching anything, and show it to Leander as a table — section · subtopics · sampled — with the total. Proportional rounding usually lands on the target without adjustment; where it doesn't, round the largest remainders up and say which you nudged.

> [!warning] ⚠️ Warn before the sweep — it is a bulk operation
> A 13-set sample is ~13 `getFlashcardSet` calls plus their revision notes, then `spec-grounder` and `cqi-verifier` — realistically **80–120k tokens**. State the size and get a go-ahead *before* starting, not halfway through — a bulk operation always gets warned about before it runs, never after.
>
> On a staged run, quote **both** numbers up front — what stage A costs, and what stage B would add if she calls for it. A go-ahead for stage A is not a go-ahead for stage B.

#### Staged sampling — large advanced courses run half first

A Level courses carry so many subtopics that a flat 10% is a long run of batches, and most of it is spent confirming what the first half already showed. On those courses, draw the 10% and read **half of it** first.

> [!check] 🚦 The gate — both conditions, not either
> Stage the sample when the course is **A Level, International A Level, AP or IB** *and* has **more than 100 subtopics**.
>
> Everything else runs the flat 10% in one pass, exactly as before: GCSE, IGCSE, O Level — **however large they get**. The 127-subtopic Edexcel IGCSE Physics (Modular) below is a flat 13-set review, not a staged one. A large course that isn't on the qualification list, or an advanced course under 100 subtopics, is **not** a staged run; if a qualification genuinely doesn't fit the list, **run flat and park a `Ruling` query** — do not stop to ask, and do not decide the gate in the moment.

**Draw the full 10% plan first, then split it — never draw 5% and top up later.** Allocate across sections as above to get the 10% figure, then walk the sections in order assigning each sampled set alternately to **stage A** and **stage B**, so that *each half is itself spread across the whole course*. Stage A gets the odd one where the total is odd.

This ordering is the whole point. A fresh 5% draw at escalation is not balanced against the first, and a stage A that clustered into three sections tells you nothing about the course — it fails at the one job sampling has, which is surfacing themes across authors. Show both halves in the allocation table, marked A and B, before fetching anything.

> [!danger] 🛑 Stage A ends in a hold, not a decision
> Score stage A, write it up in full, report it — **and stop.** Whether to run stage B is **Leander's call and hers alone**, made off that report. Never roll straight into stage B because the findings looked bad, and never quietly close the review because they looked clean.

**Recommend, then wait.** Close the stage A report with a one-line recommendation and the signals behind it. Escalation is worth it where stage B would change what you can *say*, not merely add sets:

- **a set FAILs** — the sample verdict is already settled (it is a gate; one fail fails it), but stage B is what tells you whether the fail is one author or the course
- **a defect recurs on two sets by one author** — a theme candidate stage B can promote to a 🔴 sweep, or kill
- **a defect appears under two different authors** — that is a course-level issue, not author remediation, and the band changes with it. (0654 round 1 read "no science gets bolding right" off one set per science and recommended a house-wide style bulletin; round 2 added a second set each and showed the defect tracked the **author** — one of whom scored 49/50. The round-1 recommendation was the opposite of the right one)
- **stage A comes back entirely clean** — treat this with suspicion, not relief. All-Pass proves the sample free of *the findings you happened to draft*, not free of defects. Say so plainly rather than presenting it as a clear course

Where every finding is isolated to one set and one author and nothing above fires, recommend stopping. That is the case the staging exists for.

> [!warning] ⚠️ A 5% stop must still read as 5% in six months
> The report's header carries the stage actually completed — `N sets, 5% of Y subtopics` — and says in terms that a clean stage A **clears the sample but is a weaker claim about the course** than a clean 10%. List by name any theme candidate left unresolved by stopping. Otherwise a half review is indistinguishable from a full pass to whoever reads it later.

On escalation, stage B is written up as an ordinary batch (worst first, as always) and folded into the same report, with the header restated as the combined `N sets, 10% of Y subtopics` and the sample summary recomputed over both halves.

#### Counting the subtopics

`getCourseStructure` on a full course **exceeds the token limit** and is written to a file instead. Count from that file — never read it whole:

```bash
python3 - "$f" <<'EOF'
import sys, re
mod=None; counts=[]
for line in open(sys.argv[1]):
    m=re.match(r'^=+ (MODULE|SECTION|SUBTOPIC) \|', line)
    if not m: continue
    name=line.strip().split(' | ')[-1]
    if m.group(1)=='MODULE': mod=name
    elif m.group(1)=='SECTION': counts.append([mod, name, 0])
    else:
        if not counts: counts.append([mod, '(no section)', 0])
        counts[-1][2]+=1
tot=sum(c[2] for c in counts)
assert tot, "0 subtopics matched — the marker format has changed. Stop and check the file."
n=round(tot*0.1)
for m,s,c in counts: print(f"{str(m)[:8]:8} | {s:40} | {c:3} -> {round(c/tot*n,2)}")
print("TOTAL", tot, "| 10% =", n, "| staged: A =", -(-n//2), "B =", n//2)
EOF
```

> [!danger] 🔢 Match the **label**, never the number of `=` signs
> A course **without modules** sits one level shallower all the way down — its sections are `== SECTION` and its subtopics `==== SUBTOPIC`, not `=== SECTION` and `===== SUBTOPIC`. An earlier version of this script matched on depth, so on a module-less course **nothing matched at all and it reported `TOTAL 0`** — silently, as a plausible-looking result. The `=+` above matches any depth and reads the label instead, which is the only part that is stable across both shapes.
>
> **`TOTAL 0` is never a real answer, and it is now an `assert` rather than a printed line.** It used to be worse than a wrong sample size: the staging gate asks whether the course has more than 100 subtopics, so a course counted at 0 fails that test and quietly runs **flat when it should have staged**. A bug in the counter is a bug in the gate.
>
> Two smaller traps folded into the same fix: the module column is `None` on a module-less course and `f"{None:8}"` raises, hence `str(m)`; and subtopics can arrive before any section, hence the `(no section)` bucket rather than an `IndexError`.

The staged split is only *used* where the gate above applies — the script prints it either way, so print it and ignore it on a flat course rather than reworking the script per run.

Three traps, all of which have already cost time:

- **`grep -c '^==== TOPIC'` double-counts.** It also matches `==== TOPIC_QUESTION_SET`. Edexcel IGCSE Physics (Modular) reads as 48 topics that way; it has **24**. Match `'^==== TOPIC \|'`.
- **`searchFlashcardSets` has no course filter.** Counting via `board_slug`+`level_slug`+`subject_slug` sweeps in **sibling courses** — `edexcel/igcse/physics` returns both the Modular and the non-Modular course. Filter by `topic_id` / `subtopic_id`, or count subtopics from the structure instead.
- **awk chokes on `split($0, a, " | ")`** — `|` is regex alternation. Use Python, as above.

#### Worked example — Edexcel IGCSE Physics (Modular), `crs_K3cQMTS97Ncq8zyj`

127 subtopics across 24 topics and 9 sections → **13 sets**, drawn **flat in one pass**. It is over 100 subtopics but it is an IGCSE, and the staging gate needs both — this is the counterexample the gate is written against:

| Section | Subtopics | Sample |
|---|---|---|
| 1. Forces & Motion | 23 | 2 |
| 2. Electricity | 17 | 2 |
| 3. Energy Resources & Energy Transfers | 13 | 1 |
| 4. Solids, Liquids & Gases: Part 1 | 9 | 1 |
| 5. Waves | 17 | 2 |
| 6. Solids, Liquids & Gases: Part 2 | 6 | 1 |
| 7. Magnetism & Electromagnetism | 14 | 1 |
| 8. Radioactivity & Particles | 16 | 2 |
| 9. Astrophysics | 12 | 1 |
| **Total** | **127** | **13** |

#### Check the tier structure before you start

The tier-marker rule is **course-conditional**. CIE 0654, 0620 and the other Core/Extended IGCSEs need `**(Extended Tier Only)**` / `**T**`; an untiered course cannot carry a tier defect at all, and raising one there is a fabricated finding.

Establish the course's tier structure **before** proofing, and never from memory — it is a spec claim, so it goes to **`spec-grounder`** (step 3a) like any other, which means the notebook from **step 1b** must be open first. This is normally the review's *first* notebook query. Where the course is untiered, say so once in the report and record it in *Not flagged*, so the next reviewer does not go looking.

### 1b. Open the syllabus notebook — a setup gate, not a step 3a errand

**Do this before fetching a single card**, on every review including a single-set one. The course's NotebookLM PP Checker is the only syllabus authority this skill has; without it, every spec claim in the review is UNVERIFIED and the review is degraded from the first set to the last. Finding that out at step 3a is finding out too late.

Resolve it in this order and **record the `notebook_id` in the run's working notes**, where it stays in front of you for the whole review:

1. **`notebook_list`** — since 29 July 2026 this reads the logged-in Google account live, so the listing is authoritative about what is reachable
2. **Cross-check the registry** — [PP Checkers on Notion](https://www.notion.so/save-my-exams/PP-Checkers-293847b30a5f80488aa5c382bdfd85b9), the course-to-URL map. A notebook's ID is the ID segment of its share URL, so an entry there goes straight into `notebook_query` with no lookup
3. **Probe it.** One cheap `notebook_query` against the syllabus — confirm it answers, and that the answer is syllabus content rather than a thinking trace or an error page. A green auth flag says nothing about whether the output is usable; check the answer's *shape*

> [!danger] 🔧 A tool failure is not a missing notebook
> **Never report the notebook absent because a call failed.** Diagnose first: `refresh_auth` once, and if that fails run **`nlm login`** as a background Bash command — it opens its own Chrome window and waits 300 s, so tell Leander to sign in *there* and wait for the command to exit. Her other Chrome windows do not need closing. "Blocked now" is not "cannot be done" — diagnose the tool before you declare the resource missing.
>
> Registry entries can also be **dead rather than missing** — a notebook belongs to the Google account that made it, and the ⛔ rows in the registry are notebooks lost when their owner left. That is why step 3 is a probe and not a lookup.

> [!warning] 🛑 No notebook — stop and ask, do not quietly proceed
> Where the course genuinely has no reachable notebook, **say so and stop**. Offer the two routes and let Leander pick:
> - **Build it first** with **`/pp-checker`** — the recommended route, and the only one that leaves the review able to make spec claims
> - **Run fenced** — proceed with coverage, scope, tier and command-word claims *excluded by name* from the review, stated in the report and recorded in *Not flagged*
>
> Never pick the fenced route silently to keep the run moving. A review that drops spec claims without saying so reads exactly like a review that found none.

### 2. Fetch the cards

`getFlashcardSet` — the parameter is **`flashcard_set_id`**, not `id`.

Record: card count, type mix, every `flstrf_…` reference and its publication status, the author `athr_…`, the `spec_point_ids` on each card, and whether the set is **shared across courses** (more than one reference = an edit would propagate; say so in the report).

### 3. Ground it

`findRevisionNote` on the subtopic. Check every fact, figure, definition and True/False correction against it.

The RN is a **correctness check, not a wording template**. Reworded content is expected and fine. Deduct only for a fact that is **wrong**, or that **contradicts** the RN.

> [!danger] 🧬 "It's verbatim from the note" is not a withdrawal reason for wrong physics — *(Leander, 30 July 2026)*
> **Notation and formatting** inherited from the RN moves off the set onto the note, and the criterion stays at 5 *(21 July 2026)*. **Substantive error does not.** A false definition, a wrong threshold or a figure that misclassifies is flagged **twice** — on the set under **2 Accurate**, and on the note — however faithfully it was copied.
>
> Apply the **misconception test**: what would a student who believes this card get wrong? Board modelling convention is not an error; a definition no board uses is. **Accurate is Critical, so this fails the set** — state that when you report it, don't let it arrive as a surprise.
>
> Full rule and both worked cases: `reference/flashcard-cqi-reference.md` under *Accurate*.

Also check the course's **tier structure**. Core/Extended courses (CIE 0654, 0620 and the rest) require `**(Extended Tier Only)**` or `**T**` on Extended cards.

### 3a. Ground the spec claims — `spec-grounder` (mandatory gate)

> [!danger] 🧭 A scope, coverage or tier flag is a claim about the **specification**. Neither Cobalt nor the revision note can evidence one.
> - **Cobalt stores only the spec point NAME** — no description text. You cannot read scope out of the CMS.
> - **The revision note is a CORRECTNESS check, never a SCOPE authority** — and it can itself be over-scoped, because notes for reduced syllabuses get adapted from the fuller sibling course without being cut back.

Collect every draft finding that is really a spec claim — **coverage, scope, tier, command-word demand, and any factual flag whose only evidence is disagreement with the revision note** — and hand the batch to the **`spec-grounder`** agent, passing the `notebook_id` from step 1b. It adjudicates them against the syllabus in NotebookLM and returns UPHELD / WITHDRAWN / UNVERIFIED / UPGRADED with verbatim outcome wording.

**No spec claim may be scored until it has cleared this gate.** A finding the grounder withdraws does not reach the report as a defect; a finding it inverts becomes a **new row against the revision note**; a finding it cannot settle is logged **UNVERIFIED** on `Records` and **parked as a `Spec` query** — never asserted, and never raised as a question in chat.

**UNVERIFIED still scores.** Score it as it sits — most often *not* a defect, because an unevidenced flag is not a finding — and let the `If you overturn` column carry what changes if Leander rules the other way. A run that leaves sets unscored pending adjudication is a run that has not finished.

> [!danger] 🔁 Run it **per batch**, before that batch is written — never once at the end
> This is the step that slides. On a course sweep it reads like paperwork that can be swept up later, so it gets deferred to the last set and then has to be *asked for* — which means scores were drafted for the whole course against unadjudicated claims, and the grounder is reduced to a rubber stamp over findings that already hardened.
>
> **Tie it to the write.** No batch's rows reach the report until that batch's spec claims have cleared the grounder. The write-up already happens per batch, so the gate rides on something that cannot be forgotten — unlike a step that only ends when the reviewer decides it has.
>
> The first grounder call is not even in this step: the **tier structure** (step 1a) is a spec claim, so it goes to the notebook before any card is proofed. If the notebook has not been queried by the time the first batch is scored, something has been skipped.

**Query the notebook where a lesser source would do, too.** The grounder is mandatory for spec claims, but the notebook is also the fastest way to settle a command-word demand, a boundary between sibling courses, or whether a term is the board's own. Reaching for it is never wasted; the failure mode this skill actually sees is reaching for it too late, not too often.

Two things it will tell you that are easy to get backwards:

- **A tiered course does not mean every set needs tier markers.** Many subtopics have no Supplement content at all.
- **The Core/Supplement boundary is often the COMMAND WORD, not the content** — the same list of facts, "State" at Core and "Explain" at Supplement. So a *recall* card on Extended-flagged content is a **Core** card: retag it Core, never bolt an Extended marker onto it.

### 4. Score

Ten criteria, 1–5, **/50**. The unit of scoring is the **set**, not the card.

**1** Specific · **2** Accurate · **3** Concise · **4** Correct · **5** Consistent · **6** Sensitive · **7** Structured · **8** Formatted · **9** Tone · **10** Pitch. Critical = 1, 2, 3.

> [!danger] The scale is qualitative bands, **not** arithmetic deduction
> | Score | Means |
> |---|---|
> | **5** | Done very well, consistently |
> | **4** | Between 5 and 3 |
> | **3** | Done mediocrely, **or** done inconsistently |
> | **2** | Between 3 and 1 |
> | **1** | Not done at all, or done very badly |
>
> Do **not** start at 5 and subtract a point per offending card. There is no deduction table and there must never be one. Ask *how well, and how consistently, does this set do this thing* — then pick the band.
>
> **Consistently** does most of the work. A rule applied to every card is a 5. A rule applied to some cards and not others is a **3** — inconsistency alone puts a criterion in the middle band, however good the compliant cards are.

**Pass = ≥43/50 AND all three Critical at 5/5 AND every Standard at ≥4/5.** A failed Critical fails the set regardless of total. A Standard below 4 also fails it.

Apply the **two-tier proofing model** from the rubric: **absolute** rules (structure, correctness) are always flagged; **conventional** rules are flagged only where a set **mixes two variants**. *The convention a set picks does not matter. Picking two does.*

> [!tip] ✍️ How a front is *worded* is a free choice — not even a conventional rule
> **Leander's ruling, 14 Jul 2026.** `Cytoplasm`, `What does kinetic theory state?` and `Define the term **pressure**…` may all sit in the **same** pack. A set that frames its fronts several ways is **not** inconsistent. **Never flag mixed front phrasing under Consistent** — within a set or across sets.
>
> The card **`type`** is still absolute: a question typed `keyword_definition` is a Structured defect, because the type drives how the card behaves. It is the *English of the front* that is free, not the enum behind it.

> [!danger] 🖥️ Proof the rendered card, not the source string
> The MCP hands you raw markup, and Cobalt's renderer is more forgiving than the string suggests. **A defect that does not reach the student is not a defect.** Before flagging any *rendering* fault — LaTeX, alignment markup, bold runs, gap markers — establish that it actually renders wrong. **If you cannot see the card, do not assert it and do not ask: score it as not-a-defect and park a `Rendering` query.** The renderer is forgiving, so not-a-defect is the honest default for something you have not seen fail; the query is what lets Leander overturn it in one glance if she happens to know better.
>
> Structural, factual and consistency defects are unaffected — those are true of the content whatever it looks like on screen.
>
> **`{align=center}` is the settled case.** "Short front" means **one rendered line**, and one line is **≤ 83 rendered characters** *(Leander, 30 July 2026)*. Count the rendered string — strip `{align=center}` and bold/italic markers, count gap-marker dots. Above 83 it wraps, so centring is a defect; at or below it, *missing* centring is the defect. Never substitute a word count: the 21 July 9PH0 run invented one and produced a false FAIL, then a false PASS, on the same set.

> [!check] 🎯 The alignment band is set by the **count** of fronts out of step *(Leander, 30 July 2026)*
> Once you know *which* fronts breach the rule, the band follows mechanically. Count **fronts** — question sides only, backs are never eligible. A front is out of step whichever way it breaks: a one-line front missing `{align=center}`, or a wrapping / `fill_in_the_blanks` front wrongly carrying it.
>
> | Fronts out of step | Reading | **Formatted** |
> |---|---|---|
> | 0 | Rule applied throughout | **5** (clean) |
> | Exactly **1** | Isolated slip | **4** |
> | **2 or more** | **Pattern** | **3** |
> | Most eligible fronts | Severe pattern | **2** |
>
> Her words: *"I'd say it's a three because it's moving into a pattern rather than a one-off error."* Count fronts, not Formatted rows — two cosmetic faults on the **same** card is one card, not a pattern. The *kind* of breach is irrelevant: missing and wrongly-present each count as one front. Score it under **Formatted only** — hold Consistent at 5, one defect one criterion.
>
> **Never re-derive "the KIND of failure sets the band, not the COUNT."** The 30 July 2026 Edexcel IAL Physics run invented that sentence mid-run, wrote it into the record as settled calibration, and failed three sets that should have passed — one of which the same course had already passed a week earlier, manufacturing a fake cross-run conflict. It sounds more principled than counting and is simply wrong. **If the mapping seems wrong for a case, score it by the table above anyway and park a `Calibration` query** — the table is the settled rule and it governs the run whatever your reading of the case. Do not hold the batch, do not ask, and above all do not write a replacement into the record. Full note: `reference/flashcard-cqi-reference.md` → *Alignment*.

> [!warning] 🤖 AI-assisted cards score by the same rubric — with more scepticism
> **The criteria and thresholds do not change for AI-assisted content, and AI-generated content is permitted** provided the CQI is met and attribution is in place. There are no AI-detection checks. What changes is the scrutiny: a 4 or 5 on **Specific** or **Accurate** is *earned against the spec and the revision note*, never granted because the card reads fluently. Watch five failure modes:
> - **Plausible-but-wrong** — a slightly wrong explanation reads well and sails past a non-specialist. Score *Accurate* against the RN, not against whether it sounds right
> - **Long-tail specificity** — AI reaches for the common term, not the examiner's ("kinematic equations" vs "SUVAT"; g = 9.81 vs g = 10). Score *Specific* against board convention
> - **Depth miscalibration** — IB HL and AQA A Level treat the same topic differently. Score *Specific* and *Pitch* against this spec, not a generic level
> - **Tone that doesn't land** — fluent but not judged for a 16-year-old revising alone. Score *Tone* and *Pitch* against the student
> - **Default command-word reading** — "Evaluate" differs by board. Score *Specific* against the board's mark scheme

### 5. Report

Chat: the score, the verdict, why it fails, and the fix list.

Then **three closing lines and no more** — this is the handover, not a second report:

- **Queries** — `n open, m could flip a verdict (Q4, Q9).` Nothing else. Do not summarise them in chat; the `Queries` section of the report is the artefact and restating it in prose is the interruption re-entering by the back door
- **Rulings needed** — the `Ruling`-type queries by number, one clause each. Applied to the skill **only after she has ruled**, in a single pass at the end of the run
- **Next** — the next course in the backlog, so the run can start without her composing a prompt

On a **staged run this step is where the review stops.** Write stage A up in full, report it, give the escalation recommendation and the unresolved theme candidates — then hand back and wait. Stage B is Leander's call (step 1a, *Staged sampling*).

> [!check] ✅ Before any batch is written up — has it cleared step 3a?
> One question, asked per batch, answered before you write it: **has every spec claim in these rows been through `spec-grounder`?** If the answer is "not yet, I'll do it at the end", the batch does not get written. This is the check that stops grounding drifting to the last set of a course sweep.

#### The report file

**Write the review to a file as well as reporting it in chat.** Chat scrolls away and a context window ends; the file is what the author edits from, and what the next reviewer reads six months later. Markdown, in a **`CQI Reports`** folder in your home folder:

```
~/CQI Reports/<course> — <set ID or "N-set sample"> — <YYYY-MM-DD>.md
```

**One file per review.** A course sweep is a single file with every set in it, not one file per set, because the sample summary and the author themes are properties of the sweep and cannot be read off a pile of separate files. On escalation, stage B is appended to the stage A file — never started as a second one.

The file has four sections, in this order, and they are not interchangeable: **Scores**, **Issues**, **Records**, **Queries**. Never per-set blocks with issues scattered under each set; the author needs one list to work down, and the themes only surface when every issue is in one table.

**Scores** — one row per set:

`Date | Science | Topic / subtopic | Set ID | Cards | Author | Status | 1 Specific | 2 Accurate | 3 Concise | 4 Correct | 5 Consistent | 6 Sensitive | 7 Structured | 8 Formatted | 9 Tone | 10 Pitch | Total | Result | Why it fails | Issues`

**Issues** — one row per issue. On a multi-science course, one table per science:

`Set ID | Subtopic | Card ID | Card front | Type | Criterion | Severity | Issue | Suggested fix | Action | Evidence / audit trail`

**Records** — one row per non-actionable item, same eleven columns:

The Issues table carries **only what the author has to act on**: Severity `Critical`, `Major`, `Minor`. Everything else — `Withdrawn`, `Not flagged`, `Not scored`, `Advisory`, `Unverified`, `Superseded` — goes under **Records** (Leander, 17 Jul: *"take all of the withdrawn, not flagged, and not scored, and put that in a separate tab to keep it clean for the author"*).

These rows still have to exist. A *Not flagged* row is what stops the next reviewer re-raising a convention that was already ruled fine; a *Withdrawn* row is what stops a finding being re-litigated. They are just not the author's reading. **Records is for the next reviewer and for Leander — Issues is for the author.** This is why the report file has to survive the session: a review whose only record was a chat window re-litigates everything it settled.

Leave **Action** blank everywhere — it is Leander's column, not a box for the author to tick.

### The Queries section — everything you were unsure about, in one place

**One table, twelve columns, one row per open question.** This is what replaces asking. Nothing in the review waits on it: every row already carries a scored call, and the table records what that call was and what changes if Leander overturns it.

`Q | Set ID | Subtopic | Card ID | Card front | Criterion | Type | The question | My call | If you overturn | Flips? | Leander's call`

| Column | Contents |
|---|---|
| **Q** | `Q1`, `Q2`, … numbered across the **whole report**, continuing through every batch and both stages. The number is how a Scores row points at a query, so it never restarts and never gets reused |
| **Type** | One of six, and only these six: `Rendering` · `Spec` · `Calibration` · `Ruling` · `Scope` · `Routing`. A closed list is what lets her clear a whole category in one decision — all four `Rendering` rows at once, rather than four separate judgements |
| **The question** | **One sentence, ending in a question mark.** What you could not settle, not the history of trying |
| **My call** | What you actually scored, stated flat: `Scored as not a defect.` · `Scored 8 Formatted = 3.` Never `I think perhaps…` |
| **If you overturn** | The concrete consequence: `8 Formatted 4→3.` Blank is not allowed — if overturning changes nothing, the row is not a query, it is a *Not flagged* record |
| **Flips?** | `YES` where overturning moves the set between PASS and FAIL, otherwise blank. **This is the only column that has to catch the eye** |
| **Leander's call** | Hers. Leave it blank, exactly like **Action** in the other tables |

Send her the section — the file, or the table pasted into a message — once the review is closed. Not before, and not one query at a time.

> [!check] 🎯 The section is designed to be **ignored safely**
> A query she never reads leaves the review sound: the score stands, the fix list stands, the author has already been given work that does not depend on her answer. **Write every row so that no answer is a legitimate answer.** That is the whole reason this is a table and not a conversation — it makes her attention optional rather than load-bearing.
>
> It follows that a row that *cannot* be ignored is not a query at all. If the review genuinely cannot proceed without her — the three permitted stops at the top of this skill — stop; do not disguise a blocker as a parked row.

**What must never land here.** This section is uncertainty, not overflow. A confirmed defect goes under Issues however awkward it is to word. A withdrawn or unverified finding goes under `Records` — an UNVERIFIED spec claim gets **both**, a `Records` row for the audit trail and a `Queries` row for the decision, because they have different readers. And a query is never a substitute for the grounder: **park what `spec-grounder` could not settle, never what you did not send it.**

**Marking a Scores row provisional.** *Result* stays `PASS` / `FAIL` and nothing else — the sample verdict is an exact match on those two words, and decorating the cell silently breaks it. The marker goes in *Why it fails*, which is empty on a passing row and is already the wide prose column:

```
⚠ PROVISIONAL — Q4 could take 2 Accurate to 3 and FAIL this set.
```

On a failing row it goes **after** the fail reason, not instead of it. Only `Flips? = YES` queries earn a marker: a query that cannot change the verdict lives in the Queries table and nowhere else, or every row under Scores ends up caveated and the marker stops meaning anything.

Where any open query flips *any* set, the sample summary carries the sample-level version — `⚠ SAMPLE VERDICT PROVISIONAL — Q4, Q9 open; either could fail a set.` The verdict itself is untouched. It reports the sample as scored, which is what it is for.

**Sort every batch as you write it: worst first.** Order by Severity — `Critical`, `Major`, `Minor`. The author reads top-down and should hit the worst of it first. (The records used to sit at the bottom of this same table; they now have their own section, which is a stronger version of the same rule — a withdrawn row that sits anywhere near a Critical one is a row that gets read as a task.)

**Issue and Suggested fix are for the author. Evidence is not.** These columns have different readers, and collapsing them is what makes a fix list unreadable:

| Column | Reader | Form | Length |
|---|---|---|---|
| **Issue** | the author | **One sentence naming the defect.** No reasoning, no spec quotes, no history | ~1 line |
| **Suggested fix** | the author | An **imperative**, paste-ready where possible. No meta-commentary about other sets or other findings | 1–2 lines |
| **Evidence / audit trail** | the next reviewer, and Leander | Verbatim syllabus outcomes, withdrawal reasoning, version diffs, what was checked and accepted | as long as it needs to be |

> ⚠️ An author should read a row **once** and know what to do. If they have to excavate the actionable point out of a paragraph of your reasoning, the row has failed — however sound the reasoning is.

Two rules that follow:

- **Withdrawn / Not flagged / Superseded rows** are records, not tasks. Their Issue is one line (`WITHDRAWN — B1.1 is entirely Core, so there is no Extended content for a tier marker to mark.`), their fix is `No action. Do not re-raise.`, and the whole case sits in Evidence.
- **Never put a score, a criterion total, or a comparison with another set in Suggested fix.** That is reviewer bookkeeping. It belongs in Evidence or under Scores.

### The sample summary — one line above the sets

A sweep gets a summary line directly under the Scores header, before any set row, carrying the same columns as the sets themselves so it reads straight down: **`SAMPLE — N sets, X% of Y subtopics`**, the mean of each criterion, the mean total, and the sample verdict.

**`X%` is the stage actually completed, never the stage intended.** A staged run that stops after stage A says `5%` and the set count it really scored. Escalating restates it as the combined `10%` once stage B is appended. Never pre-label a stage A report `10%` on the expectation that stage B will follow.

> [!danger] 🚦 The verdict is a gate, not an average — any single set failing fails the sample
> The mean and the verdict are two different statements and **they must never be reconciled.** The mean says how the sample scored; the verdict says whether it clears. A set at 30/50 among nine at 50/50 averages 48 — a mean that reads like a pass while a set is broken. **Never compute the sample verdict from the mean**, and never soften it to a majority or a threshold: a CQI clears content for publication, and one set needing revision means the sample needs revision.

On a multi-science course, report **per science as well as overall**, and apply the gate per science: one failing set fails that science.

### 📁 Estimated corrected score — retired 31 July 2026

> [!danger] 🚦 Do not produce one. Do not offer one.
> **A CQI reports the scored result and a binary verdict — ✅ PASS or ❌ FAIL.** No estimated corrected score, no `POST-EDITS AVERAGE` row, no *est. after* column. Leander's ruling, 31 July 2026. Any older instruction — in a course page, a project page, a handover, or an earlier version of this skill — telling you to project a post-fix score is **dead**.
>
> **If the size of an editorial lift is wanted, it must be measured** by re-scoring the sets after the edits land. Never modelled from the findings.

**Why it went, kept so it is not re-invented.** Leander's reason first, and it is the whole argument in one line: **"It's assumed that the author will bring it up to a pass standard."** The estimate's premise was that every finding gets fixed — so the answer was always *pass*, and a number that can only come out one way is not a measurement. Everything below is that same point in arithmetic.

The projection ran on blanket assumptions — all Criticals to 5, all Standards to a floor of 4 — because the **Action** column that was meant to record what authors actually fixed was never filled in (too much work for the return; settled, not an open problem — **do not propose reinstating it**). But pass is total ≥43 with all Criticals at 5 and every Standard at ≥4, and 3×5 + 7×4 = **43** exactly. **Under those assumptions the arithmetic could not produce a fail**: every set cleared by construction, so the projection discovered nothing. It measured the assumptions, not the content.

That identity still matters, and it outlives the estimate. Because 43 is precisely the floor of the criterion gates, **the total never does independent work** — no set can clear the gates and miss 43. The mean describes; the verdict decides. Same point as *the verdict is a gate, not an average* above, arrived at from the arithmetic.

**The verdict is what you report instead**, and it is mechanical: ✅ PASS only if every set passed, ❌ FAIL if any set failed. Give the mean **and the pass count together, always**; a high mean beside a ❌ FAIL is a normal shape, not a contradiction, and the two are never reconciled. The controlled pair, same author and same week: Edexcel A Level Physics 9PH0 scored **48.70** with 17 of 19 passing; CIE IAL Physics 9702 scored **47.95** with 8 of 20. The means sit 0.75 apart and the pass rates 49 points apart, because the mechanism is **density, not severity** — slips that land on Formatted 4 in one course cluster in the other and push the band to 3, and a Standard below 4 fails the set outright. 9702 had no Critical below 5 anywhere and still failed 12 sets of 20. **Every reported figure is a pair** — `47.95 / 50, 8 of 20 passing`, never the first alone — and courses are compared on pass count, because ranking by mean orders them almost at random.

**Then the vault — if you have one.** The Development Editor Obsidian vault is Leander's, and most of the Squad does not have it. **The report file is the record of a review; the vault is a second index on top of it, not a second copy.** If you have the DE vault, log per the rubric's **📝 Where results get logged**: a section on `QA Logs/<board-level-subject>.md`, rows in `QA Logs/QA Log.md`, and — where a course is checked science by science — that science's row of the **convention profile** table filled in as you go, so the cross-science comparison is read off the table rather than re-derived. If you do not have the vault, **the report file is your deliverable and the review is complete without the vault step**: say in the closing report that the vault index was not updated, so whoever holds it can mirror the rows. Never treat a missing vault as a reason to withhold the report.

### 6. Verify before you hand it over — `cqi-verifier` (mandatory gate)

Before the review is handed over, give the whole thing — set IDs, scores, findings, the path to the report file, and the vault page path if you kept one — to the **`cqi-verifier`** agent. It is adversarial by design: its job is to find the reasons the review is wrong, not to confirm it looks fine.

It checks that every finding rests on evidence of the **right kind** (syllabus for scope, untruth for factual, *rendered* output for rendering), that the scores follow the rubric's **qualitative bands rather than arithmetic deduction**, that the pass rule was applied correctly, that withdrawn and unverified findings are handled honestly, that the report and the vault agree (where a vault page exists — tell it plainly if one does not, rather than letting it hunt), and that **nothing was written to Cobalt**.

**Brief it to check the grounding actually happened, and happened in time.** Every spec claim in the report carries a `spec-grounder` outcome; the notebook was queried before the first batch was scored, not after the last; and where the review ran fenced for want of a notebook (step 1b), the report says so by name rather than simply containing no spec claims. A review with no spec findings and no explanation is indistinguishable from one where the gate was skipped.

**Brief it on the parked queries too.** Four checks, all of which catch the new failure modes rather than the old ones:

- **Every set is scored.** No criterion left open pending a ruling, no verdict deferred. A parked query never suspends a score
- **Every `Flips? = YES` query has its `⚠ PROVISIONAL` marker in *Why it fails*** on that set's Scores row — and no marker exists without a query behind it
- **The *Result* column is clean.** `PASS` / `FAIL` and nothing else, on every row including the sample summary. A decorated verdict breaks the gate
- **Nothing was parked that should have been a finding.** A confirmed defect under `Queries` is the section being used to avoid a hard row, and it hides work from the author. Equally: nothing was *asked* that should have been parked — a review that came back with questions in it did not follow the skill

It returns **SAFE TO SEND**, **CORRECTIONS NEEDED** or **DO NOT SEND**. Act on the corrections, then report. If it says DO NOT SEND, do not send.

**On a staged run it gates every stage, because every stage reaches Leander.** Stage A is not a draft — she reads it, scores hang off it and she decides the course's fate from it, so it clears the verifier before she sees it, exactly like a flat review. `spec-grounder` (step 3a) likewise runs within each stage; findings cannot be scored unadjudicated.

The saving on escalation is in **scope, not omission**: brief the stage B pass on stage B's findings plus the *combined* state of the report — the header, the means, and the sample verdict now read across every row — and tell it stage A's findings were already cleared. Re-adjudicating stage A wastes the pass; skipping the combined-state check is how a report ends up headed 5% with 10% of the rows in it.

### 7. Feedback themes — the part that scales

A single set's fix list fixes one set. A **theme** is a defect that almost certainly runs through **everything that author has ever made** — and the author can sweep their whole output for it in one pass with their own Claude.

This is where the review stops being a score and starts being worth the time.

> [!danger] ⚠️ A theme prompt **industrialises** whatever is in it
> A wrong finding in a fix list costs one wasted edit. **The same wrong finding in a theme prompt gets swept across an author's entire back catalogue.** Had the sulfite finding reached this stage, an author would have been told to add off-spec 0620 content to every anion set in the estate.
>
> **The bar for promoting a finding to a theme is therefore higher than the bar for raising it at all.**

#### What qualifies as a theme

All four must hold:

1. **It is an absolute rule, not a convention.** `{align=center}` on every front is a mandate — promote it. The choice of gap marker is a convention — **never** promote a convention to a theme. The convention a set picks does not matter; picking two does, and *that* inconsistency can be a theme.
2. **It recurs.** It appeared on **every** set by that author you looked at, not one. Defects track the **author**, not the science — that is the finding that made this section necessary.
   *On a stage-A-only run this is the criterion most likely to be unmet for want of sets rather than for want of a defect.* Half a sample crosses fewer authors, so a real theme can sit there as a lone candidate. **Do not promote it to close the gap** — name it as unresolved in the stage A report and let that argue for stage B. A candidate is not a theme however strongly it reads: confirm on **≥2 sets by the same author** before promoting, and check the cross-author pattern first — a defect hitting several sciences under several authors is a course-level issue and author remediation is the wrong instrument.
3. **It is mechanically checkable.** The author's Claude must be able to find it by inspection. "Bolding is missing on backs" qualifies. "The pitch feels off" does not.
4. **It survived `spec-grounder` and `cqi-verifier` cleanly.** Never build a theme from a finding that is **UNVERIFIED**, that was **withdrawn**, that rests on the revision note, or whose score is **provisional**. If it needs Leander's adjudication, it is not a theme yet.

#### Classify every theme — sweep it, or just say it

Not every theme earns a retro-fix. **A sweep of a published back catalogue is not free**: every write goes live immediately and lands in every course referencing the set. Ask two questions.

**1. What does the student lose if this is never fixed?**
**2. What does the sweep cost and risk?**

| Band | Meaning | Reserved for |
|---|---|---|
| 🔴 **Remediate** | Sweep the back catalogue now | The student is **given something wrong**, can't use the card, or the content **can't be shown to test the spec** — wrong facts, broken cards, missing/incorrect spec tags, tier mis-tags, off-spec content |
| 🟡 **Adopt forward** | **Do not sweep.** Apply on new content and fix opportunistically on next touch | House style the student loses nothing to — bolding, alignment, phrasing conventions. Real defects, and they score badly, but nobody is misled by them |
| ⚪ **Park** | Nobody acts until there's a central ruling | Genuine pick-one conventions where two variants are both defensible and the estate uses both |

**A failed CQI is not the same as a harmed student.** A set can score 2/5 on Formatted and still teach the right physics perfectly. Say that out loud when it's true — it is what tells the author which of their habits is urgent and which is merely a habit.

**Split a theme across bands where it belongs.** One author's sets can carry a 🔴 tagging failure and a 🟡 bolding failure at once. Don't average them into one instruction.

**Only 🔴 themes get a handover prompt.** A 🟡 theme gets the rule stated plainly and no sweep — a prompt would invite exactly the sweep you just decided wasn't worth it. A ⚪ theme gets a note of the decision needed and who owns it.

> [!warning] ⚖️ The band is a **recommendation**. The call is Leander's.
> Whether a cosmetic theme is worth a retro-sweep is an **editorial judgement** and it belongs to her. Recommend a band, show the reasoning, and leave it. Never decide it silently, and never widen a 🟡 into a sweep because the fix looked easy.
>
> **Recommending is not asking.** Give the band and move on — the run does not pause on it. Every 🔴 recommendation, and any theme you could argue either way, also gets a `Ruling` row on `Queries` so the decision survives the chat log: `My call` is the band you recommended, `If you overturn` is what the other band would cost or save. A 🟡 you are confident about needs no row.

#### What each theme contains

- **The defect** — named precisely, with the rule it breaks and *why it matters to the student*, not just that it violates house style
- **The evidence** — the sets and cards it was found on, quoting fronts. Author `athr_…` and how many of their sets carry it
- **The correct form** — the right string, ready to paste, next to the wrong one
- **The band** — 🔴 Remediate / 🟡 Adopt forward / ⚪ Park, with the reasoning, stated as a recommendation
- **The blast radius** — how many of that author's sets plausibly carry it, and whether any are **shared across courses**
- **A handover prompt** for the author's Claude — **🔴 themes only** (below)

#### The handover prompt

Write it **addressed to the author's Claude**, self-contained — it will be pasted into a session with none of this context. It must carry its own guardrails, because the author's Claude *can* write to Cobalt and the reviewer's cannot:

> **Scan first, fix second, and never in one step.** The prompt tells their Claude to *report* every affected card and wait for the author's go-ahead before any `updateFlashcard`.
> **Most sets are published.** An edit goes live immediately and lands in **every** course referencing the set — say so in the prompt, and tell it to check the reference count before editing.
> **Proof the rendered card, not the source string.** Cobalt's renderer is more forgiving than the markup looks. A defect that does not reach the student is not a defect — tell it not to "fix" markup it has not seen render wrong.
> **Do not touch scope, coverage or tier.** Those are spec claims and the author's Claude has no syllabus access. Explicitly fence them out.
> **The fix is the author's call, card by card.** Their Claude proposes; the author decides.

Give it as a fenced code block so it copies clean, naming the exact MCP tools (`searchFlashcardSets`, `getFlashcardSet`, `getFlashcard`, `updateFlashcard`) and the author's `athr_…` so it can scope the sweep.

#### Where themes go

Chat report, and — if you keep the vault page — a **`Themes`** section at the top of the course's QA page, above the per-set sections, because it is the part anyone reading the page actually acts on. Without a vault, the chat report carries them and the closing report says so, because a theme that only ever existed in a chat log is a theme that gets rediscovered from scratch next round. One theme per author per defect. When a later round shows an author has cleared a theme, mark it closed rather than deleting it — that is the evidence the feedback worked.

> [!tip] 🎯 Themes are how a sampled review covers an unsampled estate
> Six sets were checked in 0654. But **each author is internally consistent with themselves and inconsistent with the others** — so six sets identified three authors' habits, and three theme prompts can reach every set those three have ever written. That leverage is the entire argument for sampling rather than exhaustive review.

## Feedback quality bar

Every flag names the offending card (quote its front), cites the rule it breaks, and gives **the corrected string, ready to paste**. Not "consider bolding".

**One defect, one criterion (CQI page, 17 Jul 2026).** A single defect never loses marks under two criteria — pick the one where it counts most, score it there, and leave the other alone. A wordy, cluttered mark scheme is a *Concise* failure **or** a *Formatted* one, not both. The row may note a knock-on effect, but only one criterion is docked. One defect is still **one row** and the author fixes it once.

Calibrate to the audience: internal reviews get scores and criterion names; freelancers get a collaborative numbered edit list with no scores and no labels.

## ID prefixes — never abbreviate

`flst_` set · `flstrf_` set reference · `fl_` card · `sbt_` subtopic · `top_` topic · `spcpt_` spec point · `rn_` revision note · `crs_` course · `mod_` module · `athr_` author
