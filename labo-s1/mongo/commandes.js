// Labo S1 — collection commandes : les 13 commandes de référence, une commande = un document
// (forme de la figure 2 de la séquence 1). Commande : docker exec -it s1-mongo mongosh /scripts/commandes.js
db = db.getSiblingDB("teranga");

const produits = {
  "P-778": ["Riz parfumé 25 kg", 18500], "P-112": ["Huile 5 L", 6500], "P-205": ["Sucre 1 kg", 1000],
  "P-340": ["Café Touba 500 g", 3000], "P-520": ["Thé vert 200 g", 2500], "P-610": ["Lait en poudre 400 g", 2750]
};
const clients = {
  1024: ["Awa Diop", "Thiès"], 1025: ["Ibou Sarr", "Dakar"], 2051: ["Fatou Ndiaye", "Saint-Louis"],
  2052: ["Moussa Fall", "Kaolack"], 3310: ["Aminata Ba", "Ziguinchor"], 3311: ["Cheikh Diallo", "Kolda"],
  4100: ["Mariama Sow", "Touba"], 4101: ["Ousmane Gueye", "Mbour"], 5200: ["Khady Faye", "Louga"]
};
const reference = [
  ["CMD-0244", 3310, "2026-08-30T15:20:00Z", "livrée", [["P-778", 1], ["P-112", 1], ["P-205", 2]]],
  ["CMD-0302", 1024, "2026-09-14T11:00:00Z", "livrée", [["P-340", 2], ["P-205", 2]]],
  ["CMD-0312", 1025, "2026-09-16T09:30:00Z", "livrée", [["P-778", 1], ["P-112", 1], ["P-610", 2]]],
  ["CMD-0355", 2052, "2026-09-25T17:10:00Z", "livrée", [["P-778", 1], ["P-205", 3]]],
  ["CMD-0391", 1024, "2026-10-02T16:40:00Z", "livrée", [["P-112", 2], ["P-205", 2]]],
  ["CMD-0410", 3311, "2026-10-07T13:45:00Z", "livrée", [["P-778", 1], ["P-520", 2], ["P-610", 1]]],
  ["CMD-0428", 4100, "2026-10-11T10:05:00Z", "livrée", [["P-112", 1], ["P-340", 1]]],
  ["CMD-0436", 4101, "2026-10-13T18:20:00Z", "livrée", [["P-778", 1], ["P-112", 1], ["P-340", 1], ["P-610", 1]]],
  ["CMD-0449", 5200, "2026-10-16T11:50:00Z", "livrée", [["P-205", 2], ["P-520", 1]]],
  ["CMD-0457", 1024, "2026-10-19T10:15:00Z", "livrée", [["P-778", 2], ["P-112", 1]]],
  ["CMD-0466", 2051, "2026-10-21T08:05:00Z", "expédiée", [["P-340", 4]]],
  ["CMD-0471", 3310, "2026-10-23T12:30:00Z", "en_attente", [["P-520", 1], ["P-340", 1]]],
  ["CMD-0480", 1024, "2026-10-24T09:12:00Z", "en_attente", [["P-778", 1], ["P-520", 1]]]
];

const documents = reference.map(([id, client, date, statut, lignes]) => {
  const l = lignes.map(([p, q]) => ({ produit: produits[p][0], quantite: q, prix_paye: produits[p][1] }));
  return {
    _id: id,
    date_cmd: ISODate(date),
    statut: statut,
    client: { id: client, nom: clients[client][0], ville: clients[client][1] },
    lignes: l,
    total: l.reduce((s, x) => s + x.quantite * x.prix_paye, 0)
  };
});

db.commandes.drop();
db.commandes.insertMany(documents);
print("Commandes : " + db.commandes.countDocuments());
