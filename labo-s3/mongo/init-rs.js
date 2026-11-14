// Labo S3 — replica set d'un seul nœud (nécessaire aux flux de modifications)
// Commande : docker exec -it s3-mongo mongosh /scripts/init-rs.js
printjson(rs.initiate({ _id: "rs-s3", members: [ { _id: 0, host: "s3-mongo:27017" } ] }));
print("Patientez une dizaine de secondes : le nœud devient PRIMARY.");
