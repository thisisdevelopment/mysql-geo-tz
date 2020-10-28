# mysql-geo-tz

## How to use

You can directly use the latest generated `timezones.sql.gz` file from the
releases.

```
zcat timezones.sql.gz | mysql <db> ..
```

## How to generate the sql file yourself

1) Install dependencies:

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
the https://github.com/evansiroky/timezone-boundary-builder repo
