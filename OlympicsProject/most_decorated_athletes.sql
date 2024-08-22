-- 1. The Most Decorated Summer Athletes
SELECT
  name AS athlete_name,
  COUNT(medal) AS gold_medals
FROM
  summer_games AS s
  INNER JOIN athletes AS a ON s.athlete_id = a.id
WHERE
  medal = 'Gold'
GROUP BY
  athlete_name
HAVING
  COUNT(medal) >= 3
ORDER BY
  gold_medals DESC;
  
 
