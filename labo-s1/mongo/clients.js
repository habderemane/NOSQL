// Labo S1 — collection clients : 500 documents avec un tableau commandes (capture n° 2)
// Commande : docker exec -it s1-mongo mongosh /scripts/clients.js
db = db.getSiblingDB("teranga");

// Générateur pseudo-aléatoire déterministe : tout le monde obtient les mêmes données
function mulberry32(a) {
  return function () {
    a |= 0; a = (a + 0x6D2B79F5) | 0;
    let t = Math.imul(a ^ (a >>> 15), 1 | a);
    t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}
const alea = mulberry32(2026);
const choisir = (liste) => liste[Math.floor(alea() * liste.length)];

// Clients de référence (mêmes noms, villes et commandes dans toutes les séquences)
const reference = [
  { _id: 1024, nom: "Awa Diop", ville: "Thiès", telephone: "+221770001024", commandes: [
      { id: "CMD-0302", date: ISODate("2026-09-14T11:00:00Z"), total: 8000 },
      { id: "CMD-0391", date: ISODate("2026-10-02T16:40:00Z"), total: 15000 },
      { id: "CMD-0457", date: ISODate("2026-10-19T10:15:00Z"), total: 43500 },
      { id: "CMD-0480", date: ISODate("2026-10-24T09:12:00Z"), total: 21000 } ] },
  { _id: 1025, nom: "Ibou Sarr", ville: "Dakar", telephone: "+221780001025", commandes: [
      { id: "CMD-0312", date: ISODate("2026-09-16T09:30:00Z"), total: 30500 } ] },
  { _id: 2051, nom: "Fatou Ndiaye", ville: "Saint-Louis", telephone: "+221760002051", commandes: [
      { id: "CMD-0466", date: ISODate("2026-10-21T08:05:00Z"), total: 12000 } ] },
  { _id: 2052, nom: "Moussa Fall", ville: "Kaolack", telephone: "+221770002052", commandes: [
      { id: "CMD-0355", date: ISODate("2026-09-25T17:10:00Z"), total: 21500 } ] },
  { _id: 3310, nom: "Aminata Ba", ville: "Ziguinchor", telephone: "+221780003310", commandes: [
      { id: "CMD-0244", date: ISODate("2026-08-30T15:20:00Z"), total: 27000 },
      { id: "CMD-0471", date: ISODate("2026-10-23T12:30:00Z"), total: 5500 } ] },
  { _id: 3311, nom: "Cheikh Diallo", ville: "Kolda", telephone: "+221760003311", commandes: [
      { id: "CMD-0410", date: ISODate("2026-10-07T13:45:00Z"), total: 26250 } ] },
  { _id: 4100, nom: "Mariama Sow", ville: "Touba", telephone: "+221770004100", commandes: [
      { id: "CMD-0428", date: ISODate("2026-10-11T10:05:00Z"), total: 9500 } ] },
  { _id: 4101, nom: "Ousmane Gueye", ville: "Mbour", telephone: "+221780004101", commandes: [
      { id: "CMD-0436", date: ISODate("2026-10-13T18:20:00Z"), total: 30750 } ] },
  { _id: 5200, nom: "Khady Faye", ville: "Louga", telephone: "+221760005200", commandes: [
      { id: "CMD-0449", date: ISODate("2026-10-16T11:50:00Z"), total: 4500 } ] }
];

// 491 clients générés ; 15 d'entre eux n'ont pas de téléphone (3 % des 500 documents)
const prenoms = ["Aïssatou", "Mamadou", "Ndeye", "Ibrahima", "Coumba", "Abdoulaye", "Fatoumata", "Modou", "Astou", "Babacar", "Rokhaya", "Alioune"];
const noms = ["Ndiaye", "Diop", "Fall", "Sow", "Ba", "Gueye", "Faye", "Sarr", "Diallo", "Cissé", "Mbaye", "Thiam", "Kane", "Seck"];
const villes = ["Dakar", "Thiès", "Saint-Louis", "Kaolack", "Ziguinchor", "Touba", "Mbour", "Rufisque", "Louga", "Kolda", "Tambacounda", "Diourbel"];
const generes = [];
for (let i = 0; i < 491; i++) {
  const id = 6001 + i;
  const nbCommandes = 1 + Math.floor(alea() * 4);
  const commandes = [];
  for (let k = 0; k < nbCommandes; k++) {
    const jour = Math.floor(alea() * 365);                       // du 1er nov. 2025 au 31 oct. 2026
    commandes.push({
      id: "CMD-W" + id + "-" + (k + 1),
      date: new Date(Date.UTC(2025, 10, 1) + jour * 86400000),
      total: 1500 + 500 * Math.floor(alea() * 118)               // de 1 500 à 60 000 FCFA
    });
  }
  const client = { _id: id, nom: choisir(prenoms) + " " + choisir(noms), ville: choisir(villes), commandes: commandes };
  if (i % 33 !== 5) {
    client.telephone = "+22177" + String(1000000 + id).slice(-7);  // +221 suivi de 9 chiffres
  }
  generes.push(client);
}

db.clients.drop();
db.clients.insertMany(reference.concat(generes));
print("Clients : " + db.clients.countDocuments());
print("Sans téléphone : " + db.clients.countDocuments({ telephone: { $exists: false } }));
