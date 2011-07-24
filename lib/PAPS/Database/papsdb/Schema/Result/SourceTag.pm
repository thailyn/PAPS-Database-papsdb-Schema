package PAPS::Database::papsdb::Schema::Result::SourceTag;

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

PAPS::Database::papsdb::Schema::Result::SourceTag

=cut

__PACKAGE__->table("source_tags");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'source_tags_id_seq'

=head2 source_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 tag_type_id

  data_type: 'smallint'
  is_foreign_key: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 description

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "source_tags_id_seq",
  },
  "source_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "tag_type_id",
  { data_type => "smallint", is_foreign_key => 1, is_nullable => 0 },
  "name",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "description",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("unique__source_tag_types__name", ["name"]);

=head1 RELATIONS

=head2 tag_type

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceTagType>

=cut

__PACKAGE__->belongs_to(
  "tag_type",
  "PAPS::Database::papsdb::Schema::Result::SourceTagType",
  { id => "tag_type_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 source

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Source>

=cut

__PACKAGE__->belongs_to(
  "source",
  "PAPS::Database::papsdb::Schema::Result::Source",
  { id => "source_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 source_work_tags

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceWorkTag>

=cut

__PACKAGE__->has_many(
  "source_work_tags",
  "PAPS::Database::papsdb::Schema::Result::SourceWorkTag",
  { "foreign.tag_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tag_mappings

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::TagMapping>

=cut

__PACKAGE__->has_many(
  "tag_mappings",
  "PAPS::Database::papsdb::Schema::Result::TagMapping",
  { "foreign.source_tag_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-07-24 16:54:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Yss3ovHBJ4Iqm7v/W5/mPA


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
