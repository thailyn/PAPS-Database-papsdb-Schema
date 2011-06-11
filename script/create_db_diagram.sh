#!/bin/bash

# Remove the backup files.
rm -f schema/schema.yaml.prev
rm -f schema/schema.png.prev
# Rename the current schema files to act as a backup.
mv schema/schema.yaml schema/schema.yaml.prev
mv schema/schema.png schema/schema.png.prev

# Create the YAML dump of the db
sqlt --from DBI --dsn dbi:Pg:dbname=papsdb --db-user papsuser --to YAML > schema/schema.yaml
# Create a diagram from the YAML file.
sqlt-graph --from=YAML --color --show-datatypes --show-sizes --show-constraints --output-type png schema/schema.yaml > schema/schema.png
