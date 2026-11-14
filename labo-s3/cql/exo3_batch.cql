-- Labo S3 — TD, exercice 3, question 3 : CMD-0480 passe de « en_attente » à « expédiée »
-- Commande : docker exec -it s3-cassandra cqlsh -f /cql/exo3_batch.cql   (après schema.cql et exo3.cql)
BEGIN BATCH
  DELETE FROM teranga.commandes_par_statut_jour
   WHERE statut = 'en_attente' AND jour = '2026-10-24'
     AND date_commande = '2026-10-24 09:12:00+0000' AND id_commande = 'CMD-0480';
  INSERT INTO teranga.commandes_par_statut_jour (statut, jour, date_commande, id_commande, client_id, total)
  VALUES ('expédiée', '2026-10-24', '2026-10-24 09:12:00+0000', 'CMD-0480', 1024, 21000);
  UPDATE teranga.commandes_par_client SET statut = 'expédiée'
   WHERE client_id = 1024 AND date_commande = '2026-10-24 09:12:00+0000' AND id_commande = 'CMD-0480';
APPLY BATCH;

SELECT * FROM teranga.commandes_par_statut_jour WHERE statut = 'expédiée' AND jour = '2026-10-24';
SELECT id_commande, statut FROM teranga.commandes_par_client WHERE client_id = 1024;
