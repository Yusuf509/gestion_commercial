-- Active: 1665695883737@@127.0.0.1@3306
CREATE DATABASE Gesion_Commercial;
use Gesion_Commercial;
CREATE Table Client(
    NumClient int NOT NULL PRIMARY KEY,
    RaisonSocial VARCHAR(30),
    AdresseClient VARCHAR(30),
    VilleClient VARCHAR(30),
    Telephone VARCHAR(15)
);
CREATE Table Produit(
    RefProduit int not null PRIMARY KEY,
    NomProduit VARCHAR(20) NOT NULL,
    PrixUnitaire FLOAT,
    QteStockee int,
    Disponible VARCHAR(4),
    constraint ck_disp check (Disponible in ('Oui','Non'))
);
CREATE TABLE Commande(
    NumCommande int NOT NULL PRIMARY KEY,
    NumClient int,
    DateCommande DATE,
    constraint FK_NomCli Foreign Key (NumClient) REFERENCES Client (NumClient) 
);
CREATE TABLE Details_Commande(
    NumCommande int,
    RefProduit int,
    QteCommandee int,
    constraint FK_NumC Foreign Key (NumCommande) REFERENCES Commande (NumCommande),
    constraint FK_RefP Foreign Key (RefProduit) REFERENCES Produit (RefProduit)
);
INSERT into Client (NumClient,RaisonSocial,AdresseClient,VilleClient,Telephone) values ('1','FORMATEUR','OUARZAZAT','OUARZAZAT',061234343434);
INSERT into Client (NumClient,RaisonSocial,AdresseClient,VilleClient,Telephone) values ('3','FORMATEUR','OUARZAZAT','OUARZAZAT',061234343434);
INSERT into Client (NumClient,RaisonSocial,AdresseClient,VilleClient,Telephone) values ('2','Cuisine','OUARZAZAT','Rabat',061234343434);
INSERT into Client (NumClient,RaisonSocial,AdresseClient,VilleClient,Telephone) values ('4','FORMATEUR','OUARZAZAT','OUARZAZAT',061234343434);

INSERT into Produit (RefProduit,NomProduit,PrixUnitaire,QteStockee,Disponible) values ('1','PC PORTABLE',10000,2,'Oui');
INSERT into Produit (RefProduit,NomProduit,PrixUnitaire,QteStockee,Disponible) values ('2','CAFEE',210,100,'Oui');
INSERT into Produit (RefProduit,NomProduit,PrixUnitaire,QteStockee,Disponible) values ('3','CAFEE',100,0,'NON');

INSERT into Commande (NumCommande,NumClient,DateCommande) values ('3341','1','2022-07-24');
INSERT into Commande (NumCommande,NumClient,DateCommande) values ('691','1','2022-08-24');
INSERT into Commande (NumCommande,NumClient,DateCommande) values ('528','2','2022-11-24');
INSERT into Commande (NumCommande,NumClient,DateCommande) values ('58','2','2023-01-24');
INSERT into Commande (NumCommande,NumClient,DateCommande) values ('6651','1','2021-01-24');
INSERT into Details_Commande (NumCommande,RefProduit,QteCommandee) values ('3341','1','1');
INSERT into Details_Commande (NumCommande,RefProduit,QteCommandee) values ('528','1','3');
DELIMITER//
CREATE PROCEDURE Q1()
BEGIN
    select * from Client;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q2()
BEGIN
    SELECT * from Produit;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q3()
BEGIN
    SELECT NumClient,VilleClient from Client;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q4()
BEGIN
    SELECT NumClient,RaisonSocial,Telephone from Client;
END//
DELIMITER//
CREATE PROCEDURE Q5()
BEGIN
    Select * from Client where NumClient=15;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q6()
BEGIN  
    Select * from Client ORDER BY RaisonSocial DESC;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q7()
BEGIN
    SELECT * FROM Client ORDER BY VilleClient ASC;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q8()
BEGIN
    SELECT * FROM Client where RaisonSocial LIKE 'S%';
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q9()
BEGIN
    SELECT * FROM Client where RaisonSocial LIKE '%E';
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q10()
BEGIN
    SELECT * FROM Client where RaisonSocial LIKE 'A%E';
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q11()
BEGIN
    SELECT * FROM Client where RaisonSocial LIKE 'A%' OR RaisonSocial LIKE '%E';
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q12()
BEGIN
    SELECT * FROM Client where VilleClient='Ouarzazat' OR VilleClient='Rabat' OR VilleClient='Casablanca'  ;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q13()
