// Labo S3 — collection avis : 199 999 avis, puis calcul de nb_avis, note_moyenne et avis_recents
// Commande : docker exec -it s3-mongo mongosh /scripts/avis.js   (1 à 2 minutes)
// Volontairement, aucun index n'est créé : la capture n° 2 compare le plan avant et après l'index.
db = db.getSiblingDB("teranga");

function mulberry32(a) {
  return function () {
    a |= 0; a = (a + 0x6D2B79F5) | 0;
    let t = Math.imul(a ^ (a >>> 15), 1 | a);
    t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}
const alea = mulberry32(2026);
const produits = db.produits.find({}, { nom: 1 }).toArray();
const autres = produits.filter(p => p._id !== "P-778");
const nomRiz = produits.find(p => p._id === "P-778").nom;

const prenoms = ["Aïssatou", "Mamadou", "Ndeye", "Ibrahima", "Coumba", "Abdoulaye", "Fatoumata", "Modou", "Astou", "Babacar", "Rokhaya", "Alioune"];
const initiales = "BCDFGKMNST";
const textes = {
  5: "Excellent produit, je recommande vivement.",
  4: "Bon produit, conforme à la description.",
  3: "Correct, sans plus. Livraison un peu lente.",
  2: "Qualité décevante pour ce prix.",
  1: "Produit arrivé abîmé, très déçu."
};
// note selon une distribution donnée (P-778 : moyenne voisine de 4,3)
function tirerNote(poids) {
  let x = alea(), cumul = 0;
  for (const [note, p] of poids) { cumul += p; if (x < cumul) return note; }
  return poids[poids.length - 1][0];
}
const poidsRiz = [[5, 0.50], [4, 0.35], [3, 0.10], [2, 0.03], [1, 0.02]];
const poidsAutres = [[5, 0.30], [4, 0.35], [3, 0.20], [2, 0.10], [1, 0.05]];
const debut = Date.UTC(2024, 0, 1), fin = Date.UTC(2026, 9, 22, 23, 59);   // tous antérieurs au 23/10/2026

function avis(produit, nom, poids) {
  const note = tirerNote(poids);
  return {
    produit_id: produit,
    produit_nom: nom,                                   // copie dénormalisée (partie 5)
    auteur: prenoms[Math.floor(alea() * prenoms.length)] + " " + initiales[Math.floor(alea() * initiales.length)] + ".",
    note: note,
    date: new Date(debut + Math.floor(alea() * (fin - debut))),
    texte: textes[note]
  };
}

db.avis.drop();
const TOTAL = 199999, RIZ = 3411, LOT = 10000;
let lot = [], inseres = 0;
for (let i = 0; i < TOTAL; i++) {
  if (i < RIZ) lot.push(avis("P-778", nomRiz, poidsRiz));
  else { const p = autres[Math.floor(alea() * autres.length)]; lot.push(avis(p._id, p.nom, poidsAutres)); }
  if (lot.length === LOT || i === TOTAL - 1) { db.avis.insertMany(lot); inseres += lot.length; lot = []; print("  " + inseres + " avis"); }
}

// Patrons calculé et sous-ensemble : un seul passage d'agrégation pour tout le catalogue
const stats = db.avis.aggregate([
  { $group: {
      _id: "$produit_id",
      nb: { $sum: 1 },
      moyenne: { $avg: "$note" },
      recents: { $topN: { n: 10, sortBy: { date: -1 },
                          output: { auteur: "$auteur", note: "$note", date: "$date", extrait: { $substrCP: ["$texte", 0, 40] } } } }
  } }
]).toArray();
db.produits.bulkWrite(stats.map(s => ({ updateOne: {
  filter: { _id: s._id },
  update: { $set: { nb_avis: s.nb, note_moyenne: Math.round(s.moyenne * 10) / 10, avis_recents: s.recents } }
} })));

print("Avis : " + db.avis.countDocuments());
const riz = db.produits.findOne({ _id: "P-778" });
print("P-778 : nb_avis = " + riz.nb_avis + ", note_moyenne = " + riz.note_moyenne + ", avis_recents = " + riz.avis_recents.length);
