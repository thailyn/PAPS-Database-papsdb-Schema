use utf8;
package PAPS::Database::papsdb::Schema::Result::Tag;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::Tag

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::EncodedColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn");

=head1 TABLE: C<tags>

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

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<unique__tags__name>

=over 4

=item * L</name>

=back

=cut

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

=head2 source_tags

Type: many_to_many

Composing rels: L</tag_mappings> -> source_tag

=cut

__PACKAGE__->many_to_many("source_tags", "tag_mappings", "source_tag");

=head2 works

Type: many_to_many

Composing rels: L</work_tags> -> work

=cut

__PACKAGE__->many_to_many("works", "work_tags", "work");


# Created by DBIx::Class::Schema::Loader v0.07015 @ 2012-01-15 22:01:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bQ3QckSyvVjbfapmcRqdkQ


# You can replace this text with custom content, and it will be preserved on regeneration

=head2 works

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->many_to_many(works => 'work_tags',
                          'work',
                          { });

=head2 mapped_source_tags

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceTags>

=cut

__PACKAGE__->many_to_many(mapped_source_tags => 'tag_mappings',
                          'source_tag',
                          { });

__PACKAGE__->meta->make_immutable;
1;
