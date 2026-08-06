---
title: Flashcards — CQI Reference
type: sop
status: active
created: 2026-07-09
updated: 2026-07-30
sources:
  - Notion — Flashcard Style Guidance [WIP] (0248b4fa-8393-42fc-b16b-a35dad3cccfe), last modified 17 June 2026
  - Notion — Flashcard Style skill (382847b3-0a5f-8104-a014-fa6c24cdb829), last modified 29 June 2026
  - Notion — Flashcard Gen skill (37a847b3-0a5f-81d7-ab0f-db9fefbdf778), last modified 8 July 2026
  - Notion — Proof-Flashcard skill (38b847b3-0a5f-8183-aadc-ea728fd48812), last modified 8 July 2026
---

# Flashcards — CQI Reference

> [!abstract] 🎯 What this document is
> A self-contained context pack for CQI-ing a **flashcard set**. Load it before proofing cards from any source — AI, freelance or in-house. It reconciles the four Notion pages that currently carry flashcard guidance, which do **not** agree with each other.
>
> Flashcards are **not exam questions**. There is no model answer, mark scheme, Examiner Tips box, AO tag, tariff or command word. A card is a `front` / `back` pair with a `type`, `spec_point_ids` and a display `order`. If you are checking for any of the EQ Gold Standard furniture, you have the wrong rubric.

> [!warning] 📦 This copy is the master — edit it here, not in Obsidian
> This file ships inside the `cqi-flashcard` skill so the skill is self-contained. **This repo copy is now the authoritative one.** It began as an Obsidian note in the Development Editor vault, and a copy may still exist there; where the two differ, this one wins, because it is the copy every reviewer actually loads.
>
> Changes go through a PR against the skills repo, alongside any matching change to `SKILL.md` — see *Proposing a change to this skill* in that file. Above both sits the **CQI Notion page** (`6bbed885ff644045846080e43fee1a23`): where it and this document disagree, the page wins.

---

## The rule that resolves everything else

> [!warning] 🕐 The most recent editor decision wins
> Guidance is spread across four Notion pages that were last edited on different dates. Where they conflict, **the later dated editor decision is the live rule**, regardless of which page carries the "canonical" label.
>
> The skill pages carry inline "House-style update" callouts with dates. Those callouts are the audit trail. Trust them over the body text of any page.

The ⭐ **Flashcard Style** page is nominally the canonical format authority, and both skills defer to it in their own instructions. In practice it has fallen behind on three rules, because the 8 July 2026 editor updates were written into the two skill pages and never back-ported. **Do not proof against the Flashcard Style page alone.**

---

## 🔀 The three live discrepancies

These are the only points where the pages disagree. Everything else is consistent across all four.

### 1. The fill-in-the-blanks gap marker

| Source | Says | Date |
|---|---|---|
| Flashcard Style Guidance [WIP] | Underlined non-breaking space, sized to the missing word | 17 Jun 2026 |
| Flashcard Style (skill) | Bold `**______**` run preferred; thin `_` also acceptable | 29 Jun 2026 |
| Flashcard Gen | Underlined non-breaking space (`U+00A0` wrapped in `_…_`) | 8 Jul 2026 |
| Proof-Flashcard | Underlined non-breaking space; `**______**` and thin `_` are **legacy** | 8 Jul 2026 |
| Live CMS data | Spaced underscores `_ _ _ _ _ _ _ _ _ _` | in `flst_3zW7whg9GKCQXS7D`, published 2 Jul 2026 |
| Live CMS data | Bold dots `**..........**` | throughout CIE A Level Physics, published 14 Jul 2026 |

> [!check] ✅ Live rule — for **authoring**
> The gap is an **underlined non-breaking space** — a short run of `U+00A0` wrapped in Cobalt underline marks `_…_`. It renders as a clean underlined blank with no literal underscore or asterisk visible to the student. Write new cards this way.

> [!warning] 🎯 Live rule — for **proofing**
> **Five markers exist in the estate**: the underlined non-breaking space, the bold `**______**` run, the thin `_`, spaced underscores `_ _ _ _`, and bold dots `**..........**`. Only the first appears in any Notion page; the fourth and fifth appear in content published in July 2026.
>
> **Any one of them is acceptable. Two of them in one set is the defect.** Deduct under **Consistent**, name the marker the set uses in the majority, quote the cards that deviate. Never fail a set for choosing a marker, however old.

The original WIP page and the two skills agree on what to *write*. The Flashcard Style page's `**______**` line is stale — it predates the 8 July decision by nine days. But none of the four pages describes the estate as it actually is, which is why proofing is governed by consistency rather than conformance. See **📏 Conventions vs absolutes** below.

**Why the non-breaking space won:** it is the only marker that renders as a blank of controllable length without leaking markup characters into the student-facing card. The WIP page documents the authoring process — write the back first, copy it to the front twice, strip the keyword from one copy, pad with non-breaking spaces to match the width of the missing content, underline the run, delete the spare sentence.

### 2. Card count per set

| Source | Says |
|---|---|
| Flashcard Style (skill) | 5–8 typical; more than 8 acceptable where content warrants (editor, 29 Jun 2026) |
| Flashcard Gen | **Minimum 10**, no upper cap — a deliberate override |
| Proof-Flashcard | Proof to the **10 minimum**, no upper cap |

> [!check] ✅ Live rule
> **No floor, no cap. Card count is never a fail criterion** *(editor, 16 July 2026)*. Never flag a set for having few cards or many, and never recommend trimming on count alone.
>
> An **empty set** is still reportable — as "nothing to review", not as a count failure.
>
> A set is too short only when it misses content the revision note teaches. That is a **coverage** judgement against the RN, not an arithmetic one — name the gap, don't count the cards.

