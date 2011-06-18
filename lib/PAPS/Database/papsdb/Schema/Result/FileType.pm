package PAPS::Database::papsdb::Schema::Result::FileType;

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

PAPS::Database::papsdb::Schema::Result::FileType

=cut

__PACKAGE__->table("file_types");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'file_types_id_seq'

=head2 extension

  data_type: 'varchar'
  is_nullable: 0
  size: 10

=head2 name

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 mime_type

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "file_types_id_seq",
  },
  "extension",
  { data_type => "varchar", is_nullable => 0, size => 10 },
  "name",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "mime_type",
  { data_type => "varchar", is_nullable => 1, size => 40 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("unique__file_types__extension_name", ["extension", "name"]);

=head1 RELATIONS

=head2 files

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::File>

=cut

__PACKAGE__->has_many(
  "files",
  "PAPS::Database::papsdb::Schema::Result::File",
  { "foreign.file_type_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-06-18 19:48:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gLFea6g6jtYkqaiwS1rfRw

=head1 Helper Methods

=head2 display_name

Returns a formatted version of the name suitable for display.

=cut

sub display_name {
    my ($self) = @_;

    return $self->name . " (" . $self->extension . ")";
}

# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
