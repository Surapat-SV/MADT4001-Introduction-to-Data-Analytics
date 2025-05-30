-- 1
SELECT day, teamid, net_profit, sales, cash_on_hand
FROM CT_financials
WHERE day <> 0
ORDER BY day;

-- 2
SELECT date, teamid, location, product, loctype, allocated
FROM CT_inventory
WHERE loctype = "RTL" AND allocated <> 0
ORDER BY date, teamid;

-- 3
SELECT day, teamid, product, media, marketing_amount
FROM CT_marketing
WHERE media IN ('Media B', 'Media C') AND marketing_amount > 1000
ORDER BY day;

-- 4
SELECT MAX(opex_amount) AS Overflow_fee
FROM CT_operating_expense
WHERE opex = "LAN_OverflowRental";

-- 5
SELECT day, teamid, product, unit_purchased, price, vendor, purchase_amount
FROM CT_procurement
WHERE ((product = 'Apple Juice' AND vendor = 'VFG1' AND unit_purchased = 30000)
    OR
    (product = 'Orange Juice' AND vendor = 'VFG2' AND price < 12)
    OR
    (product = 'Melon Juice' AND purchase_amount > 20000 AND tpe = 'Online')) AND location = 'Bangkok';

-- 6
SELECT date, teamid, product, client, price, sales_amount
FROM CT_sales
WHERE tpe = 'LAN_B2B' AND price BETWEEN 20 AND 30;

-- 7
SELECT teamid, MAX(CAST(net_profit AS INT)) AS max_net_profit_int
FROM CT_financials
WHERE day > 0
GROUP BY teamid
ORDER BY teamid;

-- 8
SELECT location, product, AVG(available) AS 'average available'
FROM CT_inventory
WHERE loctype = "RTL"
GROUP BY location, product
HAVING AVG(available) > 30000;

-- 9
SELECT teamid,
       SUM(CASE WHEN opex = 'LAN_HumanResource' THEN opex_amount ELSE 0 END) AS HumanResource,
       SUM(CASE WHEN opex = 'LAN_Marketing' THEN opex_amount ELSE 0 END) AS Marketing,
       SUM(CASE WHEN opex = 'LAN_Rental' THEN opex_amount ELSE 0 END) AS Rental,
       SUM(CASE WHEN opex = 'LAN_OverflowRental' THEN opex_amount ELSE 0 END) AS OverflowRental,
       SUM(CASE WHEN opex = 'LAN_Interest' THEN opex_amount ELSE 0 END) AS Interest,
       SUM(CASE WHEN opex = 'LAN_ShippingExpense' THEN opex_amount ELSE 0 END) AS Shipping,
       SUM(CASE WHEN opex = 'LAN_LatePenalty' THEN opex_amount ELSE 0 END) AS LatePenalty,
	   SUM(opex_amount) AS Total
FROM CT_operating_expense
GROUP BY teamid
ORDER BY teamid;

-- 10
SELECT DISTINCT co_t.team_name
FROM CT_marketing AS m
LEFT JOIN 
	(SELECT 
		day, 
        teamid, 
        product, 
        SUM(sales_amount) AS sales_amount
	FROM CT_sales
    WHERE tpe="LAN_Retail"
    GROUP BY day, teamid, product
    ) AS s
	ON m.teamid = s.teamid AND m.day = s.day AND m.product = s.product
LEFT JOIN COM_team AS co_t
	ON m.teamid = co_t.teamid
WHERE m.tpe="LAN_Marketing" AND s.sales_amount IS NULL
ORDER BY team_name;

-- 11
SELECT product
FROM    
	(SELECT 
		product, 
        sum(unit_purchased)
	FROM CT_procurement
	GROUP BY product
    ORDER BY sum(unit_purchased) ASC
    LIMIT 1) product4 ;

-- 12
SELECT
   (SELECT SUM(sales_amount)
   FROM CT_sales) / 
   (SELECT SUM(cogs) 
   FROM CT_sales) AS diff_ratio;

-- 13
SELECT
	day, 
    teamid, 
    sales,
	LAG(marketing_amount, 1) OVER (PARTITION BY teamid ORDER BY day, teamid) AS ytd_marketing_amount
FROM (SELECT 
	m.day,
	m.teamid, 
    s.sales, 
	SUM(marketing_amount) AS marketing_amount
FROM CT_marketing AS m
LEFT JOIN (SELECT 
	Day,
    teamid, 
    sum(sales_amount) AS sales
FROM CT_sales
GROUP BY day, teamid) AS s
ON m.day = s.day and m.teamid = s.teamid
WHERE tpe = "LAN_Marketing"
GROUP BY m.day, m.teamid
ORDER BY day, teamid) AS sm
ORDER BY day, teamid;