> [!warning] ⚠️ Where the 10 came from
> Vicky's Flashcard Style page is the canonical authority and it sets **no floor** — 5–8 is *typical*, descriptive, with a soft top and no minimum language at all. It is **generation guidance**: aim there when drafting.
>
> The "minimum of 10" originates in Bridgette's Flashcard Gen page, justified only as "intentionally overriding the Flashcard Style page's 5–8 guidance; do not revert it" — no rationale, no `(editor, …)` marker, on pages that otherwise attribute editor decisions carefully. Proof-Flashcard then adopted it and called it "the house floor", but that is the same author's second page. The two corroborate each other and nothing else.
>
> **This rubric previously took the 10's side** — it called it an absolute rule and dismissed Vicky's page as stale on count. That was wrong, and reinstating a floor of 5 would have repeated the same move. Hence: no number at all.
>
> Bridgette's two Notion pages still enforce the 10. Realigning them is a conversation with her, not a unilateral edit.

### 3. A stale cross-reference in Flashcard Gen

The Flashcard Gen page still warns, in two places, that "`/proof-flashcard` still checks 5–8, so this skill's sets may be flagged there for count until that skill is aligned — expected."

**That is no longer true.** Proof-Flashcard was aligned to the 10-card minimum on 8 July 2026 and its checklist now says so explicitly. The warning is a leftover. Ignore it, and flag it for cleanup next time either page is touched.

Neither number governs a CQI. **This rubric proofs to no count at all** — see the live rule above.

---

## 🃏 Card anatomy

The Cobalt MCP exposes **four** card types:

- `keyword_definition`
- `question_and_answer`
- `fill_in_the_blanks`
- `true_or_false`

> [!check] ✅ `true_or_false` is a real type *(Leander, 21 July 2026)*
> **It was added to the CMS in mid-July 2026.** Every T/F card in CIE A Level Physics returns `"type":"true_or_false"`.
>
> **This rubric previously said "'True or False?' is not a type" and made a T/F card stored under anything but `question_and_answer` a Structured defect. That is now backwards** — it would fail every correctly-typed T/F card in the estate. **Never flag a card for carrying `true_or_false`.**
>
> Sets published *before* the type existed carry their T/F cards as `question_and_answer`. That is **legacy, not a defect** — the type did not exist when they were written. Do not flag it, and do not raise it as a within-set inconsistency where a set mixes the two.

Every card carries up to **two** `spec_point_ids`, all of which must belong to the set's own subtopic. Every card must be tagged.

Every card carries up to **two** `spec_point_ids`, all of which must belong to the set's own subtopic. Every card must be tagged.

---

## 📐 Universal format rules

### Alignment

| Element | Rule |
|---|---|
| Front that renders on **one line** | Centred — `{align=center}` |
| Front that **wraps to two or more lines** | Left-aligned — omit `{align=center}` |
| Fill-in-the-blanks front | **Always** left-aligned |
| Every back, without exception | **Always** left-aligned |

A `{align=center}` on a back is a defect. A back *without* alignment markup is correct — never flag it as missing.

> [!check] 📏 "Short" means one line — not a word count *(Leander, 30 July 2026)*
> **The test is how many lines the front occupies when rendered: one line → centred; two or more → left-aligned.** This replaces the old "use professional judgement on what counts as short", which was unfalsifiable and cost a whole verdict — see below.
>
> **Judge it per line-element, not per card.** A `true_or_false` front is a label line plus a claim line; each is assessed on its own, which is why `fl_yPJD2crzJMWNkvWd` carries `{align=center}` **twice** and scores Formatted 5. Two deliberate short lines is not "wrapping to two lines".

> [!check] 📏 The measurable form — **83 rendered characters** *(Leander, 30 July 2026)*
> One line holds up to **83 characters**. Calibrated from her reference front, which fills a line exactly:
>
> `Units that are obtained mathematically from the SI base units are called ..........` → **83**
>
> **Count the rendered string, not the payload.** Strip `{align=center}`, strip `**`/`*` bold and italic markers, and count the gap marker's dots as characters (they occupy the line). A Greek letter or symbol is one character.
>
> - **≤ 83 characters → one line → `{align=center}` required.** Absence is a Formatted defect
> - **> 83 characters → wraps → omit `{align=center}`.** Presence is a Formatted defect
> - `fill_in_the_blanks` fronts and **every** back are left-aligned regardless of length
>
> 83 is a **proxy for the line rule at standard card width**, not a rule of its own. Where a front sits within a character or two of 83, say so and hold it rather than forcing a verdict.

> [!danger] ⚠️ Never invent a threshold — the 21 July 2026 9PH0 run is the cautionary case
> Line count is a **rendering** property and `getFlashcardSet` returns a raw string, so before this figure existed the rule was unfalsifiable. The reviewer **invented a word count** — ≤13 required, 14–16 grey, ≥17 exempt — and scored `flst_PPK42cHgPNHQMC6b` a FAIL on four "13-word" fronts. `cqi-verifier` recounted two as **14** words, inside the invented grey zone, and the set was corrected to 49/50 PASS.
>
> **Both steps were wrong, because words were never the measure.** Re-scored against 83 characters, three of that set's four one-line fronts are missing required centring (64, 75, 78 chars) and only one of four carries it — inconsistent application, Formatted band **3**, and the set **FAILs** after all. The invented number produced a false FAIL, then a false PASS.
>
> The lesson outlives the number: **when a criterion is qualitative, do not manufacture a quantity for it.** Score the finding conservatively, park it on the `Queries` tab and carry on — never invent a measure to close the gap. An invented threshold looks like rigour and behaves like a coin toss.

