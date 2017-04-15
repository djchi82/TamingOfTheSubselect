DROP SCHEMA IF EXISTS subselect CASCADE;

CREATE SCHEMA subselect;

CREATE TABLE subselect.recording(
	recording_id bigint NOT NULL,
	version int NOT NULL,
	title varchar(1000) NOT NULL,
	artist varchar(1000) NOT NULL,
	duration int,
	lyrics text,
	genre varchar(100),
	CONSTRAINT pk_recording PRIMARY KEY (recording_id, version)
);

CREATE TABLE subselect.recording_key (
	recording_id BIGSERIAL NOT NULL,
	CONSTRAINT pk_recording_key PRIMARY KEY (recording_id)
);

CREATE TABLE subselect.album(
	album_id bigserial NOT NULL,
	title varchar(1000) NOT NULL,
	artist varchar(1000) NOT NULL,
	format varchar(100),
	release_date varchar(12),
	CONSTRAINT pk_album_id PRIMARY KEY (album_id)
);

CREATE TABLE subselect.track(
	album_id bigint NOT NULL,
	recording_id bigint NOT NULL,
	position int,
	CONSTRAINT pk_track PRIMARY KEY (album_id, recording_id)
);

CREATE TABLE subselect.person (
  person_id bigserial NOT NULL,
  name varchar(1000) NOT NULL,
  CONSTRAINT pk_person_id PRIMARY KEY (person_id)
);

CREATE TABLE subselect.recording_person(
	person_id bigint NOT NULL,
  recording_id bigint NOT NULL,
  CONSTRAINT pk_person_recording PRIMARY KEY (recording_id, person_id)
);

ALTER TABLE subselect.recording_person ADD CONSTRAINT fk_recording_person_person_id FOREIGN KEY (person_id)
REFERENCES subselect.person (person_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE NOT DEFERRABLE;

ALTER TABLE subselect.recording_person ADD CONSTRAINT fk_recording_person_recording_id FOREIGN KEY (recording_id)
REFERENCES subselect.recording_key (recording_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE NOT DEFERRABLE;

ALTER TABLE subselect.track ADD CONSTRAINT fk_track_recording_id FOREIGN KEY (recording_id)
REFERENCES subselect.recording_key (recording_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE NOT DEFERRABLE;


ALTER TABLE subselect.track ADD CONSTRAINT fk_track_album_id FOREIGN KEY (album_id)
REFERENCES subselect.album (album_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE NOT DEFERRABLE;

