package PAPS::Database::papsdb::Schema::Result::Category;

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

PAPS::Database::papsdb::Schema::Result::Category

=cut

__PACKAGE__->table("categories");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'categories_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 description

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 parent_category_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "categories_id_seq",
  },
  "name",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "description",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "parent_category_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("unique__categories__name", ["name"]);

=head1 RELATIONS

=head2 parent_category

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Category>

=cut

__PACKAGE__->belongs_to(
  "parent_category",
  "PAPS::Database::papsdb::Schema::Result::Category",
  { id => "parent_category_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 categories

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Category>

=cut

__PACKAGE__->has_many(
  "categories",
  "PAPS::Database::papsdb::Schema::Result::Category",
  { "foreign.parent_category_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 category_mappings

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::CategoryMapping>

=cut

__PACKAGE__->has_many(
  "category_mappings",
  "PAPS::Database::papsdb::Schema::Result::CategoryMapping",
  { "foreign.category_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 work_categories

Type: has_many

Related object: L<PAPS::Database::papsdb::Schema::Result::WorkCategory>

=cut

__PACKAGE__->has_many(
  "work_categories",
  "PAPS::Database::papsdb::Schema::Result::WorkCategory",
  { "foreign.category_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-07-24 16:54:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:I2AiyUXWIgPYSRlcRWjENw


# You can replace this text with custom content, and it will be preserved on regeneration

=head2 works

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->many_to_many(works => 'work_categories',
                          'work',
                          { });

=head2 mapped_source_categories

Type: many_to_many

Related object: L<PAPS::Database::papsdb::Schema::Result::SourceCategory>

=cut

__PACKAGE__->many_to_many(mapped_source_categories => 'category_mappings',
                          'source_category',
                          { });

__PACKAGE__->meta->make_immutable;
1;
