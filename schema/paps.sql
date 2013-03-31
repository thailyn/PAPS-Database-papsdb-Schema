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

DROP TABLE IF EXISTS algorithms CASCADE;
CREATE TABLE algorithms (
  id SERIAL PRIMARY KEY,
  name varchar NOT NULL,
  description varchar NULL,

  CONSTRAINT unique__algorithms__name UNIQUE(name)
);

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

DROP TABLE IF EXISTS personas CASCADE;
CREATE TABLE personas (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL REFERENCES users(id),
  algorithm_id INT NOT NULL REFERENCES algorithms(id),
  version varchar NOT NULL,

  CONSTRAINT unique__personas__user_algorithm_version UNIQUE(user_id, algorithm_id, version)
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
  year smallint,
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
  person_id int REFERENCES people (person_id),
  author_position smallint,
  author_name_text varchar,
  author_affiliation_text varchar
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
  persona_id INT NOT NULL REFERENCES personas (id),
  modified TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT unique__work_references__referenced_referencing_type UNIQUE(referencing_work_id, referenced_work_id, reference_type_id),
  CONSTRAINT unique__work_references__referencing_type_chapter_rank UNIQUE(referencing_work_id, reference_type_id, chapter, rank)
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
  file_type_id int NOT NULL REFERENCES file_types(id),
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

-- The "kind" of tag, which is what the source describes it as.
DROP TABLE IF EXISTS source_tag_types CASCADE;
DROP SEQUENCE IF EXISTS source_tag_types_id_seq;
CREATE SEQUENCE source_tag_types_id_seq;
CREATE TABLE source_tag_types (
  id smallint DEFAULT nextval('source_tag_types_id_seq') PRIMARY KEY,
  source_id int NOT NULL REFERENCES sources(id),
  name varchar NOT NULL,
  description varchar NULL
);

DROP TABLE IF EXISTS source_tags CASCADE;
CREATE TABLE source_tags (
  id SERIAL PRIMARY KEY,
  source_id int NOT NULL REFERENCES sources(id),
  tag_type_id smallint NOT NULL REFERENCES source_tag_types(id),
  name varchar NOT NULL,
  description varchar NULL,
  --parent_tag_id int NULL REFERENCES source_tags(id),
  CONSTRAINT unique__source_tag_types__name UNIQUE(name)
);

DROP TABLE IF EXISTS source_work_tags CASCADE;
CREATE TABLE source_work_tags (
  work_id int NOT NULL REFERENCES works(work_id),
  tag_id smallint NOT NULL REFERENCES source_tags(id),
  PRIMARY KEY(work_id, tag_id)
);

-- Table of normalized tags.
DROP TABLE IF EXISTS tags CASCADE;
CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  name varchar NOT NULL,
  description varchar NULL,
  CONSTRAINT unique__tags__name UNIQUE(name)
);

-- Normalized tags attributed to works
DROP TABLE IF EXISTS work_tags CASCADE;
CREATE TABLE work_tags (
  work_id int NOT NULL REFERENCES works(work_id),
  tag_id int NOT NULL REFERENCES tags(id),
  PRIMARY KEY(work_id, tag_id)
);

-- Maps source tags to tags
DROP TABLE IF EXISTS tag_mappings CASCADE;
CREATE TABLE tag_mappings (
  source_tag_id int NOT NULL REFERENCES source_tags(id),
  tag_id int NOT NULL REFERENCES tags(id),
  PRIMARY KEY(source_tag_id, tag_id)
);

-- The "kind" of category, which is what the source describes it as.
DROP TABLE IF EXISTS source_category_types CASCADE;
DROP SEQUENCE IF EXISTS source_category_types_id_seq CASCADE;
CREATE SEQUENCE source_category_types_id_seq;
CREATE TABLE source_category_types (
  id smallint DEFAULT nextval('source_category_types_id_seq') PRIMARY KEY,
  source_id int NOT NULL REFERENCES sources(id),
  name varchar NOT NULL,
  description varchar NULL
);

DROP TABLE IF EXISTS source_categories CASCADE;
CREATE TABLE source_categories (
  id SERIAL PRIMARY KEY,
  source_id int NOT NULL REFERENCES sources(id),
  category_type_id smallint NOT NULL REFERENCES source_category_types(id),
  name varchar NOT NULL,
  description varchar NULL,
  parent_category_id int NULL REFERENCES source_categories(id),
  CONSTRAINT unique__source_category_types__name UNIQUE(name)
);

DROP TABLE IF EXISTS source_work_categories CASCADE;
CREATE TABLE source_work_categories (
  work_id int NOT NULL REFERENCES works(work_id),
  category_id smallint NOT NULL REFERENCES source_categories(id),
  rank smallint NOT NULL DEFAULT 1,
  PRIMARY KEY(work_id, category_id)
);

-- Table of normalized categories.
DROP TABLE IF EXISTS categories CASCADE;
CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  name varchar NOT NULL,
  description varchar NULL,
  parent_category_id int NULL REFERENCES categories(id),
  CONSTRAINT unique__categories__name UNIQUE(name)
);

