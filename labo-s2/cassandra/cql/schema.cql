-- Schéma et données de démonstration — Séquence 2
-- Commande : docker exec -it cassandra1 cqlsh -f /cql/schema.cql

-- 1) Keyspace répliqué 3 fois (N = 3) : tests de cohérence et de quorum
CREATE KEYSPACE IF NOT EXISTS teranga
  WITH replication = {'class': 'NetworkTopologyStrategy', 'dc_dakar': 3};

CREATE TABLE IF NOT EXISTS teranga.commandes_par_client (
  client_id     int,
  date_commande timestamp,
  id_commande   text,
  statut        text,
  total         int,
  PRIMARY KEY ((client_id), date_commande, id_commande)
) WITH CLUSTERING ORDER BY (date_commande DESC, id_commande ASC);

INSERT INTO teranga.commandes_par_client (client_id, date_commande, id_commande, statut, total)
VALUES (1024, '2026-10-19 10:15:00+0000', 'CMD-0457', 'livrée', 43500);
INSERT INTO teranga.commandes_par_client (client_id, date_commande, id_commande, statut, total)
VALUES (1024, '2026-10-02 16:40:00+0000', 'CMD-0391', 'livrée', 15000);
INSERT INTO teranga.commandes_par_client (client_id, date_commande, id_commande, statut, total)
VALUES (2051, '2026-10-21 08:05:00+0000', 'CMD-0466', 'expédiée', 12000);
INSERT INTO teranga.commandes_par_client (client_id, date_commande, id_commande, statut, total)
VALUES (3310, '2026-10-23 12:30:00+0000', 'CMD-0471', 'en_attente', 5500);

-- 2) Keyspace NON répliqué (N = 1) : chaque client vit sur un seul nœud,
--    ce qui rend le partitionnement visible
CREATE KEYSPACE IF NOT EXISTS demo_rf1
  WITH replication = {'class': 'NetworkTopologyStrategy', 'dc_dakar': 1};

CREATE TABLE IF NOT EXISTS demo_rf1.clients (
  client_id int PRIMARY KEY,
  nom       text,
  ville     text
);

INSERT INTO demo_rf1.clients (client_id, nom, ville) VALUES (1024, 'Awa Diop', 'Thiès');
INSERT INTO demo_rf1.clients (client_id, nom, ville) VALUES (1025, 'Ibou Sarr', 'Dakar');
INSERT INTO demo_rf1.clients (client_id, nom, ville) VALUES (2051, 'Fatou Ndiaye', 'Saint-Louis');
INSERT INTO demo_rf1.clients (client_id, nom, ville) VALUES (2052, 'Moussa Fall', 'Kaolack');
INSERT INTO demo_rf1.clients (client_id, nom, ville) VALUES (3310, 'Aminata Ba', 'Ziguinchor');
INSERT INTO demo_rf1.clients (client_id, nom, ville) VALUES (3311, 'Cheikh Diallo', 'Kolda');
INSERT INTO demo_rf1.clients (client_id, nom, ville) VALUES (4100, 'Mariama Sow', 'Touba');
INSERT INTO demo_rf1.clients (client_id, nom, ville) VALUES (4101, 'Ousmane Gueye', 'Mbour');
INSERT INTO demo_rf1.clients (client_id, nom, ville) VALUES (5200, 'Khady Faye', 'Louga');