> [!check] 🎯 The alignment band is set by the **count** of fronts out of step *(Leander, 30 July 2026)*
> The rules above say *whether* a front is out of step. This says what the set scores for it. A **front** is the question side of a card — backs are never in scope. A front is **out of step** when it breaks the rule either way: a one-line front missing `{align=center}`, or a wrapping/`fill_in_the_blanks` front wrongly carrying it.
>
> | Fronts out of step in the set | Reading | **Formatted** |
> |---|---|---|
> | 0 | Rule applied throughout | **5** (clean) |
> | Exactly **1** | Isolated slip | **4** |
> | **2 or more** | **Pattern** | **3** |
> | Most eligible fronts | Severe pattern | **2** |
>
> Her words: *"I'd say it's a three because it's moving into a pattern rather than a one-off error."* The count is of **fronts**, not of Formatted rows — two cosmetic faults on the *same* card is one card, not a pattern. And the kind of breach does not matter: a missing marker and a wrongly-present one both count as one front out of step.
>
> **This is the standing rule across every course.** It matches the policy already applied to all 22 sets of the 21 July 2026 Edexcel IAL Physics run. Two prior runs pre-date it and are **not** conformant: the AQA A Level Physics log bands "one **or two** fronts out of step" at 4 — any of its sets 1, 6, 8, 10, 11, 22, 25 or 27 carrying exactly two must move to 3, which may flip a PASS to a FAIL. That back-sweep is open.

> [!danger] ⚠️ Do not re-derive "the KIND of failure sets the band, not the COUNT"
> The 30 July 2026 Edexcel IAL Physics run invented exactly that sentence mid-run, wrote it into four audit cells as "the run's settled calibration", and used it to fail three sets that should have passed — including one the *same course* had already passed on 21 July, manufacturing a fake cross-run conflict. It had no provenance in any ruling, skill or rubric.
>
> It is seductive because it sounds more principled than counting. **The band is count-based. A qualitative rubric still needs a stated mapping, and where one exists you use it rather than reasoning your way to a better one.** If the mapping seems wrong for a case, **score it by the table anyway and park a `Calibration` query** — do not hold the batch, and do not write a replacement into the record.

### Full stops

Full sentences take a full stop. Two exceptions take none:

1. A bullet-point item
2. A standalone keyword, term, equation or date displayed on its own on the front

So `Define **species**.` **does** take a full stop, because it is a sentence. A bare `**species**` on a front does not.

### Bold

Bold the key term or terms on **both** sides. The one exception: a standalone keyword, equation or date shown on its own on the front is **not** bolded.

Stray spaces inside the markup — `**True. **`, `**you **can` — are **not** defects and are not flagged. They are common in AI-generated cards and they do not affect what the student sees. *(Leander, 16 July 2026)*

### Other

- No header styling
- No quotation marks around keywords
- Bullet and numbered lists are fine on backs, but only when the answer genuinely is a list
- Continue a bulleted list with lower-case openers if the bullets complete a sentence; use capitals if it is a standalone list
- Backs must be concise — this is the whole point of the format

---

## 🗂️ Rules by card type

### `keyword_definition`

- Front: `Define **term**.` — term bolded, full stop, centred
- Back: a full-sentence definition with the term bolded

>[!tip] ✍️ Front phrasing is a free choice — **never** a Consistent flag
> **Leander's ruling, 14 Jul 2026.** `Define **term**.` is the house preference, but a question-framed front (`What does X mean?`) or a bare term (`Cytoplasm`) is **not a defect** — and several framings may sit in the **same** pack. Do not flag mixed front phrasing under Consistent, within a set or across sets.
>
> The card **`type` is still absolute**: a question typed `keyword_definition` is a Structured defect. It is the *English of the front* that is free, not the enum behind it.

### `question_and_answer`

- Front: **one** short closed question with a single definite answer. No multi-part fronts — split into two cards. No essay prompts.
- Back: a **full sentence** that restates the question and gives the answer, with the answer or key terms bolded, and a full stop.

> [!warning] ⚠️ This rule changed on 8 July 2026
> A bare-fragment back is now a **defect**. `When did the Battle of Hastings take place?` → `The Battle of Hastings took place in **1066**.` — never a bare `1066.`
>
> This **supersedes** the older "shortest possible answer, don't restate the premise" guidance. Older sets will be full of bare fragments; those are legacy, not failures.

### `true_or_false`

- **Type it `true_or_false`.** Sets published before mid-July 2026 carry these as `question_and_answer` — legacy, never a defect
- Front: `**True or False?**` bold, on its own line, above the claim
- Back: `**True.**` or `**False.**` bold, on its own line, above the explanation
- Alignment follows the general rule — centre for short claims, left for multi-sentence. Align the `True or False?` line the same way as the claim beneath it.
- Line breaks are automatic. Do not add a blank line between the label and the statement.

### `fill_in_the_blanks`

- Use only where it is genuinely a good learning tool
- Front is **always** left-aligned. No instructions needed.
- Remove **at most ~3 words**. It must be unambiguous which words are missing.
- Gap = an underlined run of non-breaking spaces (`U+00A0` in `_…_`), roughly the width of the missing content, with a space either side
- Back repeats the **whole sentence** with the missing words filled in and bolded

> [!warning] ⚠️ This rule changed on 8 July 2026
> A bare-answer back is now a **defect**. The back must restore the full sentence and bold the restored words.

