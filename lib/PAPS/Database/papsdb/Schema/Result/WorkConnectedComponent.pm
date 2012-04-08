use utf8;
package PAPS::Database::papsdb::Schema::Result::WorkConnectedComponent;

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

=head1 TABLE: C<work_connected_component>

=cut

__PACKAGE__->table_class('DBIx::Class::ResultSource::View');

=head1 VIEW DEFINITION

=cut

__PACKAGE__->table('work_connected_component');
__PACKAGE__->result_source_instance->is_virtual(1);

__PACKAGE__->result_source_instance->view_definition(q[
WITH RECURSIVE referencing_works AS
(
  select w.work_id as work_id, w.meta_work_id as meta_work_id,
     w.work_type_id as work_type_id,
     w.title as title, w.subtitle as subtitle,
     w.edition as edition, w.num_references as num_references,
     w.doi as doi, w.year as year,
     -1 as referencing_work_id--, 0 as depth
  from works w
  where w.work_id = ?

  UNION

  select w.work_id as work_id, w.meta_work_id as meta_work_id,
     w.work_type_id as work_type_id,
     w.title as title, w.subtitle as subtitle,
     w.edition as edition, w.num_references as num_references,
     w.doi as doi, w.year as year,
     wr.referencing_work_id as referencing_work_id--, 0 as depth
  from works w
  inner join work_references wr on (w.work_id = wr.referenced_work_id)
        or (w.work_id = wr.referencing_work_id and wr.referenced_work_id is not null)
  inner join referencing_works w2 on w2.work_id != w.work_id
        and (w2.work_id = wr.referenced_work_id or w2.work_id = wr.referencing_work_id)
)
select distinct rw.work_id as work_id, rw.meta_work_id as meta_work_id,
    rw.work_type_id as work_type_id,
    rw.title as title, rw.subtitle as subtitle,
    rw.edition as edition, rw.num_references as num_references,
    rw.doi as doi, rw.year as year,
    rw.referencing_work_id as referencing_work_id, /*rw.depth as depth,*/
    uwd.read_timestamp as read_timestamp, uwd.understood_rating as understood_rating,
    uwd.approval_rating as approval_rating
from referencing_works rw
left join user_work_data uwd on rw.work_id = uwd.work_id
     and uwd.user_id = ?
order by /*rw.depth,*/ rw.work_id
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

=head2 referencing_work_id

  data_type: 'integer'
  is_nullable: 1

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
  "referencing_work_id",
  { data_type => "integer", is_nullable => 1 },
  "read_timestamp",
  { data_type => "timestamp", is_nullable => 1 },
  "understood_rating",
  { data_type => "smallint", is_nullable => 1 },
  "approval_rating",
  { data_type => "smallint", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</work_id>

=back

=cut

__PACKAGE__->set_primary_key("work_id");

=head1 RELATIONS

=head2 collection_works

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::CollectionWork>

=cut

__PACKAGE__->has_many(
  "collection_works",
  "PAPS::Database::papsdb::Schema::Result::CollectionWork",
  { "foreign.work_id" => "self.work_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

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

=head2 source_work_categories

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceWorkCategory>

=cut

__PACKAGE__->has_many(
  "source_work_categories",
  "PAPS::Database::papsdb::Schema::Result::SourceWorkCategory",
  { "foreign.work_id" => "self.work_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 source_work_metas

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceWorkMeta>

=cut

__PACKAGE__->has_many(
  "source_work_metas",
  "PAPS::Database::papsdb::Schema::Result::SourceWorkMeta",
  { "foreign.work_id" => "self.work_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 source_work_tags

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceWorkTag>

=cut

__PACKAGE__->has_many(
  "source_work_tags",
  "PAPS::Database::papsdb::Schema::Result::SourceWorkTag",
  { "foreign.work_id" => "self.work_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_work_datas

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::UserWorkData>

=cut

__PACKAGE__->has_many(
  "user_work_datas",
  "PAPS::Database::papsdb::Schema::Result::UserWorkData",
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

=head2 work_categories

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkCategory>

=cut

__PACKAGE__->has_many(
  "work_categories",
  "PAPS::Database::papsdb::Schema::Result::WorkCategory",
  { "foreign.work_id" => "self.work_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 work_metas

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkMeta>

=cut

__PACKAGE__->has_many(
  "work_metas",
  "PAPS::Database::papsdb::Schema::Result::WorkMeta",
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

=head2 work_tags

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkTag>

=cut

__PACKAGE__->has_many(
  "work_tags",
  "PAPS::Database::papsdb::Schema::Result::WorkTag",
  { "foreign.work_id" => "self.work_id" },
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

=head2 categories

Type: many_to_many

Composing rels: L</work_categories> -> category

=cut

__PACKAGE__->many_to_many("categories", "work_categories", "category");

=head2 tags

Type: many_to_many

Composing rels: L</work_tags> -> tag

=cut

__PACKAGE__->many_to_many("tags", "work_tags", "tag");

=head2 tags_2s

Type: many_to_many

Composing rels: L</source_work_tags> -> tag

=cut

__PACKAGE__->many_to_many("tags_2s", "source_work_tags", "tag");


=head2 work_references_referencing_works

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkReference>
This has_many relationship is being redefined here because the naming that
DBIx uses relates a relationship specifically with the name of the foreign
field.  In most cases, that is fine, but here, we need the opposite.  What a
Work is referenced by (what is referencing it and what, simply from the
perspective of the reference, is the Work being referenced) should be in its
list of work_references_referencing_works and, by extension, the
referencing_works many-to-many relationshipo.

=cut

__PACKAGE__->has_many(
  "work_references_referencing_works",
  "PAPS::Database::papsdb::Schema::Result::WorkReference",
  { "foreign.referenced_work_id" => "self.work_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 work_references_referenced_works

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkReference>
As with the work_references_referencing_works has_many relationship, this
relationship is being redefined because DBIx has the reverse naming convention
compared to how it should be, in this case.  What this Work considers a
referenced Work is what, from the perspective of the reference itself, has
this Work as the referencing Work.

=cut

__PACKAGE__->has_many(
  "work_references_referenced_works",
  "PAPS::Database::papsdb::Schema::Result::WorkReference",
  { "foreign.referencing_work_id" => "self.work_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# many_to_many():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of has_many() relationship this many_to_many() is shortcut for
#     3) Name of belongs_to() relationship in model class of has_many() above
#   You must already have the has_many() defined to use a many_to_many().
__PACKAGE__->many_to_many(authors => 'work_authors', 'person',
                          {
                              '+select' => [ 'me.author_position, me.author_name_text',
                                             'me.author_affiliation_text' ],
                              '+as' => [ 'author_position', 'author_name_text',
                                         'author_affiliation_text' ],
                          });


=head2 sources

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Source>

=cut

__PACKAGE__->many_to_many(sources => 'work_sources', 'source',
                          {
                              '+select' => 'me.url',
                              '+as' => 'url',
                          });

=head2 referenced_works

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->many_to_many(referenced_works => 'work_references_referenced_works',
                          'referenced_work',
                          {
                              '+select' => [ 'me.reference_type_id', 'me.rank',
                                             'me.chapter', 'me.reference_text' ],
                              '+as' => [ 'reference_type_id', 'rank',
                                         'chapter', 'reference_text' ],
                          });

=head2 referencing_works

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->many_to_many(referencing_works => 'work_references_referencing_works',
                          'referencing_work',
                          {
                              '+select' => [ 'me.reference_type_id', 'me.rank',
                                             'me.chapter', 'me.reference_text' ],
                              '+as' => [ 'reference_type_id', 'rank',
                                         'chapter', 'reference_text' ],
                          });

=head2 source_tags

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceTag>

=cut

__PACKAGE__->many_to_many(source_tags => 'source_work_tags',
                          'tag',
                          { });

=head2 tags

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkTag>

=cut

__PACKAGE__->many_to_many(tags => 'work_tags',
                          'tag',
                          { });

=head2 source_categories

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceCategory>

=cut

__PACKAGE__->many_to_many(source_categories => 'source_work_categories',
                          'category',
                          {
                              '+select' => [ 'me.rank' ],
                              '+as' => [ 'category_rank' ]
                          });

=head2 categories

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Category>

=cut

__PACKAGE__->many_to_many(categories => 'work_categories',
                          'category',
                          { });

=head2 source_meta_keys

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceWorkMetaKey>

=cut

__PACKAGE__->many_to_many(source_meta_keys => 'source_work_metas',
                          'key',
                          {
                              '+select' => [ 'me.rank', 'me.value' ],
                              '+as' => [ 'rank', 'value' ],
                          });


=head2 meta_keys

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkMetaKey>

=cut

__PACKAGE__->many_to_many(meta_keys => 'work_metas',
                          'key',
                          {
                              '+select' => [ 'me.rank', 'me.value' ],
                              '+as' => [ 'rank', 'value' ],
                          });

=head2 collections

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Collection>

=cut

__PACKAGE__->many_to_many(collections => 'collection_works',
                          "collection",
                          {
                              '+select' => [ 'me.added_timestamp', 'me.notes' ],
                              '+as' => ['added_timestamp', 'notes' ],
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
