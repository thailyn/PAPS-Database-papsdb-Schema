-- -*- sql -*- --

-- Repopulate the paps database using this sql file.
-- Sample command:
--   psql -U papsuser [-W] papsdb -f schema/paps-data.sql
-- Including the -W argument makes entering a password required.

delete from source_tag_types;
delete from group_permissions;
delete from user_permissions;
delete from group_groups;
delete from group_users;
delete from permissions;
delete from groups;
delete from users;
delete from source_files;
delete from work_sources;
delete from sources;
delete from files;
delete from file_types;
delete from work_references;
delete from reference_types;
delete from work_authors;
delete from people;
delete from works;
delete from work_types;

-- Populate the tables with some example data.
INSERT INTO work_types (work_type) VALUES ('Textbook');
INSERT INTO work_types (work_type) VALUES ('Book');
INSERT INTO work_types (work_type) VALUES ('Paper');

INSERT INTO works (work_type_id, title, subtitle, edition) VALUES (1, 'Artificial Intelligence', 'A Modern Approach', 2); -- 1
INSERT INTO works (work_type_id, title, subtitle, edition) VALUES (1, 'Artificial Intelligence', 'A Systems Approach', 1); -- 2
INSERT INTO works (work_type_id, title, edition, num_references, doi) VALUES (3, 'Takeover Times on Scale-Free Topologies', 1, 33, '10.1145/1276958.1277018'); -- 'http://doi.acm.org/10.1145/1276958.1277018' -- 3
INSERT INTO works (work_type_id, title, edition, doi) VALUES (3, 'Parameterizing pair approximations for takeover dynamics', 1, '10.1145/1388969.1389047'); -- 4
INSERT INTO works (work_type_id, title, edition, doi) VALUES (3, 'An affective guide robot in a shopping mall', 1, '10.1145/1514095.1514127'); -- 5
INSERT INTO works (work_type_id, title, edition, doi) VALUES (3, 'Design patterns for sociality in human-robot interaction', 1, '10.1145/1349822.1349836'); -- 6
INSERT INTO works (work_type_id, title, edition, doi) VALUES (3, 'Information provision-timing control for informational assistance robot', 1, '10.1145/1957656.1957760'); -- 7

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
INSERT INTO work_references (referencing_work_id, referenced_work_id, reference_type_id, rank, chapter, reference_text) VALUES (5, null, 1, 1, 3, 'Mutlu, B. et al., A Storytelling Robot: Modeling and Evaluation of Human-like Gaze Behavior, IEEE Int. Conf. on Humanoid Robots (Humanoids2006), pp. 518--523, 2006.');
INSERT INTO work_references (referencing_work_id, referenced_work_id, reference_type_id, rank, chapter, reference_text) VALUES (5, 6, 1, 4, null, 'Peter H. Kahn , Nathan G. Freier , Takayuki Kanda , Hiroshi Ishiguro , Jolina H. Ruckert , Rachel L. Severson , Shaun K. Kane, Design patterns for sociality in human-robot interaction, Proceedings of the 3rd ACM/IEEE international conference on Human robot interaction, March 12-15, 2008, Amsterdam, The Netherlands');
INSERT INTO work_references (referencing_work_id, referenced_work_id, reference_type_id, rank, chapter, reference_text) VALUES (7, null, 1, 1, null, 'Faceapi, http://www.seeingmachines.com/product/faceapi.');
INSERT INTO work_references (referencing_work_id, referenced_work_id, reference_type_id, rank, chapter, reference_text) VALUES (7, 5, 1, 4, null, 'Takayuki Kanda , Masahiro Shiomi , Zenta Miyashita , Hiroshi Ishiguro , Norihiro Hagita, An affective guide robot in a shopping mall, Proceedings of the 4th ACM/IEEE international conference on Human robot interaction, March 09-13, 2009, La Jolla, California, USA');

INSERT INTO file_types (extension, name, mime_type) VALUES ('pdf', 'Portable Document Format', 'application/pdf');

INSERT INTO files (work_id, file_type_id) VALUES (5, 1);

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
