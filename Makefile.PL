use inc::Module::Install;

name     'PAPS-Database-papsdb-Schema';
all_from 'lib/PAPS/Database/papsdb/Schema.pm';
author   q{Charles Macanka <cmacanka@gmail.com>};
license  'perl';

requires 'DBIx::Class';
requires 'DBIx::Class::EncodedColumn';
requires 'DBIx::Class::TimeStamp';
requires 'Moose';
requires 'MooseX::NonMoose';
requires 'MooseX::MarkAsMethods';
build_requires 'Test::More';

auto_install;

WriteAll;

