# Job application tracker UI

    ./tracker/start.sh            # starts on http://127.0.0.1:8765 and opens the browser
    ./tracker/start.sh --port 9000 --no-open

## What it does

- Reads the tracker spreadsheet and each run's application folders straight from disk. Both
  layouts are picked up automatically: the older `applications_YYYY-MM-DD/` and the newer
  `search-YYYY-MM-DD/applications/`. New dates appear in the dropdown on their own —
  nothing to configure. The newest date is selected by default.
- Each spreadsheet row is matched to its generated documents folder by company name +
  location, so **Copy letter** pulls the real text out of the `.docx` for that job (top matches
  only — most rows are outreach-only, no cover letter).
- The tick box writes `Status` (`Applied` / `Ready to Apply`) and `Date Applied` back into the
  spreadsheet immediately. The workbook is backed up to `tracker/backups/` before the first
  write of each run.
- The **Match ≥** slider hides anything scoring below the threshold (5% steps). It stacks with
  the chips and the search box, sticks across reloads, and the `×` next to it clears it. Rows
  with no fitness score are hidden while the threshold is above 0.
- **Open all links** opens every visible, not-yet-applied job URL in your default browser
  (via macOS `open`, so no popup blocker). Filter first, then open all — it respects the
  search box and the chips.
- If a dated folder exists but the spreadsheet has no rows for that date yet, the folders are
  listed anyway so the documents are still reachable (tick box disabled for those).

## Outreach — contacts, referrals and drafts

Runs that did an outreach pass write `search-<date>/raw/outreach.json`, and the UI folds it
into the matching rows:

- **Badges** on the row show `N contacts` and `N connections`. Hover either one to see every
  name and title. Connections are gold — those are warm routes, worth more than the form.
- **The top contact** is printed under the row with their title, and a direct link per channel
  found — 📞 `tel:`, 📧 `mailto:`, 💼 LinkedIn — no verification or source labels, just the route.
- **Best route** — the one-line recommendation from the outreach pass — sits in the
  accented block beneath.
- **Buttons**: `Connection notes`, `Direct messages`, `Referral ask`, `Draft reply` and
  `Contacts` open the drafted `.txt` files; `JD` shows the captured job description. Nothing is
  ever sent for you — these are drafts to copy and send yourself.
- **Chips**: `Has contacts`, `Has referral route` and `Outreach drafts` filter to rows with
  a human route. The search box also matches contact and connection names.
- Outreach now runs across every relevance-gated match with a findable contact, not just a
  handful of top picks — expect contacts/drafts on most rows, not only the top of the list.

Two folders in a run aren't job applications and get expanded into their own rows, one per
draft file, with the tick box disabled:

- `_FreshlyFunded_NoPostingYet` — startups that just raised, with a congrats-on-the-raise
  email. There's no listing to apply to yet, which is the point.
- `_RecruiterPosts_ReplyDirectly` — LinkedIn hiring posts with a drafted reply to the person.

Rows the search later disqualified are marked `Filtered Out` in the spreadsheet with the
reason in **Next Action**; they show with a struck-through badge so they don't get applied to
by accident.

## Which spreadsheet

An `.xlsx` inside the dated folder wins; otherwise it falls back to the tracker workbook in
the project root, filtered to the selected date. Data is re-read on every request, so editing
the sheet in Excel and hitting **Refresh** is fine — but close Excel before ticking boxes,
Excel holds a lock and can overwrite writes made while it's open.

## Shortcuts

- `/` focuses the search box
- click **Connection notes** / **Direct messages** / **Contacts** / **JD** to read a draft before
  sending; the dialog has Copy and Open in Word/file
- **Folder** reveals the job's documents in Finder for uploading
