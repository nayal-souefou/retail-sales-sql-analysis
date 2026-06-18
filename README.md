# Analyse SQL — Retail Sales Dataset

Analyse SQL d'un jeu de données de ventes retail, avec des requêtes répondant à des questions métier concrètes (chiffre d'affaires, comportement client, segmentation par âge et catégorie).

## Dataset

Source : [Retail Sales Dataset (Kaggle)](https://www.kaggle.com/datasets/mohammadtalib786/retail-sales-dataset)

1000 transactions, 9 colonnes : Transaction ID, Date, Customer ID, Gender, Age, Product Category, Quantity, Price per Unit, Total Amount.

## Outils

MySQL Workbench (MySQL 8.0)

## Structure du projet

- `schema.sql` : création de la table
- `questions_metier.sql` : les 9 requêtes avec leurs questions métier associées
- `README.md` : ce fichier

## Questions métier traitées

1. Nombre de ventes par catégorie de produit
2. Chiffre d'affaires total par catégorie, trié par ordre décroissant
3. Montant moyen par vente par catégorie, filtré sur les catégories les plus rentables
4. Nombre de clients distincts par genre
5. Chiffre d'affaires par tranche d'âge (regroupement par dizaines)
6. Quantité totale vendue par catégorie, filtrée sur les catégories à fort volume
7. Clients dépensant au-dessus de la moyenne générale (sous-requête)
8. Classement des catégories par part du chiffre d'affaires total (CTE)
9. Top 10 des transactions les plus élevées avec classement (window function)

## Principaux résultats

Le chiffre d'affaires est réparti de façon assez équilibrée entre les trois catégories (Electronics, Clothing, Beauty), chacune représentant environ un tiers du total. La catégorie Beauty se distingue par une valeur moyenne par transaction plus élevée malgré un volume de ventes plus faible, suggérant des achats moins fréquents mais plus coûteux. La clientèle est répartie de façon quasi paritaire entre hommes et femmes, et le chiffre d'affaires est porté principalement par les tranches d'âge 20 à 59 ans.

## Auteur

Souefou — Étudiant en Master Intelligence Artificielle (NEXA Digital School, Lyon)
