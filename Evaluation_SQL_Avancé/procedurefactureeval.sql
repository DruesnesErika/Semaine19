-- Procédures stockées
-- Créez la procédure stockée facture qui permet d'afficher les informations nécessaires à une facture en fonction d'un numéro de commande.
--  Cette procédure doit sortir le montant total de la commande.

DELIMITER |

CREATE PROCEDURE facture(IN p_numero_commande INT)

BEGIN

SELECT ord_id, cus_lastname, cus_firstname, cus_address, cus_zipcode, cus_city, cou_name, pro_ref, pro_name, 
pro_color, pro_price, ode_unit_price, ode_discount, ode_quantity, ROUND(SUM((ode_unit_price-(ode_unit_price*ode_discount/100))* ode_quantity),2) 
AS 'Prix total'
FROM orders, customers, countries, products, orders_details 
WHERE orders.ord_id = p_numero_commande 
AND products.pro_id = orders_details.ode_pro_id
AND orders.ord_id = orders_details.ode_ord_id 
AND orders.ord_cus_id = customers.cus_id 
AND customers.cus_countries_id = countries.cou_id;

END |

DELIMITER ;
