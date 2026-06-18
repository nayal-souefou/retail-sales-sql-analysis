-- ============================================================
-- ANALYSE SQL — RETAIL SALES DATASET
-- 9 questions métier traitées avec JOIN, GROUP BY, HAVING,
-- sous-requêtes, CTE et window functions.
-- ============================================================

USE retail_sales;

-- ------------------------------------------------------------
-- Question 1 : Quel est le nombre de ventes par catégorie de produit ?
-- ------------------------------------------------------------
SELECT `Product Category`, COUNT(*) AS total_nombre
FROM retail_sales_dataset
GROUP BY `Product Category`;

-- Résultat : Beauty 307, Clothing 351, Electronics 342


-- ------------------------------------------------------------
-- Question 2 : Quel est le chiffre d'affaires total par catégorie,
-- du plus élevé au plus faible ?
-- ------------------------------------------------------------
SELECT `Product Category`, SUM(`Total Amount`) AS total_ventes
FROM retail_sales_dataset
GROUP BY `Product Category`
ORDER BY total_ventes DESC;

-- Résultat : Electronics 156905, Clothing 155580, Beauty 143515


-- ------------------------------------------------------------
-- Question 3 : Quelles catégories ont un montant moyen par vente
-- supérieur à 400 ?
-- ------------------------------------------------------------
SELECT `Product Category`, AVG(`Total Amount`) AS moyen
FROM retail_sales_dataset
GROUP BY `Product Category`
HAVING AVG(`Total Amount`) > 400;

-- Résultat : Beauty 467.48, Clothing 443.25, Electronics 458.79


-- ------------------------------------------------------------
-- Question 4 : Combien de clients distincts par genre ?
-- ------------------------------------------------------------
SELECT Gender, COUNT(DISTINCT `Customer ID`) AS nombre
FROM retail_sales_dataset
GROUP BY Gender;

-- Résultat : Female 510, Male 490


-- ------------------------------------------------------------
-- Question 5 : Quel est le chiffre d'affaires par tranche d'âge
-- (regroupé par dizaines) ?
-- ------------------------------------------------------------
SELECT FLOOR(Age / 10) * 10 AS tranche_age, SUM(`Total Amount`) AS total
FROM retail_sales_dataset
GROUP BY tranche_age
ORDER BY tranche_age;

-- Résultat : 10-19 ans: 26085 | 20-29: 97070 | 30-39: 96325
--            40-49: 93365 | 50-59: 98340 | 60+: 44815


-- ------------------------------------------------------------
-- Question 6 : Quelles catégories ont vendu plus de 800 unités
-- au total ?
-- ------------------------------------------------------------
SELECT `Product Category`, SUM(Quantity) AS total_vendu
FROM retail_sales_dataset
GROUP BY `Product Category`
HAVING SUM(Quantity) > 800;

-- Résultat : Clothing 894, Electronics 849


-- ------------------------------------------------------------
-- Question 7 : Quels clients dépensent au-dessus de la moyenne
-- générale de toutes les ventes ? (SOUS-REQUÊTE)
-- ------------------------------------------------------------
-- La sous-requête entre parenthèses calcule d'abord la moyenne
-- générale ; la requête principale s'en sert comme seuil de
-- comparaison dans le HAVING.
SELECT `Customer ID`, SUM(`Total Amount`) AS total_client
FROM retail_sales_dataset
GROUP BY `Customer ID`
HAVING SUM(`Total Amount`) > (
    SELECT AVG(`Total Amount`) FROM retail_sales_dataset
)
ORDER BY total_client DESC;


-- ------------------------------------------------------------
-- Question 8 : Quelle part du chiffre d'affaires total chaque
-- catégorie représente-t-elle ? (CTE)
-- ------------------------------------------------------------
-- La CTE "ventes_par_categorie" calcule le total par catégorie,
-- puis la requête principale réutilise ce résultat pour calculer
-- un pourcentage du total global.
WITH ventes_par_categorie AS (
    SELECT `Product Category` AS categorie, SUM(`Total Amount`) AS total_categorie
    FROM retail_sales_dataset
    GROUP BY `Product Category`
)
SELECT categorie, total_categorie,
       ROUND(total_categorie * 100.0 / (SELECT SUM(total_categorie) FROM ventes_par_categorie), 2) AS pourcentage_du_total
FROM ventes_par_categorie
ORDER BY total_categorie DESC;


-- ------------------------------------------------------------
-- Question 9 : Quelles sont les 10 transactions les plus élevées,
-- avec leur classement ? (WINDOW FUNCTION)
-- ------------------------------------------------------------
-- RANK() OVER (...) ajoute un rang à chaque ligne individuelle,
-- sans fusionner les lignes comme le ferait un GROUP BY.
SELECT `Customer ID`, `Total Amount`,
       RANK() OVER (ORDER BY `Total Amount` DESC) AS rang
FROM retail_sales_dataset
LIMIT 10;
