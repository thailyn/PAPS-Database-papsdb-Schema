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
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 last_checked

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

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
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "algorithm_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "version",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "last_checked",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<unique__referenced_work_guesses__work_reference_algorithm_versi>

=over 4

=item * L</work_reference_id>

=item * L</user_id>

=item * L</algorithm_id>

=item * L</version>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "unique__referenced_work_guesses__work_reference_algorithm_versi",
  ["work_reference_id", "user_id", "algorithm_id", "version"],
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


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-03-30 15:03:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:PvKMmSCTou/ZGCFV1OT+yg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