There is also an **image-based** variant — diagrams with missing labels, or "luggage tag" labels that hold either a single missing word or a sentence with missing words. A blank luggage tag needs no underline. Images come in pairs (blank front, bolded back), are produced by Illustration from a single CC request, and need alt text. **This variant is out of scope for text proofing.**

---

## 🎓 Rules by content type

These live in the toggle sections of the WIP page and are easy to miss.

**Equations and formulae** — symbols and equations go in the equation editor. Backs follow RN structure: the equation in the answer sentence, then the terms defined underneath as a bulleted list with units.

**Quotes** — open with `**Key quote:**`. Always left-aligned. Double quotation marks at both ends. Reproduce in-quote punctuation exactly as the exam-board-authorised text has it, but drop end-of-quote punctuation unless it is a question mark, exclamation mark or ellipsis. Character, act and scene go underneath in *italics*, right-aligned. Bold the words in the back-of-card analysis that link directly to key themes.

**Key dates** — a full-sentence question introduces the date or event, centred, with either the event or the date in bold. The back is a left-aligned full sentence, again with event or date bolded. *"What year did the **Cuban Missile Crisis** happen?"* → *"The **Cuban Missile Crisis** happened in 1962."*

**Key individuals** — same shape. *"Who was **Joseph Lister**?"* → *"**Joseph Lister** discovered that carbolic acid was an effective antiseptic."*

**Tiered courses** — add `**(Extended Tier Only)**` or `**T**` on the front: bold, in brackets, Title case, after the content. Bold so it stands out; bracketed so it does not compete with the content.

**CORMMS (Biology only)** — front carries `**(CORMMS)**` bold and bracketed on the same line after the content. The back gives the answer, then on a **separate line** explains which CORMMS criterion applies, with the relevant letter bolded: *"This is part of the **C**ORMMS criteria for planning an investigation."*

---

## 📚 Set-level checks

- **Count** — no floor, no cap; never a finding. Report an **empty set** as "nothing to review" *(editor, 16 July 2026)*
- **Type mix** — a deliberate spread including **at least one** `fill_in_the_blanks` and **at least one** True or False? An all-one-type set fails the mix.
- **Overlap is fine** — two cards may touch the same spec point from different angles. That is reinforcement, not repetition. Flag only a card that is a **near-verbatim duplicate** of another *(editor, 9 July 2026)*
- **Order** — core keywords first, then Q&A, then True/False for misconceptions, then fill-in-the-blanks for sequences and pairs. Reordering is a Cobalt UI action, so raise order issues as advisory.
- **Spec points** — every card tagged, ≤2 per card, all from the set's own subtopic
- **Examiner Tip discipline** — tips in the RN shape a card's scope, emphasis and choice of misconception. **A tip must never become a card.**

> [!check] ✅ The mnemonic carve-out — *(editor, 14 July 2026)*
> The Examiner-Tip ban targets **technique and meta** — how to revise, how to lay out working, what the examiner is looking for. It does **not** catch a **mnemonic whose answer is itself spec content**.
>
> **MRS GREN** is the worked case. It appears in the revision note as an Examiner Tip, but the thing the card asks the student to recall — the seven characteristics of living organisms — *is* the spec point. The mnemonic is the retrieval handle, not the content. Cards built on it are permitted, and score normally.
>
> The test: **strip the mnemonic away — is what remains something the student is examined on?** If yes, the card is legitimate. If what remains is advice about how to sit the exam, it is a tip and must not be a card.
- **Grounding** — read the subtopic's **published revision note** and check every fact, figure, definition and True/False correction against it. The RN is a **correctness check, not a wording template**: reworded content is expected and fine. Flag only what is wrong or contradicts the RN.

---

## 📊 The 10 CQI criteria, adapted for flashcards

The unit of scoring is the **set**. Draw evidence from individual cards.

**Critical criteria must score 5. Standard criteria must score 4. Total ≥ 43/50. A failed critical fails the set regardless of total.** A Standard criterion below 4 also fails the set, whatever the total.

> [!danger] 🚫 The scale is qualitative bands — it is **not** arithmetic deduction — *(editor, 14 July 2026)*
> | Score | Means |
> |---|---|
> | **5** | Done very well, consistently |
> | **4** | Between 5 and 3 |
> | **3** | Done mediocrely, **or** done inconsistently |
> | **2** | Between 3 and 1 |
> | **1** | Not done at all, or done very badly |
>
> Do **not** start at 5 and subtract a point per offending card. There is no deduction table and there must never be one. Ask *how well, and how consistently, does this set do this thing* — then pick the band. Two sets with the same defect count can land on different scores if one is otherwise strong and the other is not.
>
> The word that does most of the work is **consistently**. A rule applied to every card is a 5. A rule applied to some cards and not others is a 3 — inconsistency alone puts a criterion in the middle band, however good the cards that do comply.

### 🧮 Per-science averages and the science-level verdict — *(editor, 16 July 2026)*

Every review reports, **per science** (biology, chemistry, physics), four numbers side by side on the `Scores` tab:

| Column | What it is |
|---|---|
| **Sets** | scored sets in that science |
| **Average /50** | mean of the Total column for that science, 1 dp |
| **Sets passing** | sets meeting the full rubric |
| **Pass rate** | sets passing ÷ sets |
| **Verdict** | **PASS** only if *every* scored set in that science passes; otherwise **FAIL** |

> [!danger] 🚫 The average is **not** the verdict — never report it alone
> A science can average **well above 43 and still be a total FAIL**, because a failed Critical fails a set outright regardless of total. CIE 0654 is the worked example: **Physics averaged 43.1 — above the threshold — with 1 set in 9 passing.** An average that reads as a pass over a science where nothing passes is worse than no number at all.
>
> Always show **Average, Pass rate and Verdict together**. The average tells you *how far off* the course is; only the pass rate and verdict tell you *whether it ships*.

