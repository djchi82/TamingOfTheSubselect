-- Basic filtering sub select
SELECT *
  FROM subselect.recording r
  WHERE recording_id in
        (SELECT recording_id
          FROM subselect.track t, subselect.album a
          WHERE t.album_id=a.album_id AND a.title like 'Best of ABBA%')
ORDER BY recording_id, version;

-- Join subselect
SELECT r.recording_id, foo.current_version, r.title, r.artist, r.duration, t.position, a.title, a.artist
FROM subselect.recording r
  JOIN subselect.track t ON t.recording_id=r.recording_id
  JOIN subselect.album a ON t.album_id=a.album_id
  JOIN (SELECT recording_id, MAX(version) AS current_version FROM subselect.recording r GROUP BY  recording_id ORDER BY  recording_id) foo
    ON foo.current_version = r.version AND foo.recording_id=r.recording_id
 WHERE a.title like 'Best of ABBA%' ORDER BY a.album_id;

-- Select statement subselect
SELECT
  r.title,
  r.artist,
  r.duration,
  r.recording_id,
  a.title,
  t.position,
  (SELECT string_agg(name, ' | ') FROM subselect.person p, subselect.recording_person rp WHERE rp.person_id=p.person_id AND rp.recording_id=r.recording_id)
FROM subselect.recording r
  JOIN subselect.track t ON t.recording_id=r.recording_id
  JOIN subselect.album a ON t.album_id=a.album_id
  JOIN (SELECT recording_id, MAX(version) AS current_version FROM subselect.recording r GROUP BY  recording_id ORDER BY  recording_id) foo
    ON foo.current_version = r.version AND foo.recording_id=r.recording_id
WHERE a.title like 'Best of ABBA%' ORDER BY a.album_id;
