-- Labo S1 — données : 60 produits, 20 000 clients, 100 000 commandes
-- Les clients, produits et commandes de référence sont ceux de toutes les séquences.
-- Commande : docker exec -it s1-postgres psql -U teranga -d teranga -f /sql/02_donnees.sql
TRUNCATE ligne_commande, commande, produit, client, operation, compte;

INSERT INTO produit (id_produit, libelle, categorie, prix_unitaire) VALUES
  ('P-778', 'Riz parfumé 25 kg', 'Épicerie', 18500),
  ('P-112', 'Huile 5 L', 'Épicerie', 6500),
  ('P-205', 'Sucre 1 kg', 'Épicerie', 1000),
  ('P-340', 'Café Touba 500 g', 'Boissons', 3000),
  ('P-520', 'Thé vert 200 g', 'Boissons', 2500),
  ('P-610', 'Lait en poudre 400 g', 'Épicerie', 2750),
  ('P-1001', 'Savon (petit format)', 'Entretien', 500),
  ('P-1002', 'Lait concentré (petit format)', 'Épicerie', 850),
  ('P-1003', 'Farine (petit format)', 'Épicerie', 1200),
  ('P-1004', 'Pâtes (petit format)', 'Épicerie', 1550),
  ('P-1005', 'Tomate concentrée (petit format)', 'Épicerie', 1900),
  ('P-1006', 'Bouillon (petit format)', 'Épicerie', 2250),
  ('P-1007', 'Mil (petit format)', 'Épicerie', 2600),
  ('P-1008', 'Maïs (petit format)', 'Épicerie', 2950),
  ('P-1009', 'Arachide (petit format)', 'Épicerie', 3300),
  ('P-1010', 'Oignons (petit format)', 'Épicerie', 3650),
  ('P-1011', 'Pommes de terre (petit format)', 'Épicerie', 4000),
  ('P-1012', 'Lessive (petit format)', 'Entretien', 4350),
  ('P-1013', 'Eau minérale (petit format)', 'Boissons', 4700),
  ('P-1014', 'Jus de bissap (petit format)', 'Boissons', 5050),
  ('P-1015', 'Jus de bouye (petit format)', 'Boissons', 5400),
  ('P-1016', 'Biscuits (petit format)', 'Épicerie', 5750),
  ('P-1017', 'Sardines (petit format)', 'Épicerie', 6100),
  ('P-1018', 'Thon (petit format)', 'Épicerie', 6450),
  ('P-1019', 'Vinaigre (petit format)', 'Épicerie', 6800),
  ('P-1020', 'Moutarde (petit format)', 'Épicerie', 7150),
  ('P-1021', 'Mayonnaise (petit format)', 'Épicerie', 7500),
  ('P-1022', 'Poivre (petit format)', 'Épicerie', 7850),
  ('P-1023', 'Sel iodé (petit format)', 'Épicerie', 8200),
  ('P-1024', 'Couscous (petit format)', 'Épicerie', 8550),
  ('P-1025', 'Fonio (petit format)', 'Épicerie', 8900),
  ('P-1026', 'Niébé (petit format)', 'Épicerie', 9250),
  ('P-1027', 'Dattes (petit format)', 'Épicerie', 600),
  ('P-1028', 'Savon (grand format)', 'Entretien', 950),
  ('P-1029', 'Lait concentré (grand format)', 'Épicerie', 1300),
  ('P-1030', 'Farine (grand format)', 'Épicerie', 1650),
  ('P-1031', 'Pâtes (grand format)', 'Épicerie', 2000),
  ('P-1032', 'Tomate concentrée (grand format)', 'Épicerie', 2350),
  ('P-1033', 'Bouillon (grand format)', 'Épicerie', 2700),
  ('P-1034', 'Mil (grand format)', 'Épicerie', 3050),
  ('P-1035', 'Maïs (grand format)', 'Épicerie', 3400),
  ('P-1036', 'Arachide (grand format)', 'Épicerie', 3750),
  ('P-1037', 'Oignons (grand format)', 'Épicerie', 4100),
  ('P-1038', 'Pommes de terre (grand format)', 'Épicerie', 4450),
  ('P-1039', 'Lessive (grand format)', 'Entretien', 4800),
  ('P-1040', 'Eau minérale (grand format)', 'Boissons', 5150),
  ('P-1041', 'Jus de bissap (grand format)', 'Boissons', 5500),
  ('P-1042', 'Jus de bouye (grand format)', 'Boissons', 5850),
  ('P-1043', 'Biscuits (grand format)', 'Épicerie', 6200),
  ('P-1044', 'Sardines (grand format)', 'Épicerie', 6550),
  ('P-1045', 'Thon (grand format)', 'Épicerie', 6900),
  ('P-1046', 'Vinaigre (grand format)', 'Épicerie', 7250),
  ('P-1047', 'Moutarde (grand format)', 'Épicerie', 7600),
  ('P-1048', 'Mayonnaise (grand format)', 'Épicerie', 7950),
  ('P-1049', 'Poivre (grand format)', 'Épicerie', 8300),
  ('P-1050', 'Sel iodé (grand format)', 'Épicerie', 8650),
  ('P-1051', 'Couscous (grand format)', 'Épicerie', 9000),
  ('P-1052', 'Fonio (grand format)', 'Épicerie', 9350),
  ('P-1053', 'Niébé (grand format)', 'Épicerie', 700),
  ('P-1054', 'Dattes (grand format)', 'Épicerie', 1050);

