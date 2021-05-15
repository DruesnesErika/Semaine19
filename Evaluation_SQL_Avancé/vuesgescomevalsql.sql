-- Vues
-- Créez une vue qui affiche le catalogue produits. L'id, la référence et le nom des produits, ainsi que l'id et le nom de la catégorie doivent apparaître.

CREATE VIEW catalogue_produits
AS
SELECT pro_id, pro_ref, pro_name, pro_cat_id, cat_name 
FROM products, categories
WHERE products.pro_cat_id = categories.cat_id;