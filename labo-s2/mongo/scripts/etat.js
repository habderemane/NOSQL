// Affiche l'état de chaque membre du replica set, une ligne par nœud
// Dans mongosh : load("/scripts/etat.js")   ou   docker exec -it mongo3 mongosh --quiet /scripts/etat.js
const statut = rs.status();
print("Replica set : " + statut.set);
statut.members.forEach(m => {
  // Un nœud injoignable n'a pas d'heure d'opération connue (MongoDB renvoie la date 1970-01-01)
  const optime = (m.health === 1 && m.optimeDate) ? m.optimeDate.toISOString().substring(11, 19) : "—";
  print("  " + m.name.padEnd(14) + m.stateStr.padEnd(26) + "santé=" + m.health + "  dernière opération=" + optime);
});
