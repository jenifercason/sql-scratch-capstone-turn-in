--How many campaigns and sources does CoolTShirts use? Which source is used for each campaign?

SELECT DISTINCT COUNT(utm_campaign)
FROM page_visits;
SELECT DISTINCT COUNT(utm_source)
FROM page_visits;
SELECT utm_campaign, utm_source
FROM page_visits
GROUP BY utm_campaign;

--What pages are on the CoolTShirts website?

SELECT DISTINCT page_name
FROM page_visits;

--How many first touches is each campaign responsible for?

WITH first_touch AS(
		SELECT user_id, 
			MIN(timestamp) AS first_touch_at
		FROM page_visits
		GROUP BY user_id)
SELECT 
	pv.utm_campaign,
	COUNT(ft.first_touch_at)
FROM first_touch ft
JOIN page_visits pv
	ON ft.user_id = pv.user_id
	AND ft.first_touch_at = pv.timestamp
GROUP BY pv.utm_campaign;

--How many last touches is each campaign responsible for?

WITH last_touch AS (
	SELECT user_id,
		MAX(timestamp) AS last_touch_at
	FROM page_visits
	GROUP BY user_id)
SELECT 
	pv.utm_campaign,
	COUNT(lt.last_touch_at)
FROM last_touch lt
JOIN page_visits pv
	ON lt.user_id = pv.user_id
	AND lt.last_touch_at = pv.timestamp
GROUP BY pv.utm_campaign;

--How many visitors make a purchase?

SELECT page_name, 
	COUNT(user_id)
FROM page_visits
WHERE page_name = '4 - purchase';

--How many last touches on the purchase page is each campaign responsible for?

WITH last_touch AS (
  SELECT user_id,
    Max(timestamp) as last_touch_at
  FROM page_visits
  GROUP BY user_id)
SELECT 
pv.utm_campaign,
count(lt.last_touch_at)		
FROM last_touch lt
JOIN page_visits pv
  ON lt.user_id = pv.user_id
  AND lt.last_touch_at = pv.timestamp
  where page_name = '4 - purchase'
  group by utm_campaign;