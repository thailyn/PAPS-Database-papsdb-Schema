use utf8;
package PAPS::Database::papsdb::Schema::Result::Person;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::Person

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

=head1 TABLE: C<people>

=cut

__PACKAGE__->table("people");

=head1 ACCESSORS

=head2 person_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'people_person_id_seq'

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

=head2 date_of_birth

  data_type: 'date'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "person_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "people_person_id_seq",
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
  "date_of_birth",
  { data_type => "date", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</person_id>

=back

=cut

__PACKAGE__->set_primary_key("person_id");

=head1 RELATIONS

=head2 work_authors

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkAuthor>

=cut

__PACKAGE__->has_many(
  "work_authors",
  "PAPS::Database::papsdb::Schema::Result::WorkAuthor",
  { "foreign.person_id" => "self.person_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07015 @ 2012-01-15 22:01:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0BVAnygQQfm5bYK7kxjGfA


# You can replace this text with custom code or comments, and it will be preserved on regeneration

=head2 works

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkAuthor>

=cut

# many_to_many():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of has_many() relationship this many_to_many() is shortcut for
#     3) Name of belongs_to() relationship in model class of has_many() above
#   You must already have the has_many() defined to use a many_to_many().
__PACKAGE__->many_to_many(works => 'work_authors', 'work');

# Helper methods

=head2 display_name

Returns a string suitable to represent the essence of this object.

=cut

sub display_name {
    my ($self) = @_;

    return $self->full_name();
}

=head2 full_name

Returns the full name of a person, including his middle name, if it exists.

=cut

sub full_name {
    my ($self) = @_;

    my $name;
    $name = $self->first_name . ' ';
    $name .= $self->middle_name . ' ' if defined $self->middle_name;
    $name .= $self->last_name;
    return $name;
}


=head2 work_count

Return the number of works the current person was an author for.

=cut

sub work_count {
    my ($self) = @_;

    # This uses the many-to-many relationship to get all of the authors for the current
    # person, and uses the 'count' method in DBIx::Class::ResultSet to get an SQL COUNT.
    return $self->works->count;
}


=head2 work_list

Return a comma-separated list of works the current person was an author for.

=cut

sub work_list {
    my ($self) = @_;

    # Loop through all works for the current person, calling the 'display_name' method
    # on each to get the name to use.
    my @names;
    foreach my $work ($self->works) {
        push(@names, $work->display_name);
    }

    return join(', ', @names);
}


__PACKAGE__->meta->make_immutable;
1;
