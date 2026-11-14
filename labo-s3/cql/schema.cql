-- Labo S3 — partie 6.3 : une table par requête (Q3, historique des commandes d'un client)
-- Commande : docker exec -it s3-cassandra cqlsh -f /cql/schema.cql
-- Un seul nœud : une seule copie (dc_dakar: 1)
CREATE KEYSPACE IF NOT EXISTS teranga
  WITH replication = {'class': 'NetworkTopologyStrategy', 'dc_dakar': 1};

CREATE TABLE IF NOT EXISTS teranga.commandes_par_client (
  client_id     int,
  date_commande timestamp,
  id_commande   text,
  statut        text,
  total         int,
  PRIMARY KEY ((client_id), date_commande, id_commande)
) WITH CLUSTERING ORDER BY (date_commande DESC, id_commande ASC);

INSERT INTO teranga.commandes_par_client (client_id, date_commande, id_commande, statut, total) VALUES (3310, '2026-08-30 15:20:00+0000', 'CMD-0244', 'livrée', 27000);
INSERT INTO teranga.commandes_par_client (client_id, date_commande, id_commande, statut, total) VALUES (1024, '2026-09-14 11:00:00+0000', 'CMD-0302', 'livrée', 8000);
INSERT INTO teranga.commandes_par_client (client_id, date_commande, id_commande, statut, total) VALUES (1025, '2026-09-16 09:30:00+0000', 'CMD-0312', 'livrée', 30500);
INSERT INTO teranga.commandes_par_client (client_id, date_commande, id_commande, statut, total) VALUES (2052, '2026-09-25 17:10:00+0000', 'CMD-0355', 'livrée', 21500);
INSERT INTO teranga.commandes_par_client (client_id, date_commande, id_commande, statut, total) VALUES (1024, '2026-10-02 16:40:00+0000', 'CMD-0391', 'livrée', 15000);
INSERT INTO teranga.commandes_par_client (client_id, date_commande, id_commande, statut, total) VALUES (3311, '2026-10-07 13:45:00+0000', 'CMD-0410', 'livrée', 26250);
INSERT INTO teranga.commandes_par_client (client_id, date_commande, id_commande, statut, total) VALUES (4100, '2026-10-11 10:05:00+0000', 'CMD-0428', 'livrée', 9500);
INSERT INTO teranga.commandes_par_client (client_id, date_commande, id_commande, statut, total) VALUES (4101, '2026-10-13 18:20:00+0000', 'CMD-0436', 'livrée', 30750);
INSERT INTO teranga.commandes_par_client (client_id, date_commande, id_commande, statut, total) VALUES (5200, '2026-10-16 11:50:00+0000', 'CMD-0449', 'livrée', 4500);
INSERT INTO teranga.commandes_par_client (client_id, date_commande, id_commande, statut, total) VALUES (1024, '2026-10-19 10:15:00+0000', 'CMD-0457', 'livrée', 43500);
INSERT INTO teranga.commandes_par_client (client_id, date_commande, id_commande, statut, total) VALUES (2051, '2026-10-21 08:05:00+0000', 'CMD-0466', 'expédiée', 12000);
INSERT INTO teranga.commandes_par_client (client_id, date_commande, id_commande, statut, total) VALUES (3310, '2026-10-23 12:30:00+0000', 'CMD-0471', 'en_attente', 5500);
INSERT INTO teranga.commandes_par_client (client_id, date_commande, id_commande, statut, total) VALUES (1024, '2026-10-24 09:12:00+0000', 'CMD-0480', 'en_attente', 21000);
