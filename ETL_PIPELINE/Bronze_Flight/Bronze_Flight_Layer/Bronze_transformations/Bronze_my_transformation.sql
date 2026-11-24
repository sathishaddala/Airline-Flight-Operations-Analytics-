CREATE CATALOG IF NOT EXISTS aviation_catalog;   -- or use a catalog you already have
CREATE SCHEMA  IF NOT EXISTS aviation_catalog.flights;
CREATE VOLUME  IF NOT EXISTS aviation_catalog.flights.raw_files;
 
-- Upload airline_flights_raw.csv into the volume (Catalog Explorer → raw_files → Upload)
-- Then preview it:
SELECT * FROM read_files('/Volumes/aviation_catalog/flights/raw_files/',
                         format => 'csv', header => true) LIMIT 10;









CREATE OR REFRESH STREAMING TABLE bronze_airline_flights AS
SELECT *,
       _metadata.file_name AS source_file,
       current_timestamp() AS loaded_at
FROM STREAM read_files('/Volumes/airline_catlog/default/airline_flights_volume',
                       format => 'csv', header => true);
