package PAPS::Database::papsdb::Schema::Result::Work;

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

PAPS::Database::papsdb::Schema::Result::Work

=cut

__PACKAGE__->table("works");

=head1 ACCESSORS

=head2 work_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'works_work_id_seq'

=head2 meta_work_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 work_type_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 title

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 subtitle

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 edition

  data_type: 'smallint'
  is_nullable: 1

=head2 num_references

  data_type: 'smallint'
  is_nullable: 1

=head2 doi

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "work_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "works_work_id_seq",
  },
  "meta_work_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "work_type_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "title",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "subtitle",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "edition",
  { data_type => "smallint", is_nullable => 1 },
  "num_references",
  { data_type => "smallint", is_nullable => 1 },
  "doi",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("work_id");

=head1 RELATIONS

=head2 files

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::File>

=cut

__PACKAGE__->has_many(
  "files",
  "PAPS::Database::papsdb::Schema::Result::File",
  { "foreign.work_id" => "self.work_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 work_authors

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkAuthor>

=cut

__PACKAGE__->has_many(
  "work_authors",
  "PAPS::Database::papsdb::Schema::Result::WorkAuthor",
  { "foreign.work_id" => "self.work_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 work_references_referenced_works

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkReference>

=cut

__PACKAGE__->has_many(
  "work_references_referenced_works",
  "PAPS::Database::papsdb::Schema::Result::WorkReference",
  { "foreign.referenced_work_id" => "self.work_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 work_references_referencing_works

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkReference>

=cut

__PACKAGE__->has_many(
  "work_references_referencing_works",
  "PAPS::Database::papsdb::Schema::Result::WorkReference",
  { "foreign.referencing_work_id" => "self.work_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 work_type

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkType>

=cut

__PACKAGE__->belongs_to(
  "work_type",
  "PAPS::Database::papsdb::Schema::Result::WorkType",
  { work_type_id => "work_type_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 meta_work

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Metawork>

=cut

__PACKAGE__->belongs_to(
  "meta_work",
  "PAPS::Database::papsdb::Schema::Result::Metawork",
  { id => "meta_work_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 work_sources

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkSource>

=cut

__PACKAGE__->has_many(
  "work_sources",
  "PAPS::Database::papsdb::Schema::Result::WorkSource",
  { "foreign.work_id" => "self.work_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-06-12 13:38:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:SaC0rWR4eaNxaVGJNbuqcw


# You can replace this text with custom content, and it will be preserved on regeneration

# many_to_many():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of has_many() relationship this many_to_many() is shortcut for
#     3) Name of belongs_to() relationship in model class of has_many() above
#   You must already have the has_many() defined to use a many_to_many().
__PACKAGE__->many_to_many(authors => 'work_authors', 'person',
                          {
                              '+select' => 'me.author_position',
                              '+as' => 'author_position',
                          });

# Helper methods

=head2 display_name

Returns a formatted version of the title and subtitle suitable for display.

=cut

sub display_name {
    my ($self) = @_;

    my $name = $self->title;
    $name .= ': ' . $self->subtitle if defined $self->subtitle;
    return $name;
}

=head2 doi_url

Returns a complete URL based off of the doi value.

=cut

sub doi_url {
    my ($self) = @_;

    my $url;
    $url = 'http://doi.acm.org/' . $self->doi;
    return $url;
}

=head2 author_count

Return the number of authors for the current work.

=cut

sub author_count {
    my ($self) = @_;

    # This uses the many-to-many relationship to get all of the authors for the current
    # work, and uses the 'count' method in DBIx::Class::ResultSet to get an SQL COUNT.
    return $self->authors->count;
}


=head2 author_list

Return a comma-separated list of authors for the current book

=cut

sub author_list {
    my ($self) = @_;

    # Loop through all authors for the current work, calling the 'full_name' method
    # on each to get the name to use.
    my @names;
    foreach my $author ($self->authors) {
        push(@names, $author->full_name);
    }

    return join(', ', @names);
}

__PACKAGE__->meta->make_immutable;
1;
