use utf8;
package PAPS::Database::papsdb::Schema::Result::UserWorkData;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::UserWorkData

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

=head1 TABLE: C<user_work_data>

=cut

__PACKAGE__->table("user_work_data");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'user_work_data_id_seq'

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 work_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 read_timestamp

  data_type: 'timestamp'
  is_nullable: 1

=head2 understood_rating

  data_type: 'smallint'
  is_nullable: 1

=head2 approval_rating

  data_type: 'smallint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "user_work_data_id_seq",
  },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "work_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "read_timestamp",
  { data_type => "timestamp", is_nullable => 1 },
  "understood_rating",
  { data_type => "smallint", is_nullable => 1 },
  "approval_rating",
  { data_type => "smallint", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<unique__user_work_data__user_work>

=over 4

=item * L</user_id>

=item * L</work_id>

=back

=cut

__PACKAGE__->add_unique_constraint("unique__user_work_data__user_work", ["user_id", "work_id"]);

=head1 RELATIONS

=head2 user

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "PAPS::Database::papsdb::Schema::Result::User",
  { id => "user_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07015 @ 2012-02-11 17:09:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5RjI55K9IBj5yWN03hlZVg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
