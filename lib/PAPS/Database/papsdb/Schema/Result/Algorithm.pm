use utf8;
package PAPS::Database::papsdb::Schema::Result::Algorithm;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::Algorithm

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

=head1 TABLE: C<algorithms>

=cut

__PACKAGE__->table("algorithms");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'algorithms_id_seq'

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
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "algorithms_id_seq",
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

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<unique__algorithms__name>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("unique__algorithms__name", ["name"]);

=head1 RELATIONS

=head2 personas

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Persona>

=cut

__PACKAGE__->has_many(
  "personas",
  "PAPS::Database::papsdb::Schema::Result::Persona",
  { "foreign.algorithm_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 referenced_work_guesses

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::ReferencedWorkGuess>

=cut

__PACKAGE__->has_many(
  "referenced_work_guesses",
  "PAPS::Database::papsdb::Schema::Result::ReferencedWorkGuess",
  { "foreign.algorithm_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-03-22 20:27:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:y6Z4q4kRXl5IkhvZw1VqFA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
