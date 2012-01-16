use utf8;
package PAPS::Database::papsdb::Schema::Result::TagMapping;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::TagMapping

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

=head1 TABLE: C<tag_mappings>

=cut

__PACKAGE__->table("tag_mappings");

=head1 ACCESSORS

=head2 source_tag_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 tag_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "source_tag_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "tag_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</source_tag_id>

=item * L</tag_id>

=back

=cut

__PACKAGE__->set_primary_key("source_tag_id", "tag_id");

=head1 RELATIONS

=head2 source_tag

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceTag>

=cut

__PACKAGE__->belongs_to(
  "source_tag",
  "PAPS::Database::papsdb::Schema::Result::SourceTag",
  { id => "source_tag_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 tag

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Tag>

=cut

__PACKAGE__->belongs_to(
  "tag",
  "PAPS::Database::papsdb::Schema::Result::Tag",
  { id => "tag_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07015 @ 2012-01-15 22:01:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GAGdSMK47wfclSPhbbdWFQ


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
