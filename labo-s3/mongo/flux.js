// Labo S3 — partie 5 : propager le nom d'un produit avec un flux de modifications
// Terminal T1 : docker exec -it s3-mongo mongosh /scripts/flux.js   (Ctrl+C pour arrêter)
db = db.getSiblingDB("teranga");
print("En attente d'un changement de nom de produit...");
// Propager le nouveau nom d'un produit dans les avis qui en gardent une copie
const flux = db.produits.watch(
  [ { $match: { operationType: "update",
                "updateDescription.updatedFields.nom": { $exists: true } } } ],
  { fullDocument: "updateLookup" }
);
while (flux.hasNext()) {
  const ev = flux.next();
  const r = db.avis.updateMany({ produit_id: ev.documentKey._id },
                               { $set: { produit_nom: ev.fullDocument.nom } });
  print(ev.documentKey._id + " : " + r.modifiedCount + " avis mis à jour");
}
