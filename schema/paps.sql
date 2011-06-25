-- -*- sql -*- --

-- Recreate the paps database using this sql file.
-- Sample command:
--   psql -U papsuser [-W] papsdb -f schema/paps.sql
-- Including the -W argument makes entering a password required.

-- Drop any tables if they already exist.
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS groups CASCADE;
DROP TABLE IF EXISTS permissions CASCADE;
DROP TABLE IF EXISTS group_users CASCADE;
DROP TABLE IF EXISTS group_groups CASCADE;
DROP TABLE IF EXISTS user_permissions CASCADE;
DROP TABLE IF EXISTS group_permissions CASCADE;
DROP TABLE IF EXISTS user_permissions_flat CASCADE;
DROP TABLE IF EXISTS group_permissions_flat CASCADE;

DROP TABLE IF EXISTS metaworks CASCADE;
DROP TABLE IF EXISTS work_types CASCADE;
DROP TABLE IF EXISTS works CASCADE;
DROP TABLE IF EXISTS people CASCADE;
DROP TABLE IF EXISTS work_authors CASCADE;
DROP TABLE IF EXISTS reference_types CASCADE;
DROP TABLE IF EXISTS work_references CASCADE;
DROP TABLE IF EXISTS file_types CASCADE;
DROP TABLE IF EXISTS files CASCADE;
DROP TABLE IF EXISTS sources CASCADE;
DROP TABLE IF EXISTS work_sources CASCADE;
DROP TABLE IF EXISTS source_files CASCADE;

-- Create the tables.  Required to, of course, create tables that are
-- referenced before the tables that reference them.

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name varchar NOT NULL,
  password_hash varchar NULL,
  first_name varchar NULL,
  middle_name varchar NULL,
  last_name varchar NULL,
  email varchar NULL,
  date_created timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  is_active boolean NOT NULL DEFAULT TRUE,
  CONSTRAINT unique__users__name UNIQUE(name)
);

CREATE TABLE groups (
  id SERIAL PRIMARY KEY,
  name varchar NOT NULL,
  description varchar NULL,
  CONSTRAINT unique__groups__name UNIQUE(name)
);

CREATE TABLE permissions (
  id SERIAL PRIMARY KEY,
  name varchar NOT NULL,
  description varchar NULL,
  CONSTRAINT unique__permissions__name UNIQUE(name)
);

CREATE TABLE group_users (
  group_id int NOT NULL REFERENCES groups(id),
  user_id int NOT NULL REFERENCES users(id),
  PRIMARY KEY(group_id, user_id)
);

CREATE TABLE group_groups (
  parent_group_id int NOT NULL REFERENCES groups(id),
  member_group_id int NOT NULL REFERENCES groups(id),
  PRIMARY KEY(parent_group_id, member_group_id)
);

CREATE TABLE user_permissions (
  user_id int NOT NULL REFERENCES users(id),
  permission_id int NOT NULL REFERENCES permissions(id),
  PRIMARY KEY(user_id, permission_id)
);

CREATE TABLE group_permissions (
  group_id int NOT NULL REFERENCES groups(id),
  permission_id int NOT NULL REFERENCES permissions(id),
  PRIMARY KEY(group_id, permission_id)
);

/*
CREATE TABLE user_permissions_flat (
  -- TODO
);
*/

/*
CREATE TABLE group_permissions_flat (
  -- TODO
);
*/

-- The metaworks table serves as a link between different works that
-- represent the same overal "work."  For example, two different editions of
-- the same book will be represented as two different works, as they could
-- have virtually completely different metadata (different authors, etc.), but
-- would be connected by referencing the same meta work.
CREATE TABLE metaworks (
  id SERIAL PRIMARY KEY
);

CREATE TABLE work_types (
  work_type_id SERIAL PRIMARY KEY,
  work_type varchar NOT NULL
);

CREATE TABLE works (
  work_id SERIAL PRIMARY KEY,
  meta_work_id int REFERENCES metaworks (id),
  work_type_id int NOT NULL REFERENCES work_types (work_type_id),
  title varchar NOT NULL,
  subtitle varchar,
  edition smallint,
  num_references smallint,
  doi varchar
);

CREATE TABLE people (
  person_id SERIAL PRIMARY KEY,
  first_name varchar,
  middle_name varchar,
  last_name varchar,
  date_of_birth date
);

CREATE TABLE work_authors (
  works_author_id SERIAL PRIMARY KEY,
  work_id int NOT NULL REFERENCES works (work_id),
  person_id int NOT NULL REFERENCES people (person_id),
  author_position smallint
);

CREATE SEQUENCE reference_types_id_seq;
CREATE TABLE reference_types (
  id smallint DEFAULT nextval('reference_types_id_seq') PRIMARY KEY,
  name varchar NOT NULL,
  CONSTRAINT unique__reference_types__name UNIQUE(name)
);
ALTER SEQUENCE reference_types_id_seq OWNED BY reference_types.id;

