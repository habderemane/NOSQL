// Labo S3 — partie 6.2, écriture E2 : publier l'avis d'Awa (code de la séquence)
// Commande : docker exec -it s3-mongo mongosh /scripts/e2_avis.js
db = db.getSiblingDB("teranga");
// E2 — publier un avis : deux écritures distinctes, chacune atomique
// (les placer dans une transaction si elles doivent réussir ensemble)
db.avis.insertOne({ produit_id: "P-778", produit_nom: "Riz parfumé 25 kg", auteur: "Awa D.",
                    note: 5, date: ISODate("2026-10-23"), texte: "Très bon riz, bien parfumé." })
db.produits.updateOne({ _id: "P-778" }, {
  $inc:  { nb_avis: 1 },
  $push: { avis_recents: { $each: [ { auteur: "Awa D.", note: 5, date: ISODate("2026-10-23"),
                                      extrait: "Très bon riz…" } ],
                           $position: 0, $slice: 10 } }      // garde les 10 plus récents
})
const riz = db.produits.findOne({ _id: "P-778" });
print("Avis : " + db.avis.countDocuments() + " ; P-778 : nb_avis = " + riz.nb_avis + ", premier avis récent : " + riz.avis_recents[0].auteur);
