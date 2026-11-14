-- Labo S3 — TD, exercice 1 : validations par carte, partition par carte et par mois (seau temporel)
-- Commande : docker exec -it s3-cassandra cqlsh -f /cql/td_brt.cql
CREATE TABLE IF NOT EXISTS teranga.validations_par_carte (
  carte_id    text,
  mois        text,          -- ex. '2026-10'
  horodatage  timestamp,
  arret_id    text,
  ligne       text,
  PRIMARY KEY ((carte_id, mois), horodatage)
) WITH CLUSTERING ORDER BY (horodatage DESC);

INSERT INTO teranga.validations_par_carte (carte_id, mois, horodatage, arret_id, ligne) VALUES ('C-88213', '2026-09', '2026-09-10 13:55:00+0000', 'ARRET-029', 'B1');
INSERT INTO teranga.validations_par_carte (carte_id, mois, horodatage, arret_id, ligne) VALUES ('C-88213', '2026-09', '2026-09-13 12:19:00+0000', 'ARRET-018', 'B1');
INSERT INTO teranga.validations_par_carte (carte_id, mois, horodatage, arret_id, ligne) VALUES ('C-88213', '2026-09', '2026-09-16 14:02:00+0000', 'ARRET-024', 'B1');
INSERT INTO teranga.validations_par_carte (carte_id, mois, horodatage, arret_id, ligne) VALUES ('C-88213', '2026-09', '2026-09-19 07:41:00+0000', 'ARRET-013', 'B1');
INSERT INTO teranga.validations_par_carte (carte_id, mois, horodatage, arret_id, ligne) VALUES ('C-88213', '2026-09', '2026-09-22 10:11:00+0000', 'ARRET-014', 'B1');
INSERT INTO teranga.validations_par_carte (carte_id, mois, horodatage, arret_id, ligne) VALUES ('C-88213', '2026-09', '2026-09-25 17:18:00+0000', 'ARRET-028', 'B1');
INSERT INTO teranga.validations_par_carte (carte_id, mois, horodatage, arret_id, ligne) VALUES ('C-88213', '2026-09', '2026-09-28 13:03:00+0000', 'ARRET-029', 'B1');
INSERT INTO teranga.validations_par_carte (carte_id, mois, horodatage, arret_id, ligne) VALUES ('C-88213', '2026-10', '2026-10-01 14:06:00+0000', 'ARRET-026', 'B1');
INSERT INTO teranga.validations_par_carte (carte_id, mois, horodatage, arret_id, ligne) VALUES ('C-88213', '2026-10', '2026-10-04 17:53:00+0000', 'ARRET-022', 'B1');
INSERT INTO teranga.validations_par_carte (carte_id, mois, horodatage, arret_id, ligne) VALUES ('C-88213', '2026-10', '2026-10-07 08:21:00+0000', 'ARRET-012', 'B1');
INSERT INTO teranga.validations_par_carte (carte_id, mois, horodatage, arret_id, ligne) VALUES ('C-88213', '2026-10', '2026-10-10 16:19:00+0000', 'ARRET-019', 'B1');
INSERT INTO teranga.validations_par_carte (carte_id, mois, horodatage, arret_id, ligne) VALUES ('C-88213', '2026-10', '2026-10-13 18:01:00+0000', 'ARRET-022', 'B1');
INSERT INTO teranga.validations_par_carte (carte_id, mois, horodatage, arret_id, ligne) VALUES ('C-88213', '2026-10', '2026-10-16 17:23:00+0000', 'ARRET-022', 'B1');
INSERT INTO teranga.validations_par_carte (carte_id, mois, horodatage, arret_id, ligne) VALUES ('C-88213', '2026-10', '2026-10-19 12:31:00+0000', 'ARRET-029', 'B1');

-- 30 derniers jours = au plus deux partitions (mois courant et mois précédent)
SELECT * FROM teranga.validations_par_carte
WHERE  carte_id = 'C-88213' AND mois IN ('2026-10', '2026-09')
AND    horodatage >= '2026-09-24';
