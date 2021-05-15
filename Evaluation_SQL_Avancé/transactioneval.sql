-- Amity HANAH, Manageuse au sein du magasin d'Arras, vient de prendre sa retraite. Il a été décidé, après de nombreuses tractations,
--  de confier son poste au pépiniériste le plus ancien en poste dans ce magasin. Ce dernier voit alors son salaire augmenter de 5% 
--  et ses anciens collègues pépiniéristes passent sous sa direction.

-- Ecrire la transaction permettant d'acter tous ces changements en base des données.

-- La base de données ne contient actuellement que des employés en postes. Il a été choisi de garder en base une liste des anciens
--  collaborateurs de l'entreprise parti en retraite. Il va donc vous falloir ajouter une ligne dans la table posts pour référencer 
--  les employés à la retraite.

-- Décrire les opérations qui seront à réaliser sur la table posts.

-- Ecrire les requêtes correspondant à ces opéarations.

-- Ecrire la transaction

-- Référencement des employés à la retraite dans la table posts

INSERT INTO posts (pos_libelle)
VALUES ('Retraité(e)');


-- Déclaration de la variable amity_hannah qui regroupe les informations de Amity HANNAH

START TRANSACTION; 
SET @amity_hannah = (SELECT emp_id
                     FROM employees
                     JOIN shops ON emp_sho_id = sho_id
                     WHERE emp_firstname = 'Amity' 
                     AND emp_lastname = 'HANNAH' 
                     AND sho_city = 'Arras');

-- Déclaration de la variable poste_retraite qui reprend les informations de la ligne 'Retraité(e)'

SET @poste_retraite = (SELECT pos_id
                       FROM posts
                       WHERE pos_libelle = 'Retraité(e)');

-- Changement du poste de Mme HANNAH en "retraité(e)"

UPDATE employees
SET emp_pos_id = @poste_retraite 
WHERE emp_id = @amity_hannah;

-- Déclaration de la variable ancien_pepinieriste qui regroupe les informations du plus ancien pépiniériste de Arras

SET @ancien_pepinieriste = (SELECT emp_id
                            FROM employees
                            JOIN shops 
                            ON emp_sho_id = sho_id
                            WHERE sho_id = '2'
                            AND emp_pos_id = (SELECT pos_id
                                              FROM posts
                                              WHERE pos_libelle = 'Pépiniériste')
                            ORDER BY emp_enter_date ASC
                            LIMIT 1);


-- Déclaration de la variable poste_manager qui reprend les informations de la ligne 'Manager(/geuse)'

SET @poste_manager = (SELECT pos_id
                      FROM posts
                      WHERE pos_libelle = 'Manager(/geuse)');


-- Le plus ancien pépiniériste du magasin de Arras devient manager et son salaire augmente de 5%

UPDATE employees 
SET emp_pos_id = @poste_manager, emp_salary = emp_salary*1.05 
WHERE emp_id = @ancien_pepinieriste;

-- Le plus ancien pépiniériste devient le supérieur des autres pépiniéristes du magasin d'Arras

UPDATE employees 
SET emp_superior_id = @ancien_pepinieriste
WHERE emp_pos_id = (SELECT pos_id
                    FROM posts 
                    WHERE pos_libelle = 'Pépiniériste')
AND emp_sho_id = 2;

COMMIT;



