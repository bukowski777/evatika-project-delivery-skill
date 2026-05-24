# Maintenance du skill

## Quand modifier le skill

- Une pratique Evatika se repete sur plusieurs projets.
- Une erreur couteuse aurait pu etre evitee par une checklist.
- Une procedure fragile merite un script ou une reference dediee.
- Un vocabulaire ou une distinction revient souvent dans les projets clients.

## Quand ne pas le modifier

- Cas trop specifique a un seul client.
- Historique narratif d'un incident deja resolu.
- Regle triviale deja couverte par les consignes globales.
- Procedure automatisable directement dans un script projet.

## Verification avant commit

```bash
find evatika-project-delivery -maxdepth 3 -type f | sort
sed -n '1,120p' evatika-project-delivery/SKILL.md
./install.sh
```

Le `SKILL.md` doit rester compact. Les details vont dans `references/`.

