# Evatika Project Delivery Skill

Skill Codex pour cadrer, developper, diagnostiquer, deployer et documenter des projets clients Evatika avec un niveau de rigueur adapte a la production.

Le skill est volontairement generique, mais technique. Il formalise des pratiques reutilisables issues de projets clients reels : integrations SQL/API/Power Automate/Supabase, deploiement Docker/GitHub Actions/VPS, incidents de production, observabilite, UX terrain et documentation dirigeant/prestataire.

Ce depot ne contient pas de donnees client, de secrets, de configuration de production ni de procedure dependante d'une infrastructure privee. Les exemples restent au niveau des pratiques et des checklists.

## Contenu

```text
evatika-project-delivery/
  SKILL.md
  agents/openai.yaml
  references/
    project-discovery.md
    integration-contracts.md
    production-release.md
    diagnosis-and-observability.md
    ux-mobile-review.md
    documentation-and-handover.md
```

## Installation locale

Depuis la racine du depot :

```bash
./install.sh
```

Le script copie le dossier `evatika-project-delivery` dans :

```text
~/.codex/skills/evatika-project-delivery
```

Si le dossier existe deja, il est remplace par la version du depot.

## Utilisation

Dans Codex, demander explicitement :

```text
Utilise $evatika-project-delivery pour cette tache.
```

Le skill peut aussi etre declenche implicitement sur les demandes de type :

- developpement projet client ;
- audit ou refactoring prudent ;
- integration SQL/API/Power Automate/Supabase ;
- deploiement Docker/VPS/GitHub Actions ;
- incident de production, CPU, latence, sync ;
- UX mobile/tablette ;
- documentation dirigeant, prestataire ou runbook.

## Principes

- Lire le projet avant de modifier.
- Separer prototype, cible, production, legacy et contournement temporaire.
- Traiter les integrations comme des contrats.
- Ne jamais exposer de secrets.
- Verifier avant de declarer termine.
- Documenter les decisions et les procedures.
- Deployer avec rollback connu.

## Maintenance

Le skill doit rester court et actionnable :

- `SKILL.md` contient les invariants et le routeur vers les references ;
- les details vivent dans `references/` ;
- ajouter des scripts seulement si une procedure est repetee sur plusieurs projets ;
- eviter de transformer le skill en historique de projet.

## Licence

Ce projet est publie sous licence MIT. Voir `LICENSE`.
