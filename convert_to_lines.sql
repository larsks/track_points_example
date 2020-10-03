insert into track_lines (
    track_fid, track_seg_id, track_seg_point_id, geom, length
    )
select
    a.track_fid as track_fid, 
    a.track_seg_id as track_seg_id, 
    a.track_seg_point_id as track_seg_point_id, 
    makeline(a.geom, b.geom), 
    st_distance(a.geom, b.geom)
from track_points as a join track_points as b
on (
    a.track_fid = b.track_fid 
    and a.track_seg_id = b.track_seg_id 
    and a.track_seg_point_id = b.track_seg_point_id-1
    );
