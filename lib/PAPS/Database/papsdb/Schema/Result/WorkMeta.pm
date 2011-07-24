package PAPS::Database::papsdb::Schema::Result::WorkMeta;

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

PAPS::Database::papsdb::Schema::Result::WorkMeta

=cut

__PACKAGE__->table("work_meta");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'work_meta_id_seq'

=head2 work_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 key_id

  data_type: 'smallint'
  is_foreign_key: 1
  is_nullable: 0

=head2 rank

  data_type: 'smallint'
  default_value: 0
  is_nullable: 0

=head2 value

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "work_meta_id_seq",
  },
  "work_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "key_id",
  { data_type => "smallint", is_foreign_key => 1, is_nullable => 0 },
  "rank",
  { data_type => "smallint", default_value => 0, is_nullable => 0 },
  "value",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint(
  "unique__work_meta__work_key_rank",
  ["work_id", "key_id", "rank"],
);

=head1 RELATIONS

=head2 key

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkMetaKey>

=cut

__PACKAGE__->belongs_to(
  "key",
  "PAPS::Database::papsdb::Schema::Result::WorkMetaKey",
  { id => "key_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 work

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->belongs_to(
  "work",
  "PAPS::Database::papsdb::Schema::Result::Work",
  { work_id => "work_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-07-24 16:54:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Gr3hBFhpe4Rk2s82kUNiQw


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
