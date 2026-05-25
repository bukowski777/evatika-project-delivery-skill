# UX and Mobile Review

Use this for dashboards, portals, admin screens, field/tablet/mobile usage, labels, copy, visual consistency, and client-facing workflows.

## Start From Work

Define:

- who uses the screen;
- where they use it;
- what decision/action they need;
- what data must be trusted;
- what can be hidden, collapsed, or removed;
- what happens when data is missing, stale, late, or wrong.

## Dashboard Rules

- Counts must represent actionable queues.
- Each count should lead to a distinct filtered list.
- Avoid technical labels unless they help the user act.
- Empty states should say what is true and what the user can do next.
- Recent items should have a clear freshness rule.
- Avoid showing raw source-system terms to field users unless they know them.
- Every displayed number should be explainable from a source query or business rule.

## Mobile / Tablet Rules

- Verify real viewport widths, not only desktop resize guesses.
- Collapse dense tables into readable cards when columns no longer fit.
- Keep primary identifiers, customer/equipment, status, date, and next action visible.
- Avoid horizontal scroll for the main workflow unless it is truly a spreadsheet task.
- Make tap targets large and stable.
- Keep sidebar/header behavior predictable.
- Test long labels, missing data, high counts, and slow loading.

## Text and Formatting

- Centralize date, money, status, identifiers, and empty-value formatting.
- Avoid raw database timestamps.
- Use consistent casing and accents in user-facing language.
- Remove instructional noise once the UI is self-explanatory.
- Prefer business terms over implementation terms.
- Distinguish "not configured", "no data", "loading", and "error" states.

## Accessibility Baseline

- Ensure primary actions are keyboard reachable when relevant.
- Preserve visible focus states.
- Use semantic headings and labels for forms.
- Do not rely on color alone for status.
- Keep contrast and font size readable for field conditions.

## Review Evidence

For a meaningful UX pass, collect or produce:

- desktop screenshot;
- tablet screenshot;
- phone screenshot;
- empty/loading/error state check;
- long names, long identifiers, missing data, and high-count check;
- note explaining how displayed numbers are computed.
