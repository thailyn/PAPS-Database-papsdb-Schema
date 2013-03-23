use utf8;
package PAPS::Database::papsdb::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::User

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

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 password_hash

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 first_name

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 middle_name

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 last_name

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 email

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 date_created

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 is_active

  data_type: 'boolean'
  default_value: true
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_id_seq",
  },
  "name",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "password_hash",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "first_name",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "middle_name",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "last_name",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "email",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "date_created",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "is_active",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<unique__users__name>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("unique__users__name", ["name"]);

=head1 RELATIONS

=head2 collections

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Collection>

=cut

__PACKAGE__->has_many(
  "collections",
  "PAPS::Database::papsdb::Schema::Result::Collection",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 group_users

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::GroupUser>

=cut

__PACKAGE__->has_many(
  "group_users",
  "PAPS::Database::papsdb::Schema::Result::GroupUser",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 personas

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Persona>

=cut

__PACKAGE__->has_many(
  "personas",
  "PAPS::Database::papsdb::Schema::Result::Persona",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 referenced_work_guesses

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::ReferencedWorkGuess>

=cut

__PACKAGE__->has_many(
  "referenced_work_guesses",
  "PAPS::Database::papsdb::Schema::Result::ReferencedWorkGuess",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_permissions

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::UserPermission>

=cut

__PACKAGE__->has_many(
  "user_permissions",
  "PAPS::Database::papsdb::Schema::Result::UserPermission",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_work_datas

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::UserWorkData>

=cut

__PACKAGE__->has_many(
  "user_work_datas",
  "PAPS::Database::papsdb::Schema::Result::UserWorkData",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 groups

Type: many_to_many

Composing rels: L</group_users> -> group

=cut

__PACKAGE__->many_to_many("groups", "group_users", "group");

=head2 permissions

Type: many_to_many

Composing rels: L</user_permissions> -> permission

=cut

__PACKAGE__->many_to_many("permissions", "user_permissions", "permission");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-03-22 20:27:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:TEv5tzbliMCpVC8H0uhkyQ

=head2 columns

Set the encoding for the password_hash column.
SHA-1 / hex encoding / generate check method

Also retrieve the created date when inserting a new user.

=cut

__PACKAGE__->add_columns(
  "password_hash",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
    encode_column => 1,
    encode_class  => 'Digest',
    encode_args   => {algorithm => 'SHA-1', format => 'hex', salt_length => 20},
    encode_check_method => 'check_password',
  },
  "date_created",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
    retrieve_on_insert => 1,
  },
);

=head2 groups

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Group>

=cut

__PACKAGE__->many_to_many(groups => 'group_users', 'grp',
                          { });

=head2 permissions

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Permission>

=cut

__PACKAGE__->many_to_many(permissions => 'user_permissions', 'permission',
                          { });

=head1 Helper Methods

=head2 display_name

Returns a formatted version of the name suitable for display.

=cut

sub display_name {
    my ($self) = @_;

    return $self->name;
}

# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
