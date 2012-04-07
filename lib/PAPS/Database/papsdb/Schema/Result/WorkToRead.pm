use utf8;
package PAPS::Database::papsdb::Schema::Result::WorkToRead;

=head1 NAME

PAPS::Database::papsdb::Schema::Result::Work

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

=head1 TABLE: C<works_to_read>

=cut

__PACKAGE__->table_class('DBIx::Class::ResultSource::View');

=head1 VIEW DEFINITION

=cut

__PACKAGE__->table('works_to_read');
__PACKAGE__->result_source_instance->is_virtual(1);

__PACKAGE__->result_source_instance->view_definition(q[
WITH RECURSIVE referencing_works AS
(
    select w.work_id as work_id, w.meta_work_id as meta_work_id,
       w.work_type_id as work_type_id,
       w.title as title, w.subtitle as subtitle,
       w.edition as edition, w.num_references as num_references,
       w.doi as doi, w.year as year,
       -1 as referenced_work_id, 0 as depth
    from works w
    where w.work_id = ?

    UNION ALL

    select w.work_id as work_id, w.meta_work_id as meta_work_id,
       w.work_type_id as work_type_id,
       w.title as title, w.subtitle as subtitle,
       w.edition as edition, w.num_references as num_references,
       w.doi as doi, w.year as year,
       wr.referenced_work_id, w2.depth + 1 as depth
    from works w
    inner join work_references wr on w.work_id = wr.referencing_work_id
    inner join referencing_works w2 on w2.work_id = wr.referenced_work_id
    --where w2.depth = max(w2.depth)
)
select distinct rw.work_id as work_id, rw.meta_work_id as meta_work_id,
    rw.work_type_id as work_type_id,
    rw.title as title, rw.subtitle as subtitle,
    rw.edition as edition, rw.num_references as num_references,
    rw.doi as doi, rw.year as year,
    rw.referenced_work_id as referenced_work_id, rw.depth as depth
from referencing_works rw
left join user_work_data uwd on rw.work_id = uwd.work_id
    and uwd.user_id = ?
order by rw.depth, rw.work_id, rw.referenced_work_id
]);

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

=head2 year

  data_type: 'smallint'
  is_nullable: 1

=head2 referenced_work_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 depth

  data_type: 'smallint'
  is_nullable: 1

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
  "year",
  { data_type => "smallint", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</work_id>

=back

=cut

__PACKAGE__->set_primary_key("work_id");

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
