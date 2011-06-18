package PAPS::Database::papsdb::Schema::Result::Group;

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

PAPS::Database::papsdb::Schema::Result::Group

=cut

__PACKAGE__->table("groups");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'groups_id_seq'

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
    sequence          => "groups_id_seq",
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
__PACKAGE__->add_unique_constraint("unique__groups__name", ["name"]);

=head1 RELATIONS

=head2 group_groups_member_groups

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::GroupGroup>

=cut

__PACKAGE__->has_many(
  "group_groups_member_groups",
  "PAPS::Database::papsdb::Schema::Result::GroupGroup",
  { "foreign.member_group_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 group_groups_parent_groups

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::GroupGroup>

=cut

__PACKAGE__->has_many(
  "group_groups_parent_groups",
  "PAPS::Database::papsdb::Schema::Result::GroupGroup",
  { "foreign.parent_group_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 group_permissions

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::GroupPermission>

=cut

__PACKAGE__->has_many(
  "group_permissions",
  "PAPS::Database::papsdb::Schema::Result::GroupPermission",
  { "foreign.group_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 group_users

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::GroupUser>

=cut

__PACKAGE__->has_many(
  "group_users",
  "PAPS::Database::papsdb::Schema::Result::GroupUser",
  { "foreign.group_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-06-12 13:38:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:egTnV7WsLkT+JdyLdKZh2w

=head2 member_groups

Type: many_to_many

Related object: L<PAPS::Database:papsdb::Schema::Result::Group>

=cut

__PACKAGE__->many_to_many(member_groups => 'group_groups_member_groups', 'parent_group',
                          { });

=head2 parent_groups

Type: many_to_many

Related object: L<PAPS::Database:papsdb::Schema::Result::Group>

=cut

__PACKAGE__->many_to_many(parent_groups => 'group_groups_parent_groups', 'member_group',
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
