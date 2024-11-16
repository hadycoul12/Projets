-- Création de la table "Clients"
CREATE TABLE dlc.Clients (
    ClientID INT PRIMARY KEY,
    Nom VARCHAR(200),
    Prenom VARCHAR(200),
    Adresse VARCHAR(200),
    Email VARCHAR(200),
    NumeroTelephone VARCHAR(30)
);

-- Création de la table Fournisseurs
CREATE TABLE dlc.Fournisseurs (
	FournisseurID INT PRIMARY KEY,
    NomFournisseur VARCHAR(200),
    Adresse VARCHAR(100),
    Email VARCHAR(200),
    NumeroTelephone VARCHAR(200)
    );
    
-- Creation de la table employe
CREATE TABLE dlc.Employes (
	EmployeID INT PRIMARY KEY,
    Nom VARCHAR(200),
    Prenom VARCHAR(200),
    Fonction VARCHAR(200),
    Email VARCHAR(200),
    NuméroTelephone VARCHAR(200)
    ) ;
    
-- Création de la table produit
CREATE TABLE dlc.Produits (
	ProduitID INT PRIMARY KEY,
    NomProduit VARCHAR(255),
    DescProduit VARCHAR(255),
    PrixUnitaire DECIMAL(10, 2),
    FournisseurID INT,
    FOREIGN KEY (FournisseurID) REFERENCES Fournisseurs(FournisseurID)
    );
    
    
-- Modification de la création de la table vente pour intégrer l'identifiant de l'employe
CREATE TABLE dlc.Ventes (
    VenteID INT PRIMARY KEY,
    DateVente DATE,
    ClientID INT,
    ProduitID INT,
    EmployeID INT,
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (ProduitID) REFERENCES Produits(ProduitID),
    FOREIGN KEY (EmployeID) REFERENCES Employes(EmployeID),
    QuantiteVendue INT,
    MontantTotal DECIMAL(10, 2)
    );
    
    
    /* CLAUSE SELECT */
    
    -- L'ensemble des produits vendus
    SELECT *
    FROM Produits;
    
    -- Le nom de tous les produits de la base de données
    SELECT NomProduit
    FROM Produits
    
	-- les noms et prénoms distincts des employés de l'entreprise
	SELECT DISTINCT Nom, Prenom
    FROM Employes;

    -- les différentes dates auxquelles des ventes ont été réalisées
    SELECT DISTINCT DateVente
    FROM ventes;
    
    -- Liste produit vendu est à > 200
    SELECT *
    FROM produits
    WHERE PrixUnitaire > 200;
    
    -- Liste produit vendu compris et 50 et 100
    SELECT *      -- Premiere méthode
    FROM produits
    WHERE PrixUnitaire >= 50 AND PrixUnitaire <= 100;
    -- ou
	SELECT *      -- Premiere méthode
    FROM produits
    WHERE PrixUnitaire BETWEEN 50 AND 100;
    
    -- Information sur le produit "Nike Air Max" 
    SELECT *
    FROM produits
    WHERE NomProduit = "Nike Air Max";
    
    -- La liste des produits du fournisseur numéro 13
    SELECT *
    FROM produits
    WHERE FournisseurID = 13;
    
    
    /*======================================================*/
/* Fonctionnalité 8: Utilisation de IN dans la clause WHERE
Syntaxe générale:
SELECT nom_colonne
FROM nom_table
WHERE nom_colonne IN (valeur1, valeur2, ...);
======================================================*/
-- la liste des ventes aux clients 60 et 62    
SELECT *
FROM ventes
WHERE ClientID IN (60, 62);

/*======================================================*/
/* Fonctionnalité 9: Utilisation de BETWEEN dans la clause WHERE
Syntaxe générale:
SELECT nom_colonne
FROM nom_table
WHERE nom_colonne BETWEEN valeur1 AND valeur2;
======================================================*/    

-- Sélectionner les ventes réalisées entre le 1er janvier 2021 et le 31 décembre 2023   
SELECT *
FROM ventes
WHERE DateVente BETWEEN "2021-01-01" AND "2023-12-31";


/*======================================================*/
/* Fonctionnalité 10: Utilisation de LIKE dans la clause WHERE
======================================================*/

-- Nom des clients qui commencent par la lettre c et qui se termine par a 
SELECT *
FROM clients
WHERE Nom LIKE "c%a";

-- Le nom des clients qui contiennent  "on"
SELECT *
FROM clients
WHERE Nom LIKE "%on%";

/*==========================================================================================
                 La clause ORDER BY POUR CLASSER
==========================================================================================*/

-- Donner la liste des produits du moins coûteux au plus coûteux
SELECT *
FROM produits
ORDER BY PrixUnitaire ASC;

