use utf8;
package PAPS::Database::papsdb::Schema::Result::Source;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::Source

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

=head1 TABLE: C<sources>

=cut

__PACKAGE__->table("sources");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'sources_id_seq'

=head2 name_short

  data_type: 'varchar'
  is_nullable: 0
  size: 10

=head2 name

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 description

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 url

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 has_accounts

  data_type: 'boolean'
  is_nullable: 1

=head2 paid_membership

  data_type: 'boolean'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "sources_id_seq",
  },
  "name_short",
  { data_type => "varchar", is_nullable => 0, size => 10 },
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
  "url",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "has_accounts",
  { data_type => "boolean", is_nullable => 1 },
  "paid_membership",
  { data_type => "boolean", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<unique__sources__name>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("unique__sources__name", ["name"]);

=head2 C<unique__sources__name_short>

=over 4

=item * L</name_short>

=back

=cut

__PACKAGE__->add_unique_constraint("unique__sources__name_short", ["name_short"]);

=head2 C<unique__sources__url>

=over 4

=item * L</url>

=back

=cut

__PACKAGE__->add_unique_constraint("unique__sources__url", ["url"]);

=head1 RELATIONS

=head2 source_categories

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceCategory>

=cut

__PACKAGE__->has_many(
  "source_categories",
  "PAPS::Database::papsdb::Schema::Result::SourceCategory",
  { "foreign.source_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 source_category_types

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceCategoryType>

=cut

__PACKAGE__->has_many(
  "source_category_types",
  "PAPS::Database::papsdb::Schema::Result::SourceCategoryType",
  { "foreign.source_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 source_files

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceFile>

=cut

__PACKAGE__->has_many(
  "source_files",
  "PAPS::Database::papsdb::Schema::Result::SourceFile",
  { "foreign.source_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 source_tag_types

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceTagType>

=cut

__PACKAGE__->has_many(
  "source_tag_types",
  "PAPS::Database::papsdb::Schema::Result::SourceTagType",
  { "foreign.source_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 source_tags

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceTag>

=cut

__PACKAGE__->has_many(
  "source_tags",
  "PAPS::Database::papsdb::Schema::Result::SourceTag",
  { "foreign.source_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 source_work_meta_keys

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceWorkMetaKey>

=cut

__PACKAGE__->has_many(
  "source_work_meta_keys",
  "PAPS::Database::papsdb::Schema::Result::SourceWorkMetaKey",
  { "foreign.source_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 work_sources

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkSource>

=cut

__PACKAGE__->has_many(
  "work_sources",
  "PAPS::Database::papsdb::Schema::Result::WorkSource",
  { "foreign.source_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07015 @ 2012-01-15 22:01:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XLBg7AlXIwA+MO9m7FgjSg


=head2 files

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::File>

=cut

__PACKAGE__->many_to_many(files => 'source_files', 'file',
                          {
                              '+select' => 'me.url',
                              '+as' => 'file_url',
                              '+select' => 'me.parent_url',
                              '+as' => 'file_parent_url',
                          });

=head2 works

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->many_to_many(works => 'work_sources', 'work',
                          {
                              '+select' => 'me.url',
                              '+as' => 'url',
                          });


=head1 Helper Methods

=head2 display_name

Returns a formatted version of the name suitable for display.

=cut

sub display_name {
    my ($self) = @_;

    return $self->name;
}


=head2 work_count

Return the number of works the current source has.

=cut

sub work_count {
    my ($self) = @_;

    # This uses the many-to-many relationship to get all of the authors for the current
    # person, and uses the 'count' method in DBIx::Class::ResultSet to get an SQL COUNT.
    return $self->works->count;
}

# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
