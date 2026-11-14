-- Labo S3 — TD, exercice 3 : le modèle à corriger, puis la table par statut et par jour
-- Commande : docker exec -it s3-cassandra cqlsh -f /cql/exo3.cql
-- 1) Le modèle du développeur (une partition par commande)
CREATE TABLE IF NOT EXISTS teranga.commandes (
  id_commande text PRIMARY KEY, client_id int, date_commande timestamp,
  statut text, total int);

INSERT INTO teranga.commandes (id_commande, client_id, date_commande, statut, total) VALUES ('CMD-0244', 3310, '2026-08-30 15:20:00+0000', 'livrée', 27000);
INSERT INTO teranga.commandes (id_commande, client_id, date_commande, statut, total) VALUES ('CMD-0302', 1024, '2026-09-14 11:00:00+0000', 'livrée', 8000);
INSERT INTO teranga.commandes (id_commande, client_id, date_commande, statut, total) VALUES ('CMD-0312', 1025, '2026-09-16 09:30:00+0000', 'livrée', 30500);
INSERT INTO teranga.commandes (id_commande, client_id, date_commande, statut, total) VALUES ('CMD-0355', 2052, '2026-09-25 17:10:00+0000', 'livrée', 21500);
INSERT INTO teranga.commandes (id_commande, client_id, date_commande, statut, total) VALUES ('CMD-0391', 1024, '2026-10-02 16:40:00+0000', 'livrée', 15000);
INSERT INTO teranga.commandes (id_commande, client_id, date_commande, statut, total) VALUES ('CMD-0410', 3311, '2026-10-07 13:45:00+0000', 'livrée', 26250);
INSERT INTO teranga.commandes (id_commande, client_id, date_commande, statut, total) VALUES ('CMD-0428', 4100, '2026-10-11 10:05:00+0000', 'livrée', 9500);
INSERT INTO teranga.commandes (id_commande, client_id, date_commande, statut, total) VALUES ('CMD-0436', 4101, '2026-10-13 18:20:00+0000', 'livrée', 30750);
INSERT INTO teranga.commandes (id_commande, client_id, date_commande, statut, total) VALUES ('CMD-0449', 5200, '2026-10-16 11:50:00+0000', 'livrée', 4500);
INSERT INTO teranga.commandes (id_commande, client_id, date_commande, statut, total) VALUES ('CMD-0457', 1024, '2026-10-19 10:15:00+0000', 'livrée', 43500);
INSERT INTO teranga.commandes (id_commande, client_id, date_commande, statut, total) VALUES ('CMD-0466', 2051, '2026-10-21 08:05:00+0000', 'expédiée', 12000);
INSERT INTO teranga.commandes (id_commande, client_id, date_commande, statut, total) VALUES ('CMD-0471', 3310, '2026-10-23 12:30:00+0000', 'en_attente', 5500);
INSERT INTO teranga.commandes (id_commande, client_id, date_commande, statut, total) VALUES ('CMD-0480', 1024, '2026-10-24 09:12:00+0000', 'en_attente', 21000);

-- 2) La seconde table du corrigé : commandes par statut et par jour
CREATE TABLE IF NOT EXISTS teranga.commandes_par_statut_jour (
  statut        text,
  jour          date,
  date_commande timestamp,
  id_commande   text,
  client_id     int,
  total         int,
  PRIMARY KEY ((statut, jour), date_commande, id_commande)
) WITH CLUSTERING ORDER BY (date_commande DESC, id_commande ASC);

INSERT INTO teranga.commandes_par_statut_jour (statut, jour, date_commande, id_commande, client_id, total) VALUES ('livrée', '2026-08-30', '2026-08-30 15:20:00+0000', 'CMD-0244', 3310, 27000);
INSERT INTO teranga.commandes_par_statut_jour (statut, jour, date_commande, id_commande, client_id, total) VALUES ('livrée', '2026-09-14', '2026-09-14 11:00:00+0000', 'CMD-0302', 1024, 8000);
INSERT INTO teranga.commandes_par_statut_jour (statut, jour, date_commande, id_commande, client_id, total) VALUES ('livrée', '2026-09-16', '2026-09-16 09:30:00+0000', 'CMD-0312', 1025, 30500);
INSERT INTO teranga.commandes_par_statut_jour (statut, jour, date_commande, id_commande, client_id, total) VALUES ('livrée', '2026-09-25', '2026-09-25 17:10:00+0000', 'CMD-0355', 2052, 21500);
INSERT INTO teranga.commandes_par_statut_jour (statut, jour, date_commande, id_commande, client_id, total) VALUES ('livrée', '2026-10-02', '2026-10-02 16:40:00+0000', 'CMD-0391', 1024, 15000);
INSERT INTO teranga.commandes_par_statut_jour (statut, jour, date_commande, id_commande, client_id, total) VALUES ('livrée', '2026-10-07', '2026-10-07 13:45:00+0000', 'CMD-0410', 3311, 26250);
INSERT INTO teranga.commandes_par_statut_jour (statut, jour, date_commande, id_commande, client_id, total) VALUES ('livrée', '2026-10-11', '2026-10-11 10:05:00+0000', 'CMD-0428', 4100, 9500);
INSERT INTO teranga.commandes_par_statut_jour (statut, jour, date_commande, id_commande, client_id, total) VALUES ('livrée', '2026-10-13', '2026-10-13 18:20:00+0000', 'CMD-0436', 4101, 30750);
INSERT INTO teranga.commandes_par_statut_jour (statut, jour, date_commande, id_commande, client_id, total) VALUES ('livrée', '2026-10-16', '2026-10-16 11:50:00+0000', 'CMD-0449', 5200, 4500);
INSERT INTO teranga.commandes_par_statut_jour (statut, jour, date_commande, id_commande, client_id, total) VALUES ('livrée', '2026-10-19', '2026-10-19 10:15:00+0000', 'CMD-0457', 1024, 43500);
INSERT INTO teranga.commandes_par_statut_jour (statut, jour, date_commande, id_commande, client_id, total) VALUES ('expédiée', '2026-10-21', '2026-10-21 08:05:00+0000', 'CMD-0466', 2051, 12000);
INSERT INTO teranga.commandes_par_statut_jour (statut, jour, date_commande, id_commande, client_id, total) VALUES ('en_attente', '2026-10-23', '2026-10-23 12:30:00+0000', 'CMD-0471', 3310, 5500);
INSERT INTO teranga.commandes_par_statut_jour (statut, jour, date_commande, id_commande, client_id, total) VALUES ('en_attente', '2026-10-24', '2026-10-24 09:12:00+0000', 'CMD-0480', 1024, 21000);
