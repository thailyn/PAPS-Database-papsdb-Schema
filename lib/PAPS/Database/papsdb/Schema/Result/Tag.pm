package PAPS::Database::papsdb::Schema::Result::Tag;

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

PAPS::Database::papsdb::Schema::Result::Tag

=cut

__PACKAGE__->table("tags");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'tags_id_seq'

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
    sequence          => "tags_id_seq",
  },
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
__PACKAGE__->add_unique_constraint("unique__tags__name", ["name"]);

=head1 RELATIONS

=head2 tag_mappings

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::TagMapping>

=cut

__PACKAGE__->has_many(
  "tag_mappings",
  "PAPS::Database::papsdb::Schema::Result::TagMapping",
  { "foreign.tag_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 work_tags

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkTag>

=cut

__PACKAGE__->has_many(
  "work_tags",
  "PAPS::Database::papsdb::Schema::Result::WorkTag",
  { "foreign.tag_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-07-24 16:54:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:R7THzAghsHsRXKTFWG/uwQ


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
