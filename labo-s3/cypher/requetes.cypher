// Labo S3 — requêtes de la séquence 3 (Q5) et de la séquence 1 (recommandation)
// Commande : docker exec -it s3-neo4j cypher-shell -u neo4j -p teranga2026 -f /scripts/requetes.cypher

// Q5 — produits souvent achetés avec P-778 (séquence 3, partie 6.4)
MATCH (:Produit {id: 'P-778'})<-[:A_ACHETE]-(c:Client)-[:A_ACHETE]->(autre:Produit)
WHERE autre.id <> 'P-778'
RETURN autre.nom, count(DISTINCT c) AS acheteurs_communs
ORDER BY acheteurs_communs DESC LIMIT 5;

// Produits à recommander à Awa : achetés par des clients qui ont acheté comme elle (séquence 1, partie 6.4)
MATCH (a:Client {nom: 'Awa Diop'})-[:A_ACHETE]->(:Produit)<-[:A_ACHETE]-(autre:Client),
      (autre)-[:A_ACHETE]->(reco:Produit)
WHERE NOT (a)-[:A_ACHETE]->(reco)
RETURN reco.nom AS produit, count(*) AS score
ORDER BY score DESC LIMIT 5;
