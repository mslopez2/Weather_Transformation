BEGIN;


INSERT INTO PDX_weather
SELECT
	id , 
	(raw_json -> 'current' -> 'precip')::int AS precip,
	(raw_json -> 'current' -> 'humidity')::int AS humidity,
	(raw_json -> 'current' -> 'temperature')::int AS temp_c,
	(raw_json -> 'current' -> 'cloudcover')::int AS cloudcover,
	time
FROM weather_scraper;


UPDATE PDX_weather
SET temp_f = (temp_C * 9/5)+32;


UPDATE PDX_weather
SET 
	dat = time::date,
	tim = time::time;


DELETE FROM PDX_weather
WHERE dat is null;


DELETE FROM weather_scraper;


COMMIT;
