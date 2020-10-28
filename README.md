# mysql-geo-tz

## How to use

1) create table

```
CREATE TABLE `timezones` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `geo` multipolygon NOT NULL /*!80003 SRID 4326 */,
  PRIMARY KEY (`id`),
  UNIQUE KEY `timezones_name_unique` (`name`),
  SPATIAL KEY `timezones_geo_spatial` (`geo`)
) 
```

2) import data 

You can directly use the latest generated `timezones.sql.gz` file from the
releases.

```
zcat timezones.sql.gz | mysql <db> ..
```

3) get time zone based on geo point

```
SELECT name FROM timezones WHERE st_contains(geo, st_srid(point(151.2095611, -33.8862892), 4326));
```

## How to generate the sql file yourself

prerequisites:
- jq
- curl
- npm / npx

1) install dependencies:

```
npm install
```

2) run generate.sh

```
./generate.sh
```

now you have a `timezones.sql.gz` as well as `reduced.json` (the simplified
geojson) and `combined.json` (the full geojson)

The generate script will download the latest `timezones.geojson.zip` from
the https://github.com/evansiroky/timezone-boundary-builder repo and uses
mapshaper to reduce the size of the data (idea borrowed from
https://github.com/ugjka/go-tz )