-- Clients de référence
INSERT INTO client (id_client, nom, ville) VALUES
  (1024, 'Awa Diop', 'Thiès'),
  (1025, 'Ibou Sarr', 'Dakar'),
  (2051, 'Fatou Ndiaye', 'Saint-Louis'),
  (2052, 'Moussa Fall', 'Kaolack'),
  (3310, 'Aminata Ba', 'Ziguinchor'),
  (3311, 'Cheikh Diallo', 'Kolda'),
  (4100, 'Mariama Sow', 'Touba'),
  (4101, 'Ousmane Gueye', 'Mbour'),
  (5200, 'Khady Faye', 'Louga');

-- Clients générés (identifiants 1 à 20 000, sauf ceux de référence)
INSERT INTO client (id_client, nom, ville)
SELECT i,
       (ARRAY['Aïssatou','Mamadou','Ndeye','Ibrahima','Coumba','Abdoulaye','Fatoumata','Modou','Astou','Babacar','Rokhaya','Alioune'])[1 + i % 12]
       || ' ' ||
       (ARRAY['Ndiaye','Diop','Fall','Sow','Ba','Gueye','Faye','Sarr','Diallo','Cissé','Mbaye','Thiam','Kane','Seck'])[1 + (i * 7) % 14],
       (ARRAY['Dakar','Thiès','Saint-Louis','Kaolack','Ziguinchor','Touba','Mbour','Rufisque','Louga','Kolda','Tambacounda','Diourbel'])[1 + (i * 3) % 12]
FROM generate_series(1, 20000) AS i
WHERE i NOT IN (1024, 1025, 2051, 2052, 3310, 3311, 4100, 4101, 5200);

-- Commandes de référence et leurs lignes
INSERT INTO commande (id_commande, id_client, date_cmd, statut) VALUES
  ('CMD-0244', 3310, DATE '2026-08-30', 'livrée'),
  ('CMD-0302', 1024, DATE '2026-09-14', 'livrée'),
  ('CMD-0312', 1025, DATE '2026-09-16', 'livrée'),
  ('CMD-0355', 2052, DATE '2026-09-25', 'livrée'),
  ('CMD-0391', 1024, DATE '2026-10-02', 'livrée'),
  ('CMD-0410', 3311, DATE '2026-10-07', 'livrée'),
  ('CMD-0428', 4100, DATE '2026-10-11', 'livrée'),
  ('CMD-0436', 4101, DATE '2026-10-13', 'livrée'),
  ('CMD-0449', 5200, DATE '2026-10-16', 'livrée'),
  ('CMD-0457', 1024, DATE '2026-10-19', 'livrée'),
  ('CMD-0466', 2051, DATE '2026-10-21', 'expédiée'),
  ('CMD-0471', 3310, DATE '2026-10-23', 'en_attente'),
  ('CMD-0480', 1024, DATE '2026-10-24', 'en_attente');

