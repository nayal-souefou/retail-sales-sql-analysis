-- Création de la base et de la table pour le projet Retail Sales
-- Dataset source : https://www.kaggle.com/datasets/mohammadtalib786/retail-sales-dataset

CREATE DATABASE IF NOT EXISTS retail_sales;
USE retail_sales;

CREATE TABLE retail_sales_dataset (
    `Transaction ID` INT PRIMARY KEY,
    `Date` DATE,
    `Customer ID` VARCHAR(20),
    `Gender` VARCHAR(10),
    `Age` INT,
    `Product Category` VARCHAR(50),
    `Quantity` INT,
    `Price per Unit` DECIMAL(10,2),
    `Total Amount` DECIMAL(10,2)
);

-- Les données sont importées via le Table Data Import Wizard de MySQL Workbench
-- à partir du fichier retail_sales_dataset.csv téléchargé sur Kaggle.
