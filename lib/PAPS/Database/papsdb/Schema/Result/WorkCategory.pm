use utf8;
package PAPS::Database::papsdb::Schema::Result::WorkCategory;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::WorkCategory

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

=head1 TABLE: C<work_categories>

=cut

__PACKAGE__->table("work_categories");

=head1 ACCESSORS

=head2 work_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 category_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "work_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "category_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</work_id>

=item * L</category_id>

=back

=cut

__PACKAGE__->set_primary_key("work_id", "category_id");

=head1 RELATIONS

=head2 category

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Category>

=cut

__PACKAGE__->belongs_to(
  "category",
  "PAPS::Database::papsdb::Schema::Result::Category",
  { id => "category_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 work

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->belongs_to(
  "work",
  "PAPS::Database::papsdb::Schema::Result::Work",
  { work_id => "work_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-03-17 17:29:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Ew7TF5mTqA51XrdeJsvweA


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