BEGIN
    SELECT * FROM Produit where PrixUnitaire = 300;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q14()
BEGIN
    SELECT * FROM Produit where PrixUnitaire < 300;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q15()
BEGIN
    SELECT * FROM Produit where PrixUnitaire >300 AND PrixUnitaire < 5000 ;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q16()
BEGIN
    SELECT * FROM Produit where Disponible='oui';
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q17()
BEGIN
    SELECT * FROM Produit where PrixUnitaire>300 AND Disponible='non';
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q18()
BEGIN
    SELECT * FROM Commande WHERE DateCommande = '2016-01-11';
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q19()
BEGIN
    SELECT * FROM Commande WHERE DateCommande > '2016-01-11';
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q20()
BEGIN
    SELECT * FROM Commande WHERE DateCommande BETWEEN '2016-02-11' AND '2016-03-31';
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q21()
BEGIN
    SELECT * FROM Commande WHERE DateCommande = now();
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q22()
BEGIN
    SELECT * FROM Commande WHERE year(DateCommande) = year(now());
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q23()
BEGIN
    SELECT * FROM Commande WHERE month(DateCommande) = 7;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q24()
BEGIN
    SELECT RefProduit,(PrixUnitaire*QteStockee) as 'valeur de stock' from Produit;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q25()
BEGIN
    SELECT RefProduit,(PrixUnitaire*0.2) as 'TTC' from Produit;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q26()
BEGIN
    SELECT DISTINCT(VilleClient) from Client;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q27()
BEGIN
    SELECT * From Client c LEFT OUTER JOIN Commande d on c.NumClient=d.NumClient where d.NumClient is NOT NULL;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q28()
BEGIN
    SELECT * From Produit p LEFT OUTER JOIN Details_Commande d on p.RefProduit=d.RefProduit where d.RefProduit is NOT NULL;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q29()
begin
    SELECT * FROM Commande c join Client cl on c.NumClient=cl.NumClient where c.NumClient=2;
end//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q30()
BEGIN
    SELECT *  From Produit p LEFT OUTER JOIN Details_Commande d on p.RefProduit=d.RefProduit where d.NumCommande = 528;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q34()
BEGIN
    Select count(*) as 'Nombre des client' from Client;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q35()
BEGIN
    Select count(*) as 'Nombre des client au Berlin' from Client WHERE VilleClient LIKE 'Berlin';
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q36()
BEGIN
    Select count(*) as 'Produits disponible' from Produit WHERE Disponible='oui';
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q37()
BEGIN
    Select count(*) as 'Produits indisponible' from Produit WHERE Disponible='oui';
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q38()
BEGIN
    Select PrixUnitaire as 'plus grand prix' from Produit GROUP BY PrixUnitaire ORDER BY PrixUnitaire DESC LIMIT 1;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q39()
BEGIN
    Select PrixUnitaire as 'plus petit prix' from Produit GROUP BY PrixUnitaire ORDER BY PrixUnitaire ASC LIMIT 1;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q40()
BEGIN
    SELECT (SUM(PrixUnitaire)/count(*)) as 'Moyenne des prix' from Produit;
END//
DELIMITER;
DELIMITER//
CREATE PROCEDURE Q41()
BEGIN
    SELECT SUM(PrixUnitaire) as 'La somme des prix' from Produit;
END//
DELIMITER;
CALL Q1();
CALL Q2();
CALL Q3();
CALL Q4();
CALL Q5();
CALL Q6();
CALL Q7();
CALL Q8();
CALL Q9();
CALL Q10();
CALL Q11();
CALL Q12();
CALL Q13();
CALL Q14();
CALL Q15();
CALL Q16();
CALL Q17();
CALL Q18();
CALL Q19();
CALL Q20();
CALL Q21();
CALL Q22();
CALL Q23();
CALL Q24();
CALL Q25();
CALL Q26();
CALL Q27();
CALL Q28();
CALL Q29();
CALL Q30();
CALL Q34();
CALL Q35();
CALL Q36();
CALL Q37();
CALL Q38();
CALL Q39();
CALL Q40();
CALL Q41();







