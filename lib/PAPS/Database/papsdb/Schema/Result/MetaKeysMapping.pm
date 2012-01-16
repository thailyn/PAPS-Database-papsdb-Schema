use utf8;
package PAPS::Database::papsdb::Schema::Result::MetaKeysMapping;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::MetaKeysMapping

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

=head1 TABLE: C<meta_keys_mappings>

=cut

__PACKAGE__->table("meta_keys_mappings");

=head1 ACCESSORS

=head2 source_meta_key_id

  data_type: 'smallint'
  is_foreign_key: 1
  is_nullable: 0

=head2 meta_key_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "source_meta_key_id",
  { data_type => "smallint", is_foreign_key => 1, is_nullable => 0 },
  "meta_key_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</source_meta_key_id>

=item * L</meta_key_id>

=back

=cut

__PACKAGE__->set_primary_key("source_meta_key_id", "meta_key_id");

=head1 RELATIONS

=head2 meta_key

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkMetaKey>

=cut

__PACKAGE__->belongs_to(
  "meta_key",
  "PAPS::Database::papsdb::Schema::Result::WorkMetaKey",
  { id => "meta_key_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 source_meta_key

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceWorkMetaKey>

=cut

__PACKAGE__->belongs_to(
  "source_meta_key",
  "PAPS::Database::papsdb::Schema::Result::SourceWorkMetaKey",
  { id => "source_meta_key_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07015 @ 2012-01-15 22:01:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Oyd9L3qGfKkXNxx/6JcLPg


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
