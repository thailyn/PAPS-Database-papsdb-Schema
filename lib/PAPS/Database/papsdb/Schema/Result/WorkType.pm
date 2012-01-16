use utf8;
package PAPS::Database::papsdb::Schema::Result::WorkType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::WorkType

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

=head1 TABLE: C<work_types>

=cut

__PACKAGE__->table("work_types");

=head1 ACCESSORS

=head2 work_type_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'work_types_work_type_id_seq'

=head2 work_type

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "work_type_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "work_types_work_type_id_seq",
  },
  "work_type",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</work_type_id>

=back

=cut

__PACKAGE__->set_primary_key("work_type_id");

=head1 RELATIONS

=head2 works

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->has_many(
  "works",
  "PAPS::Database::papsdb::Schema::Result::Work",
  { "foreign.work_type_id" => "self.work_type_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07015 @ 2012-01-15 22:01:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:uBeSIQXf5xaVAu/f7kDR4g


# You can replace this text with custom content, and it will be preserved on regeneration

# Helper methods

=head2 display_name

Returns a string suitable to represent the essence of this object.

=cut

sub display_name {
    my ($self) = @_;

    return $self->work_type;
}

__PACKAGE__->meta->make_immutable;
1;