CREATE TABLE work_references ( -- or, 'citations'
  id BIGSERIAL PRIMARY KEY,
  referencing_work_id integer NOT NULL REFERENCES works (work_id),
  referenced_work_id integer NULL REFERENCES works (work_id),
  reference_type_id smallint NOT NULL REFERENCES reference_types (id),
  rank smallint NOT NULL,
  chapter smallint NULL,
  reference_text text NULL,
  CONSTRAINT unique__work_references__referenced_referencing_type UNIQUE(referencing_work_id, referenced_work_id, reference_type_id)
);

CREATE TABLE file_types (
  id SERIAL PRIMARY KEY,
  extension varchar(10) NOT NULL,
  name varchar NOT NULL,
  mime_type varchar(40) NULL,
  CONSTRAINT unique__file_types__extension_name UNIQUE(extension, name)
);

CREATE TABLE files (
  id SERIAL PRIMARY KEY,
  work_id int NOT NULL REFERENCES works(work_id),
  file_type varchar NOT NULL,
  file_size int NULL,
  description varchar NULL,
  --encoding varchar,
  --url varchar,
  path varchar NULL, -- if file is stored in the file system
  contents bytea NULL, -- if file is stored in the database itself
  user_permission_id int NULL REFERENCES permissions(id) -- null could indicate no required permission
  --free_access boolean,
  --CONSTRAINT unique__files__work_id_source_id_file_type UNIQUE(work_id, source_id, file_type)
);

CREATE TABLE sources (
  id SERIAL PRIMARY KEY,
  name_short varchar(10) NOT NULL,
  name varchar NOT NULL,
  description varchar NULL,
  url varchar NULL,
  has_accounts boolean NULL,
  paid_membership boolean NULL,
  CONSTRAINT unique__sources__name_short UNIQUE(name_short),
  CONSTRAINT unique__sources__name UNIQUE(name),
  CONSTRAINT unique__sources__url UNIQUE(url)
);

CREATE TABLE work_sources (
  id SERIAL PRIMARY KEY,
  work_id int NOT NULL REFERENCES works(work_id),
  source_id int NOT NULL REFERENCES sources(id),
  url varchar NULL
);

CREATE TABLE source_files (
  id SERIAL PRIMARY KEY,
  source_id int NOT NULL REFERENCES sources(id),
  file_id int NOT NULL REFERENCES files(id),
  url varchar NULL,
  parent_url varchar NULL,
  --publically_available boolean NULL,
  CONSTRAINT unique__source_files__source_id_file_id UNIQUE(source_id, file_id),
  CONSTRAINT unique__source_files___url UNIQUE(url)
);

-- Populate the tables with some example data.
INSERT INTO work_types (work_type) VALUES ('Textbook');
INSERT INTO work_types (work_type) VALUES ('Book');
INSERT INTO work_types (work_type) VALUES ('Paper');

INSERT INTO works (work_type_id, title, subtitle, edition) VALUES (1, 'Artificial Intelligence', 'A Modern Approach', 2);
INSERT INTO works (work_type_id, title, subtitle, edition) VALUES (1, 'Artificial Intelligence', 'A Systems Approach', 1);
INSERT INTO works (work_type_id, title, edition, num_references, doi) VALUES (3, 'Takeover Times on Scale-Free Topologies', 1, 33, '10.1145/1276958.1277018'); -- 'http://doi.acm.org/10.1145/1276958.1277018'
INSERT INTO works (work_type_id, title, edition, doi) VALUES (3, 'Parameterizing pair approximations for takeover dynamics', 1, '10.1145/1388969.1389047');
INSERT INTO works (work_type_id, title, edition, doi) VALUES (3, 'An affective guide robot in a shopping mall', 1, '10.1145/1514095.1514127');

INSERT INTO people (first_name, last_name) VALUES ('Stuart', 'Russell');
INSERT INTO people (first_name, last_name) VALUES ('Peter', 'Norvig');
INSERT INTO people (first_name, middle_name, last_name) VALUES ('M.', 'Tim', 'Jones');
INSERT INTO people (first_name, middle_name, last_name) VALUES ('Joshua', 'L.', 'Payne');
INSERT INTO people (first_name, middle_name, last_name) VALUES ('Margaret', 'J.', 'Eppstein');
INSERT INTO people (first_name, middle_name, last_name) VALUES ('Randal', 'L.', 'Schwartz');

INSERT INTO work_authors (work_id, person_id, author_position) VALUES (1, 1, 1);
INSERT INTO work_authors (work_id, person_id, author_position) VALUES (1, 2, 2);
INSERT INTO work_authors (work_id, person_id, author_position) VALUES (2, 3, 1);
INSERT INTO work_authors (work_id, person_id, author_position) VALUES (3, 4, 1);
INSERT INTO work_authors (work_id, person_id, author_position) VALUES (3, 5, 2);
INSERT INTO work_authors (work_id, person_id, author_position) VALUES (4, 4, 1);
INSERT INTO work_authors (work_id, person_id, author_position) VALUES (4, 5, 2);

INSERT INTO reference_types (name) VALUES ('Bibliography'); -- or 'Works Cited'
INSERT INTO reference_types (name) VALUES ('Endnote');
INSERT INTO reference_types (name) VALUES ('Footnote');

