use utf8;
package PAPS::Database::papsdb::Schema::Result::UserPermission;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::UserPermission

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

=head1 TABLE: C<user_permissions>

=cut

__PACKAGE__->table("user_permissions");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 permission_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "permission_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=item * L</permission_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id", "permission_id");

=head1 RELATIONS

=head2 permission

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Permission>

=cut

__PACKAGE__->belongs_to(
  "permission",
  "PAPS::Database::papsdb::Schema::Result::Permission",
  { id => "permission_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 user

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "PAPS::Database::papsdb::Schema::Result::User",
  { id => "user_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-03-17 17:29:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2eSRUZYRI9VZrcq/7TyHzQ

=head1 Helper Methods

=head2 display_name

Returns a formatted version of this object suitable for display.

=cut

sub display_name {
    my ($self) = @_;

    return $self->user->display_name . " - " . $self->permission->display_name;
}

# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
