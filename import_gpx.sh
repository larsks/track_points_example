#!/bin/sh

if [ -z "$1" ]; then
	echo "ERROR: specify an output filename" >&2
	exit 1
fi

if [ -f "$1" ]; then
	echo "ERROR: output file $1 already exists" >&2
	exit 1
fi

echo import gpx to spatialite database
ogr2ogr -f SQLite -dim XYZ -lco GEOMETRY_NAME=geom -t_srs EPSG:26986 -dsco SPATIALITE=yes "$1" track_points.gpx track_points

echo create track_lines table
spatialite -batch -silent "$1" < create_track_lines_table.sql

echo add geometry column
spatialite -batch -silent "$1" < create_geometry_column.sql

echo convert point data to lines
spatialite -batch -silent "$1" < convert_to_lines.sql
