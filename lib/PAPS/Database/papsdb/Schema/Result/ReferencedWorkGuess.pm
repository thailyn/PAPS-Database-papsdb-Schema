use utf8;
package PAPS::Database::papsdb::Schema::Result::ReferencedWorkGuess;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::ReferencedWorkGuess

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

=head1 TABLE: C<referenced_work_guesses>

=cut

__PACKAGE__->table("referenced_work_guesses");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'referenced_work_guesses_id_seq'

=head2 work_reference_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 guessed_referenced_work_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 confidence

  data_type: 'real'
  default_value: 0
  is_nullable: 0

=head2 last_checked

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 persona_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "referenced_work_guesses_id_seq",
  },
  "work_reference_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "guessed_referenced_work_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "confidence",
  { data_type => "real", default_value => 0, is_nullable => 0 },
  "last_checked",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "persona_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<unique__referenced_work_guesses__work_reference_persona>

=over 4

=item * L</work_reference_id>

=item * L</persona_id>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "unique__referenced_work_guesses__work_reference_persona",
  ["work_reference_id", "persona_id"],
);

=head1 RELATIONS

=head2 guessed_referenced_work

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->belongs_to(
  "guessed_referenced_work",
  "PAPS::Database::papsdb::Schema::Result::Work",
  { work_id => "guessed_referenced_work_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 persona

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Persona>

=cut

__PACKAGE__->belongs_to(
  "persona",
  "PAPS::Database::papsdb::Schema::Result::Persona",
  { id => "persona_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 work_reference

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkReference>

=cut

__PACKAGE__->belongs_to(
  "work_reference",
  "PAPS::Database::papsdb::Schema::Result::WorkReference",
  { id => "work_reference_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-03-31 12:05:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EGtXkBuX1b0Lm/tYrRaJMQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
