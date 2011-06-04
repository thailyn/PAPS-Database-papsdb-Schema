package PAPS::Database::papsdb::Schema::Result::Metawork;

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

PAPS::Database::papsdb::Schema::Result::Metawork

=cut

__PACKAGE__->table("metaworks");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'metaworks_id_seq'

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "metaworks_id_seq",
  },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 works

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->has_many(
  "works",
  "PAPS::Database::papsdb::Schema::Result::Work",
  { "foreign.meta_work_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-06-04 17:33:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LH9wZBPO2imEAsoXC+gKfw


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