INSERT INTO work_references (referencing_work_id, referenced_work_id, reference_type_id, rank, chapter, reference_text) VALUES (1, null, 1, 1, null, '**Aarup**, M., Arentoft, M. M., Parrod, Yo., Stader, J., and Stokes, L (1994). OPTIMUM-AIV: A knowledge-based planning and scheduling system for spacecraft AIV.  In Fox, M. and Zweben, M. (Eds.), _Knowledge Based Scheduling_. Morgan Kaufmann, San Mateo, California.');
INSERT INTO work_references (referencing_work_id, referenced_work_id, reference_type_id, rank, chapter, reference_text) VALUES (1, null, 1, 2, null, '**Abramson**, B. and Yung, M. (1989). Divide and conquer under global constraints:  A solution to the N-queens problem.  _Journal of Parallel and Distributed Computing, 6(3)_, 649-662.');
INSERT INTO work_references (referencing_work_id, referenced_work_id, reference_type_id, rank, chapter, reference_text) VALUES (1, null, 1, 3, null, '**Ackley**, D. H. and Littman, M. L. (1991).  Interactions between learning and evolution.  In Langton, C., Taylor, C., Farmer, J. D., and Ramussen, S. (Eds.), _Artificial Life II_, pp. 487-509.  Addison-Wesley, Redwood City, California.');
INSERT INTO work_references (referencing_work_id, referenced_work_id, reference_type_id, rank, chapter, reference_text) VALUES (2, null, 1, 1, 1, '[LISP 2007] Wikipedia "Lisp (programming language)", 2007. Available online at http://en.wikipedia.org/wiki/Lisp_%28programming_language%29');
INSERT INTO work_references (referencing_work_id, referenced_work_id, reference_type_id, rank, chapter, reference_text) VALUES (2, null, 1, 2, 1, '[Newell 1956] Newell, A., Shaw, J.C., Simon, H.A "Emperical Explorations of the Logic Theory Machine: A Case Study in Heuristics," in Proceedings of the Western Joint Computer Conference, 1956.');
INSERT INTO work_references (referencing_work_id, referenced_work_id, reference_type_id, rank, chapter, reference_text) VALUES (2, null, 1, 3, 1, '[Shannon 1950] Shannon, Claude, "Programming a Computer for Playing Chess," _Philisophical Magazine_ 41, 1950.');
INSERT INTO work_references (referencing_work_id, referenced_work_id, reference_type_id, rank, chapter, reference_text) VALUES (2, null, 1, 1, 2, '[Bouton 1901] "Nim, a game with a complete mathematical theory," Ann, Math, Princeton 3, 35-39, 1901-1902');

INSERT INTO files (work_id, file_type) VALUES (5, 'pdf');

INSERT INTO sources (name_short, name, url, has_accounts, paid_membership) VALUES ('arXiv', 'arXiv.org', 'http://arxiv.org/', TRUE, FALSE);
INSERT INTO sources (name_short, name, url, has_accounts, paid_membership) VALUES ('ACM', 'ACM Digital Library', 'http://portal.acm.org/', TRUE, FALSE);

INSERT INTO work_sources (work_id, source_id, url) VALUES (5, 2, 'http://portal.acm.org/citation.cfm?id=1514095.1514127&coll=ACM&dl=ACM');

INSERT INTO source_files (source_id, file_id, url, parent_url) VALUES (2, 1, 'https://portal.acm.org/purchase.cfm?id=1514127&CFID=24595362&CFTOKEN=61303909', 'http://portal.acm.org/citation.cfm?id=1514095.1514127&coll=ACM&dl=ACM');

-- SAMPLE USER AND GROUP DATA
INSERT INTO users (name, password_hash, first_name, middle_name, last_name, email) VALUES ('test user name', 'i am a password', 'test_first', 'test_middle', 'test_last', 'test.email@somewhere.com');
INSERT INTO users (name, first_name) VALUES ('another test user', 'Bob');
INSERT INTO users (name, first_name, last_name) VALUES ('Lucky User', 'Mary', 'Jane');
INSERT INTO users (name, is_active) VALUES ('Naughty User', FALSE);

INSERT INTO groups (name, description) VALUES ('Registered Users', 'Users who are registered.');
INSERT INTO groups (name, description) VALUES ('Special Users', 'Users who are special.');
INSERT INTO permissions (name, description) VALUES ('Browse Site', 'Permission to browse the site.');
INSERT INTO permissions (name, description) VALUES ('Create New Groups', 'Permission to create new groups.');

INSERT INTO group_users (group_id, user_id) VALUES (1, 1);
INSERT INTO group_users (group_id, user_id) VALUES (1, 2);
INSERT INTO group_users (group_id, user_id) VALUES (2, 1);

INSERT INTO group_groups (parent_group_id, member_group_id) VALUES (2, 1);

INSERT INTO user_permissions (user_id, permission_id) VALUES (3, 2);

INSERT INTO group_permissions (group_id, permission_id) VALUES (1, 1);
INSERT INTO group_permissions (group_id, permission_id) VALUES (2, 2);
