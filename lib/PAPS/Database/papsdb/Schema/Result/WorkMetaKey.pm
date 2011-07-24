package PAPS::Database::papsdb::Schema::Result::WorkMetaKey;

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

PAPS::Database::papsdb::Schema::Result::WorkMetaKey

=cut

__PACKAGE__->table("work_meta_keys");

=head1 ACCESSORS

=head2 id

  data_type: 'smallint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'work_meta_keys_id_seq'

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
    sequence          => "work_meta_keys_id_seq",
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
__PACKAGE__->add_unique_constraint("unique__work_meta_keys__name", ["name"]);

=head1 RELATIONS

=head2 meta_keys_mappings

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::MetaKeysMapping>

=cut

__PACKAGE__->has_many(
  "meta_keys_mappings",
  "PAPS::Database::papsdb::Schema::Result::MetaKeysMapping",
  { "foreign.meta_key_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 work_metas

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkMeta>

=cut

__PACKAGE__->has_many(
  "work_metas",
  "PAPS::Database::papsdb::Schema::Result::WorkMeta",
  { "foreign.key_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-07-24 16:54:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:eTyAR8/vJ5zujhfH0z+sYA


# You can replace this text with custom content, and it will be preserved on regeneration

=head2 works

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->many_to_many(works => 'work_metas',
                          'work',
                          {
                              '+select' => [ 'me.rank', 'me.value' ],
                              '+as' => [ 'rank', 'value' ],
                          });

=head2 mapped_source_meta_keys

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceWorkMetaKey>

=cut

__PACKAGE__->many_to_many(mapped_source_meta_keys => 'meta_keys_mappings',
                          'source_meta_key',
                          { });

__PACKAGE__->meta->make_immutable;
1;
