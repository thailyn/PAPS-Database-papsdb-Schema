use utf8;
package PAPS::Database::papsdb::Schema::Result::CollectionWork;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::CollectionWork

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

=head1 TABLE: C<collection_works>

=cut

__PACKAGE__->table("collection_works");

=head1 ACCESSORS

=head2 collection_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 work_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 added_timestamp

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 notes

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "collection_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "work_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "added_timestamp",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "notes",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</collection_id>

=item * L</work_id>

=back

=cut

__PACKAGE__->set_primary_key("collection_id", "work_id");

=head1 RELATIONS

=head2 collection

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Collection>

=cut

__PACKAGE__->belongs_to(
  "collection",
  "PAPS::Database::papsdb::Schema::Result::Collection",
  { id => "collection_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-03-17 17:29:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EzMRDzxBu1LOQHM+ntqF5g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
