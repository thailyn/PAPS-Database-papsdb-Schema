package PAPS::Database::papsdb::Schema::Result::Source;

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

PAPS::Database::papsdb::Schema::Result::Source

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
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("unique__sources__name_short", ["name_short"]);
__PACKAGE__->add_unique_constraint("unique__sources__url", ["url"]);
__PACKAGE__->add_unique_constraint("unique__sources__name", ["name"]);

=head1 RELATIONS

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


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-06-12 20:44:13
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5u2olGMpcGDZpQprYDTrVQ


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


=head1 Helper Methods

=head2 display_name

Returns a formatted version of the name suitable for display.

=cut

sub display_name {
    my ($self) = @_;

    return $self->name;
}

# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
