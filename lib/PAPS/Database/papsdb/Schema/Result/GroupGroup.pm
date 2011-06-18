package PAPS::Database::papsdb::Schema::Result::GroupGroup;

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

PAPS::Database::papsdb::Schema::Result::GroupGroup

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
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 parent_group

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Group>

=cut

__PACKAGE__->belongs_to(
  "parent_group",
  "PAPS::Database::papsdb::Schema::Result::Group",
  { id => "parent_group_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-06-12 13:38:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:D0e+sqwHo7LTnfL2JmpAuw

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
