-- Labo S1 — schéma relationnel de Teranga Shop (figure 2 de la séquence 1)
-- Commande : docker exec -it s1-postgres psql -U teranga -d teranga -f /sql/01_schema.sql
DROP TABLE IF EXISTS ligne_commande, commande, produit, client, operation, compte;

CREATE TABLE client (
  id_client  int  PRIMARY KEY,
  nom        text NOT NULL,
  ville      text NOT NULL
);

CREATE TABLE produit (
  id_produit     text PRIMARY KEY,
  libelle        text NOT NULL,
  categorie      text NOT NULL,
  prix_unitaire  int  NOT NULL CHECK (prix_unitaire > 0)
);

CREATE TABLE commande (
  id_commande  text PRIMARY KEY,
  id_client    int  NOT NULL REFERENCES client(id_client),
  date_cmd     date NOT NULL,
  statut       text NOT NULL
);

CREATE TABLE ligne_commande (
  id_commande  text NOT NULL REFERENCES commande(id_commande),
  id_produit   text NOT NULL REFERENCES produit(id_produit),
  quantite     int  NOT NULL CHECK (quantite > 0),
  prix_paye    int  NOT NULL,          -- prix unitaire au moment de l'achat
  PRIMARY KEY (id_commande, id_produit)
);

-- Mobile money : transfert ACID de la partie 1
CREATE TABLE compte (
  id_compte  text PRIMARY KEY,
  titulaire  text NOT NULL,
  solde      int  NOT NULL CHECK (solde >= 0)   -- cohérence : jamais de solde négatif
);

CREATE TABLE operation (
  id           serial PRIMARY KEY,
  type         text NOT NULL,
  montant      int  NOT NULL,
  source       text REFERENCES compte(id_compte),
  destination  text REFERENCES compte(id_compte),
  horodatage   timestamptz NOT NULL
);
