"""Séquence 2, partie 8 et exercice 1 du TD — Quorums et recouvrement.

Juste après une écriture, seules W copies (tirées au hasard parmi N) ont la
nouvelle valeur. Une lecture interroge R copies au hasard. Si aucune copie
interrogée n'a reçu l'écriture (pas de recouvrement), la lecture est périmée.
On compare la simulation au calcul exact : C(N-W, R) / C(N, R).
Lancement : python quorums.py
"""
import random
from math import comb

CONFIGURATIONS = [(3, 1, 1), (3, 2, 2), (3, 3, 1), (3, 1, 3), (5, 3, 3), (5, 2, 2), (5, 4, 2)]
ESSAIS = 100_000


def simuler(n, w, r, essais=ESSAIS, graine=2026):
    alea = random.Random(graine)
    perimees = 0
    for _ in range(essais):
        ecriture = set(alea.sample(range(n), w))   # copies qui ont la nouvelle valeur
        lecture = set(alea.sample(range(n), r))    # copies interrogées
        if not ecriture & lecture:                 # aucune copie commune
            perimees += 1
    return perimees / essais


print(f"{'N':>2} {'W':>2} {'R':>2}   R+W>N ?   pannes écriture/lecture   lectures périmées (simulation | calcul)")
for n, w, r in CONFIGURATIONS:
    recouvrement = "oui" if r + w > n else "non"
    exact = comb(n - w, r) / comb(n, r)
    print(f"{n:>2} {w:>2} {r:>2}   {recouvrement:^7}   {n - w:>7} / {n - r:<14}   {simuler(n, w, r):>9.1%} | {exact:.1%}")