-- La liste des produits dont le prix est supérieur à 200, résultat par alphabétqiue suivant le nom du produit
SELECT * 
FROM produits
WHERE PrixUnitaire > 200
ORDER BY NomProduit ASC;

-- Liste des clients dont le nom contient une seule fois la lettre A
SELECT *
FROM clients
WHERE Nom LIKE "%a%" AND Nom NOT LIKE "%a%a%";

-- Contient deux occurrences de la lettre A
SELECT *
FROM clients
WHERE Nom  LIKE "%a%a%";

-- Liste des produits qui contiennent "TV" Avec REGEXP
SELECT *
FROM produits
WHERE NomProduit REGEXP "TV";

-- Liste des produits dont le nom commence par la lettre "D" Avec REGEXP
SELECT *
FROM produits
WHERE NomProduit REGEXP "^D";

-- Liste des produits qui se terminent par "M" Avec REGEXP
SELECT *
FROM produits
WHERE NomProduit REGEXP "M$";

-- Liste des clients dont le numéro contient "05" ou "94" Avec REGEXP
SELECT *
FROM clients
WHERE NumeroTelephone REGEXP "^05|94$";

-- Les clients dont le nom contient 'R' suivi de n'importe quel caractère et ensuite 'a' avec LIKE ET REGEXP
SELECT *
FROM clients
WHERE Nom LIKE "%r_a%";

SELECT *
FROM clients
WHERE Nom REGEXP "r.a";

-- Liste des clients dont le nom contient "it" ou "ie" ou "il" ou "is"  avec LIKE et REGEXP
SELECT *
FROM clients
WHERE Nom LIKE "%it%" OR Nom LIKE "%ie%" OR Nom LIKE "%il%" OR Nom LIKE "%is%";

SELECT *
FROM clients
WHERE Nom REGEXP "it|ie|il|is";

/*======================================================================
Limitation des résultats d'une requête avec LIMIT
======================================================================*/

-- Donner la liste des 10 premiers clients par ordre alphabétique
SELECT *
FROM clients
ORDER BY Nom 
LIMIT 10;

-- Donner la liste des 20 produits les plus chers
SELECT *
FROM produits
ORDER BY PrixUnitaire DESC
LIMIT 20;

/*==================================================================================
               Maîtriser les fonctions d'agrégation en SQL
==================================================================================*/

-- Nombre de clients dans la base de données ?
SELECT COUNT(*) AS Nbre_Clients
FROM clients;

-- la somme totale des ventes dans la table "Ventes".
SELECT SUM(MontantTotal) AS Total_ventes
FROM ventes;

-- le produit le moins cher ? Quel est le produit le plus cher ?
SELECT MIN(PrixUnitaire) AS "Min_Produit" , MAX(PrixUnitaire) AS "Max_Produit"
FROM produits;

-- la moyenne des ventes uniques.
SELECT AVG(DISTINCT MontantTotal) AS Moyen_Vente
FROM ventes;

/*==================================================================================
             REGROUPEMENT des Données (GROUP BY) en SQL
==================================================================================*/

-- la somme des ventes par employé
SELECT EmployeID, SUM(MontantTotal) AS CA
FROM ventes
GROUP BY EmployeID;

-- Compter le nombre de ventes par employé.
SELECT EmployeID, COUNT(MontantTotal) AS Nbre_ventes
FROM ventes
GROUP BY EmployeID;

-- la somme des ventes par année.
SELECT YEAR(DateVente) as "Année" , SUM(MontantTotal) AS CA
FROM ventes
GROUP BY Année;

 -- ou avec EXTRACT
SELECT EXTRACT(YEAR FROM DateVente) as "Année" , SUM(MontantTotal) AS CA
FROM ventes
GROUP BY Année
ORDER BY CA DESC;
 
-- la moyenne des ventes par année et par employé ?
SELECT  EXTRACT(YEAR FROM DateVente) as "Année", EmployeID , AVG(MontantTotal) AS Moyenne_CA
FROM ventes
GROUP BY Année, EmployeID
ORDER BY EmployeID;

/*======================================================
Fonction HAVING      "HAVING c'est pour les variables non existante et WHERE est pour les var existante
======================================================*/
-- La clause HAVING est utilisée avec GROUP BY pour filtrer les groupes de résultats basés sur une condition agrégée.

-- La liste des employés dont la moyenne des ventes est supérieure à 1000 euros.
SELECT  EmployeID, AVG(MontantTotal) AS Moyenne_ventes
FROM ventes
GROUP BY EmployeID
HAVING Moyenne_CA > 1000;

-- La liste des 5 employés ayant la somme des ventes la plus élevée
SELECT  EmployeID, SUM(MontantTotal) AS Somme_ventes
FROM ventes
GROUP BY EmployeID
ORDER BY Somme_ventes DESC
LIMIT 5;



