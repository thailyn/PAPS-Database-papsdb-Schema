package PAPS::Database::papsdb::Schema::Result::GroupPermission;

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

PAPS::Database::papsdb::Schema::Result::GroupPermission

=cut

__PACKAGE__->table("group_permissions");

=head1 ACCESSORS

=head2 group_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 permission_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "group_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "permission_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("group_id", "permission_id");

=head1 RELATIONS

=head2 group

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Group>

=cut

__PACKAGE__->belongs_to(
  "group",
  "PAPS::Database::papsdb::Schema::Result::Group",
  { id => "group_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 permission

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Permission>

=cut

__PACKAGE__->belongs_to(
  "permission",
  "PAPS::Database::papsdb::Schema::Result::Permission",
  { id => "permission_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-06-12 13:38:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:MALLXi5F/kLvhEjAXoaBZw

=head1 Helper Methods

=head2 display_name

Returns a formatted version of the name suitable for display.

=cut

sub display_name {
    my ($self) = @_;

    return $self->group->name . " - " . $self->permission->name;;
}


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