**Per-set `Pass?` column (`Scores!S`)** — the science verdict is meaningless unless the rubric is visible per row. One formula per set row, mirroring the rubric exactly:

```
=IF(COUNT(H2:R2)<11,"",IF(AND(H2=5,I2=5,J2=5,MIN(K2:Q2)>=4,R2>=43),"PASS","FAIL"))
```

`H:J` are the three Criticals (all must be 5), `K:Q` the seven Standards (min ≥ 4), `R` the total (≥ 43). The `COUNT(...)<11` guard blanks legend and notes rows, so the column can run the full height of the sheet.

Summary block lives to the **right** of the data (`U1:Z5`) on full-column `COUNTIFS`/`AVERAGEIFS`, never below it — appended rows must flow into the figures automatically and must never collide with a fixed block. The log is **append-only**: a Scores dashboard plus flat one-row-per-issue tabs, never per-set blocks at fixed row positions.

> [!warning] ⚠️ Write scores with `valueInputOption: "USER_ENTERED"` — RAW makes them text
> `updateGoogleSheet` defaults to **RAW**, which stores `44` as the *string* `"44"`. `COUNT`, `AVERAGEIFS` and `MIN` **silently skip text**, so a sheet with RAW-written scores averages only the numeric subset and reports it without complaint — no error, no warning, just a wrong number.
>
> This had already happened on the CIE 0654 sheet: **17 of 28 set rows were text**, and the first per-science averages came out over 14 rows instead of 28 (Chemistry read 41.0 across 3 sets, not 9). Caught only because the `Pass?` column came back blank on rows that plainly had scores.
>
> **Check before trusting any figure on a CQI sheet:** `=SUMPRODUCT(--ISTEXT(H2:R2))` must be `0`. If it isn't, rewrite the score rows with `USER_ENTERED` and re-read the summary.

### Critical

**Specific** — every card tests genuine spec content a student must know. Correct exam-board terminology. Spec points correct and drawn from the subtopic. Not trivia, not examiner-tip meta, nothing beyond the spec.

**Accurate** — every front and back fact, definition, figure and True/False correction is **correct**. Fill-in-the-blank answers correct. Nothing invented.

> [!important] 🧪 The test is *is it true*, not *is it worded like the RN* — *(editor, 9 July 2026)*
> Authors reword. A back that says the cell membrane is **partially permeable**, or that the cell wall stops the cell **bursting**, is correct biology even where the revision note phrases it differently or omits it. Do **not** deduct for that.
>
> Deduct only for a fact that is **wrong**, or that **contradicts** the revision note. Use the RN as a correctness check, not as a wording template.

> [!danger] 🧬 Inheriting an error from the revision note is **not a defence** — *(Leander, 30 July 2026)*
> Where a card reproduces a **notation or formatting** slip from its revision note — a Latin `v` for `ν`, a capitalised "Pascals", plain text where a fraction belongs — the finding moves **off the set and onto the note**, and the set's criterion stays at 5. That much is settled *(21 July 2026)*.
>
> **It does not extend to wrong physics.** Where the inherited error is substantive — a false definition, a wrong threshold, a figure that misclassifies — it is flagged **twice**: once on the set under **2 Accurate**, and once on the note. Both rows, every time. The card is what the student memorises; that it was copied faithfully changes nothing about what it teaches.
>
> **The dividing line is the misconception test, not the source.** Ask what a student who believes this card would get wrong. Accepted board modelling convention is not an error — *"the only force acting on a projectile is gravity"* is how the boards themselves write it, and `flst_fpdHV7JTyRhtcdzs` states the caveat one card later. A definition no board uses is — `fl_7DKkYJr9fJ6RTjqP` calling internal resistance *"the resistance between the terminals of a power supply"* names the external circuit, and it is a `keyword_definition`, the card whose only job is the definition.
>
> **2 Accurate is Critical**, so a substantive inherited error fails the set. There is no version of flagging it that leaves the set passing — say so plainly when you report it.

**Concise** — fronts short and closed. Backs the shortest *correct* answer, with no padding and no surrounding detail. No multi-part fronts. **Score this hardest — concision is the entire point of a flashcard.**

> [!important] ✂️ Concise is about one card's own wording — *(editor, 9 July 2026)*
> Judge each card on its own phrasing: is this front wordy, is this back padded, does this front ask two things?
>
> It is **not** about the set. Two cards touching the same spec point from different angles is deliberate reinforcement, not repetition. Do not deduct for it.

### Standard

**Correct** — spelling, grammar, UK English for UK boards and US English for AP. House Style punctuation. The flashcard full-stop rule. `Define **term**.` phrasing.

**Consistent** — alignment convention applied uniformly. Bold-key-term convention on every card. T/F two-line layout uniform. Same card-type framing throughout. Matches the conventions of the existing set.

**Sensitive** — PARSNIPS; inclusive, gender-neutral language; diverse names and examples; sensitive topics handled without opinion or stereotype. See `sensitivity-cqi-reference.md`, bundled in this folder. If nothing sensitive is present, score 5.

**Structured** — correct type enum for each framing. One idea per card. No multi-part fronts. T/F and fill-in-the-blank two-line layouts correct. Sensible set ordering.

**Formatted** — renders cleanly in Cobalt. `{align=center}` present on short fronts, absent on backs. Valid bold markdown. Correct gap marker for blanks. Bullets only for genuine short lists.

