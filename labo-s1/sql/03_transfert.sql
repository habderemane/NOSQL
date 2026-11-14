-- Labo S1 — partie 1 : un transfert ACID, puis un transfert refusé
-- Commande : docker exec -it s1-postgres psql -U teranga -d teranga -f /sql/03_transfert.sql
\echo === Soldes avant
SELECT id_compte, titulaire, solde FROM compte ORDER BY id_compte;

\echo === Transfert de 10 000 FCFA d’Awa vers Ibou (code de la séquence)
BEGIN;
UPDATE compte SET solde = solde - 10000 WHERE id_compte = 'AWA-221770001';
UPDATE compte SET solde = solde + 10000 WHERE id_compte = 'IBOU-221780002';
INSERT INTO operation(type, montant, source, destination, horodatage)
VALUES ('TRANSFERT', 10000, 'AWA-221770001', 'IBOU-221780002', now());
COMMIT;   -- tout est appliqué, ou rien en cas d'erreur (ROLLBACK)

SELECT id_compte, titulaire, solde FROM compte ORDER BY id_compte;

\echo === Transfert de 100 000 FCFA : plus que le solde d’Awa
BEGIN;
UPDATE compte SET solde = solde - 100000 WHERE id_compte = 'AWA-221770001';
UPDATE compte SET solde = solde + 100000 WHERE id_compte = 'IBOU-221780002';
COMMIT;

\echo === Soldes après la tentative : rien n’a changé
SELECT id_compte, titulaire, solde FROM compte ORDER BY id_compte;
SELECT count(*) AS operations_enregistrees FROM operation;
