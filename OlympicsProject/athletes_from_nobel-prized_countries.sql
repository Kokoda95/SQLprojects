-- 2. Athletes From Nobel-Prized Countries.

-- Pull event and unique athletes from summer_games 
SELECT
  event,
  -- Add the gender field below
  CASE
    WHEN event LIKE '%Women%' THEN 'female'
    ELSE 'male'
  END AS gender,
  COUNT(DISTINCT athlete_id) AS athletes
FROM
  summer_games
  -- Only include countries that won a nobel prize
WHERE
  country_id IN (
    SELECT
      country_id
    FROM
      country_stats
    WHERE
      nobel_prize_winners > 0
  )
GROUP BY
  event
  -- Add the second query below and combine with a UNION
UNION
SELECT
  event,
  CASE
    WHEN event LIKE '%Women%' THEN 'female'
    ELSE 'male'
  END AS gender,
  COUNT(DISTINCT (athlete_id)) AS athletes
FROM
  winter_games
WHERE
  country_id IN (
    SELECT
      country_id
    FROM
      country_stats
    WHERE
      nobel_prize_winners > 0
  )
GROUP BY
  event
  -- Order and limit the final output
ORDER BY
  athletes DESC
LIMIT
  10;