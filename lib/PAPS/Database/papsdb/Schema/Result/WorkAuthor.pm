use utf8;
package PAPS::Database::papsdb::Schema::Result::WorkAuthor;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::WorkAuthor

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

=head1 TABLE: C<work_authors>

=cut

__PACKAGE__->table("work_authors");

=head1 ACCESSORS

=head2 works_author_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'work_authors_works_author_id_seq'

=head2 work_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 person_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 author_position

  data_type: 'smallint'
  is_nullable: 1

=head2 author_name_text

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 author_affiliation_text

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "works_author_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "work_authors_works_author_id_seq",
  },
  "work_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "person_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "author_position",
  { data_type => "smallint", is_nullable => 1 },
  "author_name_text",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "author_affiliation_text",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</works_author_id>

=back

=cut

__PACKAGE__->set_primary_key("works_author_id");

=head1 RELATIONS

=head2 person

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Person>

=cut

__PACKAGE__->belongs_to(
  "person",
  "PAPS::Database::papsdb::Schema::Result::Person",
  { person_id => "person_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 work

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->belongs_to(
  "work",
  "PAPS::Database::papsdb::Schema::Result::Work",
  { work_id => "work_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-03-17 17:29:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:j2bTm9KQdudYf06XFJ8aBw

=head1 Helper Methods

=head2 display_name

Returns a formatted version of this object suitable for display.

=cut

sub display_name {
    my ($self) = @_;

    return $self->work->display_name . " - " . $self->person->display_name;
}

# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
