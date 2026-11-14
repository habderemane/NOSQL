// Labo S1 — partie 7 : un schéma de validation, puis un document accepté et un document refusé
// Commande : docker exec -it s1-mongo mongosh /scripts/validation.js
// La base teranga_valide est séparée de teranga, dont la collection clients contient
// volontairement des documents sans téléphone (capture n° 2).
db = db.getSiblingDB("teranga_valide");
db.clients.drop();

// Code identique à celui de la séquence 1
db.createCollection("clients", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["nom", "ville", "telephone"],
    properties: {
      nom:       { bsonType: "string", minLength: 2 },
      ville:     { bsonType: "string" },
      telephone: { bsonType: "string", pattern: "^\\+221[0-9]{9}$" }  // format sénégalais
    }
  } },
  validationAction: "error"   // refuse les documents non conformes
});

print("1) Document conforme :");
printjson(db.clients.insertOne({ nom: "Awa Diop", ville: "Thiès", telephone: "+221770001024" }));

print("2) Téléphone au mauvais format :");
try {
  db.clients.insertOne({ nom: "Ibou Sarr", ville: "Dakar", telephone: "77 000 10 25" });
} catch (e) {
  print("Refusé : " + e.message);
}

print("3) Téléphone absent :");
try {
  db.clients.insertOne({ nom: "Fatou Ndiaye", ville: "Saint-Louis" });
} catch (e) {
  print("Refusé : " + e.message);
}

print("Documents dans teranga_valide.clients : " + db.clients.countDocuments());
