use utf8;
package PAPS::Database::papsdb::Schema::Result::GroupGroup;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::GroupGroup

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

=head1 TABLE: C<group_groups>

=cut

__PACKAGE__->table("group_groups");

=head1 ACCESSORS

=head2 parent_group_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 member_group_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "parent_group_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "member_group_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</parent_group_id>

=item * L</member_group_id>

=back

=cut

__PACKAGE__->set_primary_key("parent_group_id", "member_group_id");

=head1 RELATIONS

=head2 member_group

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Group>

=cut

__PACKAGE__->belongs_to(
  "member_group",
  "PAPS::Database::papsdb::Schema::Result::Group",
  { id => "member_group_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 parent_group

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Group>

=cut

__PACKAGE__->belongs_to(
  "parent_group",
  "PAPS::Database::papsdb::Schema::Result::Group",
  { id => "parent_group_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-03-17 17:29:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:G0l1eOcyhF0uuuU3My7qSg

=head1 Helper Methods

=head2 display_name

Returns a formatted version of this relationship suitable for display.

=cut

sub display_name {
    my ($self) = @_;

    return $self->parent_group->name . " (Parent) - " . $self->member_group->name . " (Member)";
}

# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