**Tone** — clear, direct, student-facing recall voice. Not jokey. No exam-technique commentary and no hedging on the card.

**Pitch** — language level right for the qualification and age. Accessible, but teaching to the top. The back is recall-sized, not an essay.

---

## 🚫 Do NOT flag these

Accepted conventions that read like defects but are not:

1. `{align=center}` on a short front — correct
2. A back with no alignment markup — backs are always left-aligned; never flag a back as missing alignment
3. **"True or False?" stored under `true_or_false`** — correct; the type was added to the CMS in mid-July 2026. Stored under `question_and_answer` on an older set — also correct, and legacy. Never flag either, and never flag a set that mixes them *(Leander, 21 July 2026)*
4. A `fill_in_the_blanks` card — in scope and expected in every set
5. Absence of marks, AO tags, command words or a model answer — flashcards have none of these
6. **A back listing more options than the front asks for** — front says "Name three causes…", back gives five. Deliberate, so students see the full set of possible answers. Do not match the back count to the front number. *(editor, 29 June 2026)*
7. **The card count, high or low** — no floor, no cap; count is never a fail criterion *(editor, 16 July 2026)*. Never recommend trimming on count alone, and never flag a set as short because of its size. Still flag genuine repetition, and report an empty set.
8. **Any one gap marker, used throughout** — non-breaking space, `**______**`, thin `_`, spaced `_ _ _ _`, or bold dots `**..........**`. Flag only a set that mixes two. *(editor, 9 July 2026)*
9. **Any one house convention, applied uniformly across a set** — fragment backs, full stops on back bullets. A set that is uniformly "old style" is a consistent set, and consistency is what the Consistent criterion measures. *(editor, 9 July 2026)*
10. **Keyword front phrasing, however it is mixed** — `Define the term **pressure**.`, `What does kinetic theory state?` and `Cytoplasm` may all sit in the same pack. Front wording is not a convention at all, so mixing it is not an inconsistency. *(Leander, 14 July 2026)*
10. **A card built on a mnemonic that appears in the RN as an Examiner Tip** — MRS GREN and its kind. The mnemonic is a retrieval handle for spec content, not exam-technique meta. See the mnemonic carve-out under **📚 Set-level checks**. *(editor, 14 July 2026)*
11. **A missing tier marker on a set that is entirely Core content** — correct. Record it in *Not flagged* so the next reviewer does not re-raise it.
12. **Source markup that looks wrong but renders correctly.** *(editor, 14 July 2026)*
13. **Stray spaces inside bold markup** — `**True. **`, `**you **can`, `**barium **nitrate`. Endemic in AI-generated cards and invisible to the student. Not a Correct defect, not a Formatted defect, not an advisory. *(Leander, 16 July 2026)*

> [!danger] 🖥️ Proof the rendered card, not the source string
> The MCP hands you raw markup. Cobalt's renderer is more forgiving than the string suggests, and a defect that does not reach the student is not a defect.
>
> The worked case: `fl_jpb2HsSHSpZdW45k` was flagged for `$average = \frac{total value}{number of values}$` on the reasoning that bare words inside `$…$` typeset as italic variables. **It renders fine on screen.** The flag was withdrawn and the Physics set went from 39 to 40.
>
> Before flagging any **rendering** defect — LaTeX, alignment markup, bold runs, gap markers — establish that it actually renders wrong. If you cannot see the card, **score it as not-a-defect and park a `Rendering` query** — never assert it, and never stop the run to ask for a look. Not-a-defect is the honest default for something you have not seen fail, and the query is what lets it be overturned later at no cost. Structural, factual and consistency defects are unaffected: those are true of the content whatever it looks like on screen.

> [!success] ✅ Settled: `getFlashcardSet` does **not** strip `{align=center}`
> **Do not re-open this. Alignment needs no rendered-card look.** *(verified 16 July 2026, CIE 0654 review)*
>
> `getFlashcardSet` returns alignment markup **intact where the author put it**. `flst_DxQrT3zrPqgThsZP` (Electrical Objects — Electrical Safety, Formatted 5) returns `{align=center}` verbatim on all 10 fronts, and **twice** on the two-line True/False card `fl_yPJD2crzJMWNkvWd`, once per line.
>
> So for this one class the payload is the evidence: **marker absent from the payload = marker absent from the card = real defect.** Flag it under **Formatted** on the markup alone.
>
> **Why this is worth stating.** The CIE 0654 review talked itself out of ~20 valid findings by reasoning from the **merged-cell table rule** — *"the MCP shows a lossy view, don't trust the string"*, the standing rule that a Cobalt table must never be written back because `findQuestion` returns a lossy serialisation of it — and treating alignment as another instance of it. It is not. **The table rule is about tables; it does not generalise to every markup class.** The test that settles a strip-vs-absent question is cheap and takes one call: *find a card where the marker is present*. If the MCP ever returns it, the MCP preserves it. Run that test before hedging, and before asking the editor to go and look at a card.

---

## 📏 Conventions vs absolutes

> [!important] 🎯 The proofing principle
> **The convention a set picks does not matter. Picking two does.** *(editor, 9 July 2026)*

A live check on `flst_3zW7whg9GKCQXS7D` — AQA A Level Biology, **published**, created 2 July 2026 — found spaced-underscore gaps, question-framed keyword fronts (`What is a **proto-oncogene**?`) and fragment backs. All three are "wrong" against the authoring rules above. All three are in content shipped last week. A proofing rubric that fails them fails most of the estate, and would be ignored within a fortnight.

So the rules split in two, and a proofer must know which tier a rule sits in before deducting for it.

