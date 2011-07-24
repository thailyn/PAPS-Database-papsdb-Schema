package PAPS::Database::papsdb::Schema::Result::SourceWorkTag;

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

PAPS::Database::papsdb::Schema::Result::SourceWorkTag

=cut

__PACKAGE__->table("source_work_tags");

=head1 ACCESSORS

=head2 work_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 tag_id

  data_type: 'smallint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "work_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "tag_id",
  { data_type => "smallint", is_foreign_key => 1, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("work_id", "tag_id");

=head1 RELATIONS

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

=head2 tag

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceTag>

=cut

__PACKAGE__->belongs_to(
  "tag",
  "PAPS::Database::papsdb::Schema::Result::SourceTag",
  { id => "tag_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-07-24 16:54:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:t/LDJ1l5BgaE2empS+Uvkg


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
