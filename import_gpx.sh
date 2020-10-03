#!/bin/sh

ogr2ogr -f SQLite -dim XYZ -lco GEOMETRY_NAME=geom -t_srs EPSG:26986 -dsco SPATIALITE=yes out.sqlite track_points.gpx track_points
