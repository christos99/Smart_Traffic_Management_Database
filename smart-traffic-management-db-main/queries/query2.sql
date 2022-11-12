-- names of areas with very low or low traffic metric

SELECT Area.name AS 'areas with very low or low traffic'
FROM Area
WHERE Area.traffic_metric = 'VERY_LOW' OR Area.traffic_metric = 'LOW'