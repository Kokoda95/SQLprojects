-- Use the database.
USE Olympics;

-- Import data into the athletes table
TRUNCATE TABLE athletes;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Data\\olympics\\athletes.csv'
INTO TABLE athletes
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, name, gender, age, @vheight, @vweight)
SET height = NULLIF(@vheight, ''),
    weight = NULLIF(@vweight, 0);


-- Import data into the summer_games table
TRUNCATE TABLE summer_games;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Data\\olympics\\summer_games.csv'
INTO TABLE summer_games
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(sport, event, year, athlete_id, country_id, @vmedal)
SET medal = NULLIF(TRIM(REPLACE(@vmedal, '\r', '')), '');


-- Import data into the winter_games table
TRUNCATE TABLE winter_games;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Data\\olympics\\winter_games.csv'
INTO TABLE winter_games
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(sport, event, year, athlete_id, country_id, @vmedal)
SET medal = NULLIF(TRIM(REPLACE(@vmedal, '\r', '')), '');

-- Import data into the countries table
TRUNCATE TABLE countries;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Data\\olympics\\countries.csv'
INTO TABLE countries
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Import data into the country_stats table
TRUNCATE TABLE country_stats;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Data\\olympics\\country_stats.csv'
INTO TABLE country_stats
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(year, country_id, @vgdp, @vpop_in_millions, @vnobel_prize_winners)
SET gdp = NULLIF(@vgdp, ''),
    nobel_prize_winners = NULLIF(@vnobel_prize_winners, 0),
    pop_in_millions = NULLIF(@vpop_in_millions, ' ');