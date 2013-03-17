use utf8;
package PAPS::Database::papsdb::Schema::Result::SourceWorkMetaKey;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::SourceWorkMetaKey

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

=head1 TABLE: C<source_work_meta_keys>

=cut

__PACKAGE__->table("source_work_meta_keys");

=head1 ACCESSORS

=head2 id

  data_type: 'smallint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'source_work_meta_keys_id_seq'

=head2 source_id

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

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "smallint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "source_work_meta_keys_id_seq",
  },
  "source_id",
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
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<unique__source_work_meta_keys__name_source>

=over 4

=item * L</name>

=item * L</source_id>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "unique__source_work_meta_keys__name_source",
  ["name", "source_id"],
);

=head1 RELATIONS

=head2 meta_keys_mappings

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::MetaKeysMapping>

=cut

__PACKAGE__->has_many(
  "meta_keys_mappings",
  "PAPS::Database::papsdb::Schema::Result::MetaKeysMapping",
  { "foreign.source_meta_key_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 source

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Source>

=cut

__PACKAGE__->belongs_to(
  "source",
  "PAPS::Database::papsdb::Schema::Result::Source",
  { id => "source_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 source_work_metas

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceWorkMeta>

=cut

__PACKAGE__->has_many(
  "source_work_metas",
  "PAPS::Database::papsdb::Schema::Result::SourceWorkMeta",
  { "foreign.key_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 meta_keys

Type: many_to_many

Composing rels: L</meta_keys_mappings> -> meta_key

=cut

__PACKAGE__->many_to_many("meta_keys", "meta_keys_mappings", "meta_key");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-03-17 17:29:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:eEOwBOEEoKQz5AkUPsLZbg


# You can replace this text with custom content, and it will be preserved on regeneration

=head2 works

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->many_to_many(works => 'source_work_metas',
                          'work',
                          {
                              '+select' => [ 'me.rank', 'me.value' ],
                              '+as' => [ 'rank', 'value' ],
                          });

=head2 mapped_meta_keys

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkMetaKey>

=cut

__PACKAGE__->many_to_many(mapped_meta_keys => 'meta_keys_mappings',
                          'meta_key',
                          { });

__PACKAGE__->meta->make_immutable;
1;
