"""Séquence 2, partie 9 — Horloge de Lamport sur deux nœuds.

Règles : +1 à chaque événement local ou envoi ; à la réception d'un message
portant l'horloge h, on prend max(horloge locale, h) + 1.
Lancement : python lamport.py
"""


class Noeud:
    def __init__(self, nom):
        self.nom = nom
        self.horloge = 0

    def _trace(self, action):
        print(f"Nœud {self.nom} : {action:<34} L{self.nom} = {self.horloge}")

    def evenement(self, action):
        self.horloge += 1
        self._trace(action)

    def envoyer(self, destinataire):
        self.horloge += 1
        self._trace(f"envoie un message à {destinataire} (porte {self.horloge})")
        return self.horloge

    def recevoir(self, h_message):
        avant = self.horloge
        self.horloge = max(self.horloge, h_message) + 1
        self._trace(f"reçoit le message : max({avant}, {h_message}) + 1")


a, b = Noeud("A"), Noeud("B")
a.evenement("écrit x = 1")
message = a.envoyer("B")
b.evenement("écrit y = 5")
b.recevoir(message)
b.evenement("écrit x = 7")
print("\nx = 7 (horloge 4) est postérieur à x = 1 (horloge 1) : l'ordre causal est respecté.")