### ⛔ Absolute — always flag, whatever the set does elsewhere

Structure and correctness. These hold regardless of house convention.

- an **empty set** (report as "nothing to review"); no `fill_in_the_blanks` card; no "True or False?" card — **card count itself is never a finding** *(editor, 16 July 2026)*
- a card with no spec point, or tagged outside the set's own subtopic
- **more than 3 words blanked** on a `fill_in_the_blanks` card, or a blank whose answer is ambiguous. Three is a cap, not a guideline
- a `fill_in_the_blanks` back that does not restore the whole sentence with the answers bolded — a bare-answer back is a defect
- "True or False?" not in the two-line layout. **The type itself is never a finding** — `true_or_false` is correct, and `question_and_answer` is correct-and-legacy *(Leander, 21 July 2026)*
- **`True or False?` on the front, or `True.` / `False.` on the back, not bolded.** The style page mandates the bold on both, and its worked examples carry it. Flag the missing bold, not just the missing line break
- `{align=center}` on a back; a centred multi-sentence or `fill_in_the_blanks` front
- **`{align=center}` missing from a one-line front.** The style page words this as a mandate, so *absence* is a defect in its own right — it is not merely a convention to be applied uniformly. The exceptions are the ones the page names: fronts that wrap to two or more lines, `fill_in_the_blanks` fronts, and every back. **One line means ≤ 83 rendered characters** (see *The measurable form*, above)
- **on a tiered course, a card carrying Extended-tier content with no tier marker** — `**(Extended Tier Only)**` or `**T**`, bold and bracketed, after the content on the front. Check the course's tier structure before proofing: CIE 0654 Co-ordinated Sciences, CIE 0620 Chemistry and the other Core/Extended IGCSEs all need this. Where a set is entirely Core content the absence is correct — say so in *Not flagged* rather than leaving it unaddressed
- a multi-part front — two questions on one card
- an Examiner Tip turned into a card; a fact that is wrong, or that contradicts the subtopic revision note
- spelling, grammar, or the wrong language variant
- ALL CAPS used for emphasis — House Style bolds instead (`but **not** in animal cells`)

### 🔁 Conventional — flag only when the set is internally inconsistent

Deduct under **Consistent**, never under Formatted or Structured. Name the convention the majority of cards use, quote the deviants, say which way to reconcile.

| Convention | Variants seen in the estate |
|---|---|
| Gap marker | underlined non-breaking space · `**______**` · thin `_` · spaced `_ _ _ _` · bold dots `**..........**` |
| ~~Keyword front framing~~ | ~~`Define **term**.` · `What is a **term**?`~~ — ❌ **not a convention. Free choice, never flagged** (Leander, 14 Jul 2026) |
| Back phrasing | **restating** — a full sentence that repeats the question stem before the answer · **direct** — answers without restating |
| Full stops on back bullets | present · absent |

> [!tip] 📝 Judging back phrasing
> The test is **restating vs direct**, not *sentence vs fragment*. `A **mutation** causes constant activation…` is a complete sentence but does not restate its question stem, so it sits in the same convention as the fragment `From **uncontrolled mitosis**…`. A set of ten direct backs is consistent, whatever their grammar.

A set that is uniformly old-style scores **5** on Consistent. That is the correct outcome.

---

## 🎯 Common defects to flag

| Defect | Criterion |
|---|---|
| A back padded with surrounding detail, or a needlessly wordy front | Concise |
| A multi-part front that should be two cards | Concise / Structured |
| ALL CAPS for emphasis instead of bold | Correct |
| Bare-fragment backs **and** full-sentence backs mixed in one set | Consistent *(a set uniformly one or the other is fine — see 📏 Conventions vs absolutes)* |
| True or False? on one line, or missing the two-line back — **not the type, which is never a finding** | Structured |
| A fill-in-the-blank with an ambiguous gap, or >~3 words removed | Formatted / Structured |
| A fill-in-the-blank back that does not restore and bold the whole sentence | Formatted / Structured |
| `{align=center}` on a back, or centred on a front that wraps to two or more lines / a fill-in-blank front | Formatted / Consistent |
| `{align=center}` **missing** from an unambiguously one-line front | Formatted |
| `True or False?` / `True.` / `False.` present but **not bolded** | Formatted / Structured |
| No key term bolded on a back | Formatted |
| Extended-tier content on a tiered course with no `**(Extended Tier Only)**` / `**T**` marker | Specific / Structured |
| A card untagged, or tagged with a spec point from another subtopic | Specific |
| A fact, figure or definition that is wrong, or contradicts the subtopic RN | Accurate |
| An Examiner Tip turned into a card | Accurate / Specific |
| An empty set, or one with no fill-in-blank / no True or False? — **never a set's card count** | Set-level |

---

## ⚙️ Operational notes

> [!danger] 🚫 A CQI **never** edits content — no exceptions
> Proofing is **report-only**. Never write to Cobalt from a review — no `updateFlashcard`, no `createFlashcards`, not even to correct a single-character typo. Hand over a clean edit list and stop there.
>
> The fix belongs to the **author**. Where a tweak is small enough to be worth making directly rather than sending back, that is an **editorial call and it is Leander's alone**. Claude never makes it and never proposes making it as part of a review.
>
> **A review that ends in a write is a review that went wrong.** The `updateFlashcard` / `createFlashcards` details below describe the fix path *for whoever ends up actioning it* — they are not a licence to action it.

**Cards cannot be deleted or reordered via MCP.** Both are Cobalt UI actions. Removing a duplicate means flagging it, not fixing it.

