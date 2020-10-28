#!/bin/sh

curl -s https://api.github.com/repos/evansiroky/timezone-boundary-builder/releases/latest | jq -r '.assets[] | select(.name == "timezones.geojson.zip") | .browser_download_url' | xargs curl -sL | funzip > combined.json
npx mapshaper -i combined.json -simplify visvalingam 20% -o reduced.json

jq -r '"TRUNCATE TABLE timezones; ALTER TABLE timezones DISABLE KEYS;", (.features[] | [ (.properties.tzid), (.geometry | tostring ), (.geometry.type) ] | "SET @geo=ST_SRID(\( if .[2] == "Polygon" then "multipolygon" else "" end)(ST_GeomFromGeoJSON('"'"'\(.[1])'"'"')),4326);\nINSERT INTO timezones(name,geo) VALUES(\"\(.[0])\", @geo);"), "ALTER TABLE timezones ENABLE KEYS;"' reduced.json | sed 's/-180,/-179.99999,/g' | gzip -9 > timezones.sql.gz
