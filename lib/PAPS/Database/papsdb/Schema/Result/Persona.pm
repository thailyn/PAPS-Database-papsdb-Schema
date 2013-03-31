use utf8;
package PAPS::Database::papsdb::Schema::Result::Persona;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::Persona

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

=head1 TABLE: C<personas>

=cut

__PACKAGE__->table("personas");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'personas_id_seq'

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 algorithm_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 version

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "personas_id_seq",
  },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "algorithm_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "version",
  {
    data_type   => "text",
    is_nullable => 0,
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

=head2 C<unique__personas__user_algorithm_version>

=over 4

=item * L</user_id>

=item * L</algorithm_id>

=item * L</version>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "unique__personas__user_algorithm_version",
  ["user_id", "algorithm_id", "version"],
);

=head1 RELATIONS

=head2 algorithm

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Algorithm>

=cut

__PACKAGE__->belongs_to(
  "algorithm",
  "PAPS::Database::papsdb::Schema::Result::Algorithm",
  { id => "algorithm_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 referenced_work_guesses

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::ReferencedWorkGuess>

=cut

__PACKAGE__->has_many(
  "referenced_work_guesses",
  "PAPS::Database::papsdb::Schema::Result::ReferencedWorkGuess",
  { "foreign.persona_id" => "self.id" },
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
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 work_references

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkReference>

=cut

__PACKAGE__->has_many(
  "work_references",
  "PAPS::Database::papsdb::Schema::Result::WorkReference",
  { "foreign.persona_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-03-31 12:05:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2Ut+d4XN146mAxkg0VTZow


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
