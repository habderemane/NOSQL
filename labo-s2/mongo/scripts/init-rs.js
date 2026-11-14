// Initialise le replica set rs-teranga (à exécuter une seule fois, depuis mongo1)
// Commande : docker exec -it mongo1 mongosh /scripts/init-rs.js
const resultat = rs.initiate({
  _id: "rs-teranga",
  members: [
    { _id: 0, host: "mongo1:27017" },
    { _id: 1, host: "mongo2:27017" },
    { _id: 2, host: "mongo3:27017" }
  ]
});
printjson(resultat);
print("Patientez une dizaine de secondes : les nœuds élisent un primaire.");