/*==================================================================================
               Maîtriser les Jointures en SQL
==================================================================================*/
-- Les jointures en SQL sont utilisées pour combiner des données de deux ou plusieurs tables en fonction d'une relation entre les colonnes de ces tables. Elles permettent de récupérer des informations provenant de plusieurs tables dans une seule requête.
-- L'opération INNER JOIN retourne uniquement les lignes qui ont une correspondance dans les deux tables basées sur la condition spécifiée.

-- Donner pour chaque vente le nom et le prénom de l'employé qui a réalisé la vente
SELECT VenteID, Nom, Prenom
FROM ventes v
INNER JOIN employes e ON v.EmployeID = e.EmployeID;

-- La Jointure précedente avec l'utilisation de USING
SELECT VenteID, Nom, Prenom
FROM ventes
INNER JOIN employes USING(employeID);

-- Donner pour chaque produit de la base de données le nom et l'adresse de son fournisseur
SELECT produitID, NomProduit, NomFournisseur, Adresse
FROM produits p
INNER JOIN fournisseurs f ON p.FournisseurID = f.FournisseurID;

-- Donner le nom et prénom des employés ayant réalisé la somme des ventes les plus élevées
SELECT EmployeID, Nom, Prenom , SUM(MontantTotal) AS somme_CA
FROM ventes
INNER JOIN employes USING(EmployeID)
GROUP BY EmployeID, Nom, Prenom
ORDER BY somme_CA DESC;

-- Donner pour chaque client le nom, l'adresse ainsi que le nombre d'achat réalisé
SELECT ClientID, Nom, Adresse , COUNT(VenteID) AS Nombre_achat
FROM clients
INNER JOIN ventes USING(ClientID)
GROUP BY ClientID, Nom, Adresse
ORDER BY Nombre_achat DESC;

/*======================================================================
Utilisation de LEFT JOIN et RIGHT JOIN pour combiner des lignes de deux tables
======================================================================*/
-- L'opération LEFT JOIN retourne toutes les lignes de la table de gauche (table1) et les lignes correspondantes de la table de droite (table2). S'il n'y a pas de correspondance, le résultat inclura des valeurs NULL pour les colonnes de la table de droite.
-- L'opération RIGHT JOIN fonctionne de manière similaire mais retourne toutes les lignes de la table de droite (table2) et les lignes correspondantes de la table de gauche (table1). S'il n'y a pas de correspondance, le résultat inclura des valeurs NULL pour les colonnes de la table de gauche.

-- Donner pour chaque employé, le nom, le prénom et le nombre de vente réalisé (il faut conserver dans la base les employés qui ont des ventes nulles)

SELECT EmployeID, Nom, Prenom , COUNT(VenteID) AS Nombre_vente
FROM employes
LEFT JOIN ventes USING(EmployeID)
GROUP BY EmployeID, Nom, Prenom
ORDER BY Nombre_vente DESC;

-- Donner pour chaque fournisseur son nom, son email et le nombre de produits fournis (laisser des fournisseurs qui n'ont aucun produit)
SELECT  NomFournisseur, Email, COUNT(ProduitID) AS Nbre_Prod_Four
FROM fournisseurs f
LEFT JOIN produits p ON f.FournisseurID = p.FournisseurID
GROUP BY  NomFournisseur, Email
ORDER BY Nbre_Prod_Four DESC;

-- Donner le nom, le prénom et la moyenne des ventes par client (conservez la liste des clients qui n'ont acheté aucun produit


/*======================================================================
Création et utilisation de vues dans SQL
======================================================================*/
-- Les vues sont des tables virtuelles basées sur le résultat d'une requête SQL.

-- Créez une vue des ventes de l'année 2021`
CREATE VIEW Vente2021 AS
SELECT *
FROM ventes
WHERE EXTRACT( YEAR FROM DateVente) = 2021;

SELECT *
FROM vente2021;

-- Quelle est la liste des clients qui ont réalisé plus de 1 achats en 2021
SELECT ClientID, Nom, Prenom, COUNT(VenteID) AS Nbre_achat
FROM clients 
INNER JOIN vente2021 c USING(ClientID)
GROUP BY ClientID
HAVING Nbre_achat > 1;

-- Quelle est la liste des employés qui ont les ventes moyennes supérieures à 500 en 2021?
SELECT EmployeID, Nom, Prenom, AVG(MontantTotal) AS CA_Total
FROM  employes
INNER JOIN vente2021 USING(EmployeID)
GROUP BY EmployeID
HAVING CA_Total > 500;

-- Créez une vue contenant les produits dont le prix est supérieur à 500 euros
CREATE VIEW ProduitSup500 AS
SELECT *
FROM Produits
WHERE PrixUnitaire >500;