-- Normalized categories attributed to works
DROP TABLE IF EXISTS work_categories CASCADE;
CREATE TABLE work_categories (
  work_id int NOT NULL REFERENCES works(work_id),
  category_id int NOT NULL REFERENCES categories(id),
  PRIMARY KEY(work_id, category_id)
);

-- Maps source categories to categories
DROP TABLE IF EXISTS category_mappings CASCADE;
CREATE TABLE category_mappings (
  source_category_id int NOT NULL REFERENCES source_categories(id),
  category_id int NOT NULL REFERENCES categories(id),
  PRIMARY KEY(source_category_id, category_id)
);

DROP TABLE IF EXISTS source_work_meta_keys CASCADE;
DROP SEQUENCE IF EXISTS source_work_meta_keys_id_seq CASCADE;
CREATE SEQUENCE source_work_meta_keys_id_seq;
CREATE TABLE source_work_meta_keys (
  id smallint DEFAULT nextval('source_work_meta_keys_id_seq') PRIMARY KEY,
  source_id int NOT NULL REFERENCES sources(id),
  name varchar NOT NULL,
  description varchar NULL,
  --type varchar NULL,  -- an indicator of what type this data is.  probably should be a FK
  CONSTRAINT unique__source_work_meta_keys__name_source UNIQUE(name, source_id)
);

DROP TABLE IF EXISTS source_work_meta CASCADE;
CREATE TABLE source_work_meta (
  id SERIAL PRIMARY KEY,
  work_id int NOT NULL REFERENCES works(work_id),
  key_id smallint NOT NULL REFERENCES source_work_meta_keys(id),
  rank smallint NOT NULL DEFAULT 0,
  value varchar NULL,
  CONSTRAINT unique__source_work_meta__work_key_rank UNIQUE(work_id, key_id, rank)
);

DROP TABLE IF EXISTS work_meta_keys CASCADE;
DROP SEQUENCE IF EXISTS work_meta_keys_id_seq CASCADE;
CREATE SEQUENCE work_meta_keys_id_seq;
CREATE TABLE work_meta_keys (
  id smallint DEFAULT nextval('work_meta_keys_id_seq') PRIMARY KEY,
  name varchar NOT NULL,
  description varchar NULL,
  --type varchar NULL,  -- an indicator of what type this data is.  probably should be a FK
  CONSTRAINT unique__work_meta_keys__name UNIQUE(name)
);

DROP TABLE IF EXISTS work_meta CASCADE;
CREATE TABLE work_meta (
  id SERIAL PRIMARY KEY,
  work_id int NOT NULL REFERENCES works(work_id),
  key_id smallint NOT NULL REFERENCES work_meta_keys(id),
  rank smallint NOT NULL DEFAULT 0,
  value varchar NULL,
  CONSTRAINT unique__work_meta__work_key_rank UNIQUE(work_id, key_id, rank)
);

-- Maps source meta keys to meta keys
DROP TABLE IF EXISTS meta_keys_mappings CASCADE;
CREATE TABLE meta_keys_mappings (
  source_meta_key_id smallint NOT NULL REFERENCES source_work_meta_keys(id),
  meta_key_id int NOT NULL REFERENCES work_meta_keys(id),
  PRIMARY KEY(source_meta_key_id, meta_key_id)
);

DROP TABLE IF EXISTS user_work_data CASCADE;
CREATE TABLE user_work_data (
  id SERIAL PRIMARY KEY,
  user_id int NOT NULL REFERENCES users(id),
  work_id int NOT NULL REFERENCES works(work_id),
  read_timestamp timestamp without time zone NULL,
  understood_rating smallint NULL,
  approval_rating smallint NULL,

  CONSTRAINT unique__user_work_data__user_work UNIQUE(user_id, work_id)
);

DROP TABLE IF EXISTS collections CASCADE;
CREATE TABLE collections (
  id SERIAL PRIMARY KEY,
  user_id int NOT NULL REFERENCES users(id),
  name varchar NOT NULL,
  description varchar NULL,
  created_timestamp timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  show_with_works boolean NOT NULL DEFAULT TRUE,
  show_with_work_references boolean NOT NULL DEFAULT TRUE,
  show_with_referenced_works boolean NOT NULL DEFAULT TRUE
);

DROP TABLE IF EXISTS collection_works CASCADE;
CREATE TABLE collection_works (
  collection_id int NOT NULL REFERENCES collections(id),
  work_id int NOT NULL REFERENCES works(work_id),
  added_timestamp timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  notes varchar NULL,

  PRIMARY KEY(collection_id, work_id)
);

DROP TABLE IF EXISTS referenced_work_guesses CASCADE;
CREATE TABLE referenced_work_guesses (
  id SERIAL PRIMARY KEY,
  work_reference_id BIGINT NOT NULL REFERENCES work_references(id),
  guessed_referenced_work_id INT NOT NULL REFERENCES works(work_id),
  confidence REAL NOT NULL DEFAULT 0,
  persona_id INT NOT NULL REFERENCES personas (id),
  last_checked timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT unique__referenced_work_guesses__work_reference_persona UNIQUE(work_reference_id, persona_id)
);
