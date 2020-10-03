#!/bin/sh

if [ -z "$1" ]; then
	echo "ERROR: specify an output filename" >&2
	exit 1
fi

if [ -f "$1" ]; then
	echo "ERROR: output file $1 already exists" >&2
	exit 1
fi

ogr2ogr -f SQLite -dim XYZ -lco GEOMETRY_NAME=geom -t_srs EPSG:26986 -dsco SPATIALITE=yes "$1" track_points.gpx track_points
spatialite -batch -silent "$1" < create_track_lines_table.sql
spatialite -batch -silent "$1" < create_geometry_column.sql
spatialite -batch -silent "$1" < convert_to_lines.sql