INSERT INTO ligne_commande (id_commande, id_produit, quantite, prix_paye) VALUES
  ('CMD-0244', 'P-778', 1, 18500),
  ('CMD-0244', 'P-112', 1, 6500),
  ('CMD-0244', 'P-205', 2, 1000),
  ('CMD-0302', 'P-340', 2, 3000),
  ('CMD-0302', 'P-205', 2, 1000),
  ('CMD-0312', 'P-778', 1, 18500),
  ('CMD-0312', 'P-112', 1, 6500),
  ('CMD-0312', 'P-610', 2, 2750),
  ('CMD-0355', 'P-778', 1, 18500),
  ('CMD-0355', 'P-205', 3, 1000),
  ('CMD-0391', 'P-112', 2, 6500),
  ('CMD-0391', 'P-205', 2, 1000),
  ('CMD-0410', 'P-778', 1, 18500),
  ('CMD-0410', 'P-520', 2, 2500),
  ('CMD-0410', 'P-610', 1, 2750),
  ('CMD-0428', 'P-112', 1, 6500),
  ('CMD-0428', 'P-340', 1, 3000),
  ('CMD-0436', 'P-778', 1, 18500),
  ('CMD-0436', 'P-112', 1, 6500),
  ('CMD-0436', 'P-340', 1, 3000),
  ('CMD-0436', 'P-610', 1, 2750),
  ('CMD-0449', 'P-205', 2, 1000),
  ('CMD-0449', 'P-520', 1, 2500),
  ('CMD-0457', 'P-778', 2, 18500),
  ('CMD-0457', 'P-112', 1, 6500),
  ('CMD-0466', 'P-340', 4, 3000),
  ('CMD-0471', 'P-520', 1, 2500),
  ('CMD-0471', 'P-340', 1, 3000),
  ('CMD-0480', 'P-778', 1, 18500),
  ('CMD-0480', 'P-520', 1, 2500);

-- Commandes générées : 100 000 au total avec celles de référence
-- (identifiant CMD-0001 à CMD-9999 puis CMD-10000 à CMD-100000 ; jamais sur un client de référence)
CREATE TEMP TABLE gen AS
SELECT n,
       'CMD-' || CASE WHEN n < 10000 THEN lpad(n::text, 4, '0') ELSE n::text END AS id_commande,
       CASE WHEN c IN (1024, 1025, 2051, 2052, 3310, 3311, 4100, 4101, 5200) THEN c + 9 ELSE c END AS id_client,
       DATE '2025-11-01' + (n * 37) % 365 AS date_cmd,
       CASE n % 10 WHEN 0 THEN 'en_attente' WHEN 1 THEN 'expédiée' ELSE 'livrée' END AS statut
FROM (SELECT n, 1 + (n * 7919) % 20000 AS c FROM generate_series(1, 100000) AS n) s
WHERE n NOT IN (244, 302, 312, 355, 391, 410, 428, 436, 449, 457, 466, 471, 480);

INSERT INTO commande (id_commande, id_client, date_cmd, statut)
SELECT id_commande, id_client, date_cmd, statut FROM gen;

-- 1 à 3 lignes par commande, produits distincts, prix payé = prix du catalogue
INSERT INTO ligne_commande (id_commande, id_produit, quantite, prix_paye)
SELECT g.id_commande, p.id_produit, 1 + (g.n + k) % 4, p.prix_unitaire
FROM gen g
CROSS JOIN LATERAL generate_series(0, g.n % 3) AS k
JOIN (SELECT id_produit, prix_unitaire, row_number() OVER (ORDER BY id_produit) - 1 AS rang FROM produit) p
  ON p.rang = (g.n * 13 + k * 17) % 60;

-- Comptes de mobile money
INSERT INTO compte (id_compte, titulaire, solde) VALUES
  ('AWA-221770001', 'Awa Diop', 50000),
  ('IBOU-221780002', 'Ibou Sarr', 20000);

ANALYZE client, produit, commande, ligne_commande, compte;

SELECT 'clients' AS table_, count(*) FROM client
UNION ALL SELECT 'produits', count(*) FROM produit
UNION ALL SELECT 'commandes', count(*) FROM commande
UNION ALL SELECT 'lignes', count(*) FROM ligne_commande;
