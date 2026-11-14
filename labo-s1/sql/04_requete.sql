-- Labo S1 — partie 3.4 et capture n° 1 : reconstituer une commande, puis lire le plan
-- Commande : docker exec -it s1-postgres psql -U teranga -d teranga -f /sql/04_requete.sql

-- Reconstituer la commande CMD-0457 : trois jointures
SELECT c.nom, c.ville, cmd.id_commande, cmd.date_cmd, cmd.statut,
       p.libelle, l.quantite, l.prix_paye
FROM   commande cmd
JOIN   client c          ON c.id_client   = cmd.id_client
JOIN   ligne_commande l  ON l.id_commande = cmd.id_commande
JOIN   produit p         ON p.id_produit  = l.id_produit
WHERE  cmd.id_commande = 'CMD-0457';

-- Capture n° 1 : le plan d'exécution de la même requête
EXPLAIN (ANALYZE, BUFFERS)
SELECT c.nom, c.ville, cmd.id_commande, cmd.date_cmd, cmd.statut,
       p.libelle, l.quantite, l.prix_paye
FROM   commande cmd
JOIN   client c          ON c.id_client   = cmd.id_client
JOIN   ligne_commande l  ON l.id_commande = cmd.id_commande
JOIN   produit p         ON p.id_produit  = l.id_produit
WHERE  cmd.id_commande = 'CMD-0457';
