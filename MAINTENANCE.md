# Skill Maintenance

## When to Update the Skill

- An Evatika practice repeats across several projects.
- A costly mistake could have been avoided with a checklist.
- A fragile procedure deserves a script or dedicated reference.
- A vocabulary term or distinction keeps coming back in client projects.

## When Not to Update It

- A case is too specific to one client.
- A narrative history of an already resolved incident.
- A trivial rule already covered by global instructions.
- A procedure that should be automated directly in a project script.

## Pre-Commit Verification

```bash
find evatika-project-delivery -maxdepth 3 -type f | sort
sed -n '1,120p' evatika-project-delivery/SKILL.md
./install.sh
```

`SKILL.md` should stay compact. Details belong in `references/`.
