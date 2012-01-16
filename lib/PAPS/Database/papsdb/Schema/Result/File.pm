use utf8;
package PAPS::Database::papsdb::Schema::Result::File;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::File

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

=head1 TABLE: C<files>

=cut

__PACKAGE__->table("files");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'files_id_seq'

=head2 work_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 file_type_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 file_size

  data_type: 'integer'
  is_nullable: 1

=head2 description

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 path

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 contents

  data_type: 'bytea'
  is_nullable: 1

=head2 user_permission_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "files_id_seq",
  },
  "work_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "file_type_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "file_size",
  { data_type => "integer", is_nullable => 1 },
  "description",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "path",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "contents",
  { data_type => "bytea", is_nullable => 1 },
  "user_permission_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 file_type

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::FileType>

=cut

__PACKAGE__->belongs_to(
  "file_type",
  "PAPS::Database::papsdb::Schema::Result::FileType",
  { id => "file_type_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 source_files

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceFile>

=cut

__PACKAGE__->has_many(
  "source_files",
  "PAPS::Database::papsdb::Schema::Result::SourceFile",
  { "foreign.file_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_permission

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Permission>

=cut

__PACKAGE__->belongs_to(
  "user_permission",
  "PAPS::Database::papsdb::Schema::Result::Permission",
  { id => "user_permission_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 work

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->belongs_to(
  "work",
  "PAPS::Database::papsdb::Schema::Result::Work",
  { work_id => "work_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07015 @ 2012-01-15 22:01:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:QVBJc7IKnOG6Tyv5IRanHg


# You can replace this text with custom content, and it will be preserved on regeneration

=head2 sources

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::File>

=cut
__PACKAGE__->many_to_many(sources => 'source_files', 'source',
                          {  });


=head1 Helper Methods

=head2 display_name

Returns a formatted version of the name suitable for display.

=cut

sub display_name {
    my ($self) = @_;

    return $self->work->display_name . ' (' . $self->file_type->display_name . ')';
}


__PACKAGE__->meta->make_immutable;
1;