**Sets can be shared across courses.** `getFlashcardSet` lists every reference and its publication status. Because `updateFlashcard` edits the underlying set, an edit lands in **every** course that references it — including published ones. Always check references and warn before any edit to a multi-course or published set.

**ID prefixes:** `flst_` = flashcard set · `flstrf_` = set reference (a course's link to a set) · `fl_` = individual flashcard · `sbt_` = subtopic · `top_` = topic · `spcpt_` = spec point · `rn_` = revision note

**Feedback quality bar.** Every flag must name the offending card (quote its front and back), cite the rule it breaks, and state the fix. "Needs improvement" with no specifics is itself a fail. Calibrate to the audience — internal reviews get scores and evidence; freelancers get a collaborative numbered edit list with no scores, labels or criterion names.

---

## 📝 Where results get logged

> [!important] 🗂️ QA Logs, never Projects
> A flashcard CQI is **oversight output** — evidence of applying the bar. It belongs in the QA log and its per-course pages, **not** in `Projects/`, which is content-build R&D. Do not create a project page for a CQI run. (Both are Obsidian pages in the Development Editor vault; if you do not have the vault, the Google Sheet is the record and there is nothing further to file.)

Every set scored is written to **two** places:

1. **The per-course page** — `QA Logs\<board-level-subject>.md`. One `## YYYY-MM-DD — \`flst_…\` — Science · Subtopic` section per set, newest at the top
2. **The index** — `QA Logs\QA Log.md`. A row in the **📚 Course pages** table (create the page and the row together if the course is new), and a row at the **top** of the **🧾 Master log**: date · course · `flst_…` · scope · per-criterion string · score · result

### What a course-page entry contains

> [!important] ✍️ Write it for the author, not for the file — *(editor, 9 July 2026)*
> The course page is what the summary report to authors is built from. Authors have the flashcard ID, so they can go straight to the card. Give them the card, the error and the fix — nothing they have to interpret.

A heading, a one-line score and verdict, the metadata (`flstrf_…`, `cms_url`, published status, subtopic, RN, composition), then **one table of issues**:

| Criterion | Card | Issue | Fix |
|---|---|---|---|

- **Card** — the `fl_…` ID. Set-level issues take `—`
- **Issue** — what is wrong, one line, quoting the offending text
- **Fix** — the corrected string, ready to paste. Not "consider bolding"

**One defect, one criterion** (CQI page, 17 Jul 2026). A single defect never loses marks under two criteria — pick the one where it counts most, score it there, and leave the other alone. A wordy, cluttered mark scheme is a *Concise* failure **or** a *Formatted* one, not both. One defect is still **one row**, naming the criterion it is docked under; the author fixes it once. The row may note a knock-on effect, but only one criterion loses marks.

Below the table: advisory coverage observations, and a *Not flagged* line recording the conventions deliberately accepted — that line is what stops the next reviewer re-flagging them.

**Do not** reproduce the full ten-criterion scorecard on the page. The per-criterion detail lives in the master-log string; the page carries only what someone has to act on.

The per-criterion string is the ten scores in fixed order, dot-separated, with anything below 5 bolded:

```
5·5·**4**·**4**·5·5·**2**·**2**·5·5
```

Order: **1** Specific · **2** Accurate · **3** Concise · **4** Correct · **5** Consistent · **6** Sensitive · **7** Structured · **8** Formatted · **9** Tone · **10** Pitch.

Where a course is checked science by science, the course page also carries a **convention profile** table — gap marker, keyword front framing, back phrasing, bolding, alignment — one row per science. The **keyword front framing** column is descriptive only: front phrasing is a free choice, so nothing in that column can be a finding. Filling it as each science is scored is what makes the later cross-science comparison cheap: the inconsistencies between sciences are read off the table, not re-derived from the sets.

The course page is the raw material. The **summary report to authors** is written from it by hand, and is not the log.

---

## 🔗 Sources

**Notion:**
- [Flashcard Style Guidance [WIP]](https://app.notion.com/p/0248b4fa839342fcb16ba35dad3cccfe) — the fullest style page; lives under SME House Style Guide (V1). Stale on the 8 July back-format rules. Has a near-duplicate, *Flashcard Style Guidance [WIP] (1)* (`bed8627a…`), untouched since June 2024 — ignore it.
- [🎴 Flashcard Style](https://app.notion.com/p/382847b30a5f8104a014fa6c24cdb829) — Vicky's page; the `/flashcard_style` skill. **The canonical format authority — it wins wherever it conflicts with the two pages below** *(editor, 16 July 2026)*. Stale on gap marker and back format. **Not stale on card count**: its 5–8 is generation guidance, and it sets no floor.
- [🃏 Flashcard Gen](https://app.notion.com/p/37a847b30a5f81d7ab0fdb9fefbdf778) — Bridgette's generator. Origin of the unattributed "minimum 10", which this rubric no longer applies. Also carries a stale cross-reference to Proof-Flashcard's card count.
- [🔍 Proof-Flashcard](https://app.notion.com/p/38b847b30a5f8183aadcea728fd48812) — Bridgette's QA counterpart; the most up-to-date page on format. Still enforces the 10 — that part does not govern a CQI.

**Vault:**
- The QA hub in the Development Editor vault, if you have it
- `sensitivity-cqi-reference.md` (bundled in this folder) — the Sensitive criterion in depth
- The **SFMA Gold Standard** — the exam-question rubric, held separately in the Development Editor vault. Named here only for contrast: **do not apply it to flashcards.**

**Skills:** `/proof-flashcard` (QA) · `/flashcard-gen` (generate) · `/flashcard_style` (house style)
