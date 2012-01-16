use utf8;
package PAPS::Database::papsdb::Schema::Result::Permission;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::Permission

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

=head1 TABLE: C<permissions>

=cut

__PACKAGE__->table("permissions");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'permissions_id_seq'

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
    sequence          => "permissions_id_seq",
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

=head2 C<unique__permissions__name>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("unique__permissions__name", ["name"]);

=head1 RELATIONS

=head2 files

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::File>

=cut

__PACKAGE__->has_many(
  "files",
  "PAPS::Database::papsdb::Schema::Result::File",
  { "foreign.user_permission_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 group_permissions

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::GroupPermission>

=cut

__PACKAGE__->has_many(
  "group_permissions",
  "PAPS::Database::papsdb::Schema::Result::GroupPermission",
  { "foreign.permission_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_permissions

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::UserPermission>

=cut

__PACKAGE__->has_many(
  "user_permissions",
  "PAPS::Database::papsdb::Schema::Result::UserPermission",
  { "foreign.permission_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 groups

Type: many_to_many

Composing rels: L</group_permissions> -> group

=cut

__PACKAGE__->many_to_many("groups", "group_permissions", "group");

=head2 users

Type: many_to_many

Composing rels: L</user_permissions> -> user

=cut

__PACKAGE__->many_to_many("users", "user_permissions", "user");


# Created by DBIx::Class::Schema::Loader v0.07015 @ 2012-01-15 22:01:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:53FFBSaXjpfiOUq+QdA/7w

=head2 groups

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Group>

=cut

__PACKAGE__->many_to_many(groups => 'group_permissions', 'group',
                          { });

=head2 users

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::User>

=cut

__PACKAGE__->many_to_many(users => 'user_permissions', 'user',
                          { });

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
