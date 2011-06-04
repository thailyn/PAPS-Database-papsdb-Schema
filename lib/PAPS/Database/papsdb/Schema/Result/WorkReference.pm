package PAPS::Database::papsdb::Schema::Result::WorkReference;

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

PAPS::Database::papsdb::Schema::Result::WorkReference

=cut

__PACKAGE__->table("work_references");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'work_references_id_seq'

=head2 referencing_work_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 referenced_work_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 reference_type_id

  data_type: 'smallint'
  is_foreign_key: 1
  is_nullable: 0

=head2 rank

  data_type: 'smallint'
  is_nullable: 0

=head2 chapter

  data_type: 'smallint'
  is_nullable: 1

=head2 reference_text

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "work_references_id_seq",
  },
  "referencing_work_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "referenced_work_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "reference_type_id",
  { data_type => "smallint", is_foreign_key => 1, is_nullable => 0 },
  "rank",
  { data_type => "smallint", is_nullable => 0 },
  "chapter",
  { data_type => "smallint", is_nullable => 1 },
  "reference_text",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 referenced_work

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->belongs_to(
  "referenced_work",
  "PAPS::Database::papsdb::Schema::Result::Work",
  { work_id => "referenced_work_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 referencing_work

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->belongs_to(
  "referencing_work",
  "PAPS::Database::papsdb::Schema::Result::Work",
  { work_id => "referencing_work_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 reference_type

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::ReferenceType>

=cut

__PACKAGE__->belongs_to(
  "reference_type",
  "PAPS::Database::papsdb::Schema::Result::ReferenceType",
  { id => "reference_type_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-06-04 17:33:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cm9ytD7EkKMwCzxY3HFdwQ


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
