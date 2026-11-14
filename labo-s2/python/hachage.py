"""Séquence 2, partie 4.2 — Pourquoi « hash modulo N » ne suffit pas.

On place 100 000 clés sur 3 nœuds, puis on ajoute un 4e nœud, et on compte
les clés qui doivent changer de nœud avec chaque stratégie.
Lancement : python hachage.py   (Python 3, aucune bibliothèque à installer)
"""
import bisect
import hashlib
from collections import Counter


def h(cle):
    """Valeur de hachage (entier) d'une chaîne."""
    return int(hashlib.md5(cle.encode()).hexdigest(), 16)


CLES = [f"client:{i}" for i in range(100_000)]


def anneau(noeuds, virtuels):
    """Positions de chaque nœud sur l'anneau (v nœuds virtuels par nœud)."""
    points = sorted((h(f"{n}#{i}"), n) for n in noeuds for i in range(virtuels))
    return [p for p, _ in points], [n for _, n in points]


def proprietaire(r, cle):
    """Premier nœud rencontré dans le sens horaire à partir de la clé."""
    positions, noeuds = r
    return noeuds[bisect.bisect_left(positions, h(cle)) % len(positions)]


def repartition(attribution):
    c = Counter(attribution)
    return " / ".join(f"{c[n] / len(CLES):.0%}" for n in sorted(c))


print("Passage de 3 à 4 nœuds sur 100 000 clés\n")
print(f"{'Stratégie':<42}{'Clés déplacées':>16}   Répartition après ajout (N1/N2/N3/N4)")

deplacees = sum(1 for k in CLES if h(k) % 3 != h(k) % 4)
print(f"{'hash(k) mod N':<42}{deplacees / len(CLES):>15.1%}   {repartition(['N' + str(h(k) % 4 + 1) for k in CLES])}")

for v in (1, 16, 256):
    avant = anneau(["N1", "N2", "N3"], v)
    apres = anneau(["N1", "N2", "N3", "N4"], v)
    deplacees = sum(1 for k in CLES if proprietaire(avant, k) != proprietaire(apres, k))
    nom = f"Hachage cohérent, {v} position(s) par nœud"
    print(f"{nom:<42}{deplacees / len(CLES):>15.1%}   {repartition([proprietaire(apres, k) for k in CLES])}")

print("\nOptimum théorique : 25 % (la part que doit recevoir le nouveau nœud).")
