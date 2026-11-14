// Jeu de données de démonstration (mobile money fictif)
// Commande : docker exec -it mongo1 mongosh "mongodb://mongo1:27017,mongo2:27017,mongo3:27017/?replicaSet=rs-teranga" /scripts/donnees.js
db = db.getSiblingDB("teranga");
db.operations.drop();
db.operations.insertMany([
  { type: "DEPOT",     montant: 15000, compte: "AWA",  agence: "Thiès",  date: new Date("2026-10-24T09:00:00Z") },
  { type: "TRANSFERT", montant: 10000, de: "AWA", vers: "IBOU",          date: new Date("2026-10-24T09:05:00Z") },
  { type: "RETRAIT",   montant: 5000,  compte: "IBOU", agence: "Kolda",  date: new Date("2026-10-24T09:20:00Z") }
], { writeConcern: { w: "majority" } });
print("Opérations enregistrées : " + db.operations.countDocuments());
