package PAPS::Database::papsdb::Schema::Result::Work;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn");

=head1 NAME

PAPS::Database::papsdb::Schema::Result::Work

=cut

__PACKAGE__->table("works");

=head1 ACCESSORS

=head2 work_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'works_work_id_seq'

=head2 meta_work_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 work_type_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 title

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 subtitle

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 edition

  data_type: 'smallint'
  is_nullable: 1

=head2 num_references

  data_type: 'smallint'
  is_nullable: 1

=head2 doi

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "work_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "works_work_id_seq",
  },
  "meta_work_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "work_type_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "title",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "subtitle",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "edition",
  { data_type => "smallint", is_nullable => 1 },
  "num_references",
  { data_type => "smallint", is_nullable => 1 },
  "doi",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("work_id");

=head1 RELATIONS

=head2 work_authors

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkAuthor>

=cut

__PACKAGE__->has_many(
  "work_authors",
  "PAPS::Database::papsdb::Schema::Result::WorkAuthor",
  { "foreign.work_id" => "self.work_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 work_references_referenced_works

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkReference>

=cut

__PACKAGE__->has_many(
  "work_references_referenced_works",
  "PAPS::Database::papsdb::Schema::Result::WorkReference",
  { "foreign.referenced_work_id" => "self.work_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 work_references_referencing_works

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkReference>

=cut

__PACKAGE__->has_many(
  "work_references_referencing_works",
  "PAPS::Database::papsdb::Schema::Result::WorkReference",
  { "foreign.referencing_work_id" => "self.work_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 work_type

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkType>

=cut

__PACKAGE__->belongs_to(
  "work_type",
  "PAPS::Database::papsdb::Schema::Result::WorkType",
  { work_type_id => "work_type_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 meta_work

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Metawork>

=cut

__PACKAGE__->belongs_to(
  "meta_work",
  "PAPS::Database::papsdb::Schema::Result::Metawork",
  { id => "meta_work_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-06-04 17:33:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:pRNg4XjmLvT5kKp788tlXA


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
