package PAPS::Database::papsdb::Schema::Result::CategoryMapping;

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

PAPS::Database::papsdb::Schema::Result::CategoryMapping

=cut

__PACKAGE__->table("category_mappings");

=head1 ACCESSORS

=head2 source_category_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 category_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "source_category_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "category_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("source_category_id", "category_id");

=head1 RELATIONS

=head2 source_category

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceCategory>

=cut

__PACKAGE__->belongs_to(
  "source_category",
  "PAPS::Database::papsdb::Schema::Result::SourceCategory",
  { id => "source_category_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 category

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Category>

=cut

__PACKAGE__->belongs_to(
  "category",
  "PAPS::Database::papsdb::Schema::Result::Category",
  { id => "category_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-07-24 16:54:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:N4ruFwjzGxWIgrfOdR53zw


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
