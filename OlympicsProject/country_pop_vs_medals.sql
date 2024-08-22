-- 3. Countries Population vs Number of Medals 

SELECT
  -- Clean the country field to only show country_code
  LEFT(REPLACE(UPPER(TRIM(c.country)), '.', ''), 3) AS country_code,
  -- Pull in pop_in_millions and medals_per_million 
  CAST(pop_in_millions AS FLOAT) / 1000000 AS pop_in_millions,
  -- Add the three medal fields using one sum function
  SUM(
    CASE
      WHEN medal IS NULL THEN 0
      ELSE 1
    END
  ) AS medals,
  SUM(
    CASE
      WHEN medal IS NULL THEN 0
      ELSE 1
    END
  ) / (CAST(cs.pop_in_millions AS FLOAT) / 1000000) AS medals_per_million
FROM
  summer_games AS s
  JOIN countries AS c ON s.country_id = c.id
  -- Update the newest join statement to remove duplication
  JOIN country_stats AS cs ON s.country_id = cs.country_id
  AND s.year = STR_TO_DATE(cs.year, '%m/%d/%Y')
  -- Filter out null populations
WHERE
  cs.pop_in_millions IS NOT NULL
GROUP BY
  c.country,
  pop_in_millions
  -- Keep only the top 25 medals_per_million rows
ORDER BY
  medals_per_million DESC
LIMIT
  25;