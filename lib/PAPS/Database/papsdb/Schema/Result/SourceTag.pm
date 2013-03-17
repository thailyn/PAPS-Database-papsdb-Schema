use utf8;
package PAPS::Database::papsdb::Schema::Result::SourceTag;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::SourceTag

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

=head1 TABLE: C<source_tags>

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

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<unique__source_tag_types__name>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("unique__source_tag_types__name", ["name"]);

=head1 RELATIONS

=head2 source

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Source>

=cut

__PACKAGE__->belongs_to(
  "source",
  "PAPS::Database::papsdb::Schema::Result::Source",
  { id => "source_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
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

=head2 tag_type

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceTagType>

=cut

__PACKAGE__->belongs_to(
  "tag_type",
  "PAPS::Database::papsdb::Schema::Result::SourceTagType",
  { id => "tag_type_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 tags

Type: many_to_many

Composing rels: L</tag_mappings> -> tag

=cut

__PACKAGE__->many_to_many("tags", "tag_mappings", "tag");

=head2 works

Type: many_to_many

Composing rels: L</source_work_tags> -> work

=cut

__PACKAGE__->many_to_many("works", "source_work_tags", "work");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-03-17 17:29:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:SbbFp3DFN4t4j6YXUofOqg


# You can replace this text with custom content, and it will be preserved on regeneration

=head2 works

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->many_to_many(works => 'source_work_tags',
                          'work',
                          { });

=head2 mapped_tags

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Tags>

=cut

__PACKAGE__->many_to_many(mapped_tags => 'tag_mappings',
                          'tag',
                          { });


=head1 Helper Methods

=head2 display_name

Returns a formatted version of the name suitable for display.

=cut

sub display_name {
    my ($self) = @_;

    #my $value = $self->name;
    #$value .= " (" . $self->source.display_name() . ")";
    ##my $value = ($self->name() . " (" . ($self->source.display_name() || "Unknown") . ")");

    #return ($self->name . " (" . $self->source.display_name() . ")");
    return $self->name;
    #return $value;
}

__PACKAGE__->meta->make_immutable;
1;
