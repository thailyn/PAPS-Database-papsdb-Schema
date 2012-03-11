use utf8;
package PAPS::Database::papsdb::Schema::Result::Collection;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::Collection

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

=head1 TABLE: C<collections>

=cut

__PACKAGE__->table("collections");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'collections_id_seq'

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 description

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 created_timestamp

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 show_with_works

  data_type: 'boolean'
  default_value: true
  is_nullable: 0

=head2 show_with_work_references

  data_type: 'boolean'
  default_value: true
  is_nullable: 0

=head2 show_with_referenced_works

  data_type: 'boolean'
  default_value: true
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "collections_id_seq",
  },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
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
  "created_timestamp",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "show_with_works",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
  "show_with_work_references",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
  "show_with_referenced_works",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 collection_works

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::CollectionWork>

=cut

__PACKAGE__->has_many(
  "collection_works",
  "PAPS::Database::papsdb::Schema::Result::CollectionWork",
  { "foreign.collection_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "PAPS::Database::papsdb::Schema::Result::User",
  { id => "user_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07015 @ 2012-03-09 19:40:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NS2PHo7Hfqnr2NqdF7d8Qg


# You can replace this text with custom code or comments, and it will be preserved on regeneration

=head2 works

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->many_to_many(works => 'collection_works',
                          "work",
                         {
                              '+select' => [ 'me.added_timestamp', 'me.notes' ],
                              '+as' => ['added_timestamp', 'notes' ],
                         });

__PACKAGE__->meta->make_immutable;
1;
