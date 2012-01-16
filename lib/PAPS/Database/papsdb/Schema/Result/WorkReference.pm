use utf8;
package PAPS::Database::papsdb::Schema::Result::WorkReference;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PAPS::Database::papsdb::Schema::Result::WorkReference

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

=head1 TABLE: C<work_references>

=cut

__PACKAGE__->table("work_references");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'work_references_id_seq'

=head2 referencing_work_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 referenced_work_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 reference_type_id

  data_type: 'smallint'
  is_foreign_key: 1
  is_nullable: 0

=head2 rank

  data_type: 'smallint'
  is_nullable: 0

=head2 chapter

  data_type: 'smallint'
  is_nullable: 1

=head2 reference_text

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "work_references_id_seq",
  },
  "referencing_work_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "referenced_work_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "reference_type_id",
  { data_type => "smallint", is_foreign_key => 1, is_nullable => 0 },
  "rank",
  { data_type => "smallint", is_nullable => 0 },
  "chapter",
  { data_type => "smallint", is_nullable => 1 },
  "reference_text",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<unique__work_references__referenced_referencing_type>

=over 4

=item * L</referencing_work_id>

=item * L</referenced_work_id>

=item * L</reference_type_id>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "unique__work_references__referenced_referencing_type",
  [
    "referencing_work_id",
    "referenced_work_id",
    "reference_type_id",
  ],
);

=head1 RELATIONS

=head2 reference_type

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::ReferenceType>

=cut

__PACKAGE__->belongs_to(
  "reference_type",
  "PAPS::Database::papsdb::Schema::Result::ReferenceType",
  { id => "reference_type_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 referenced_work

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->belongs_to(
  "referenced_work",
  "PAPS::Database::papsdb::Schema::Result::Work",
  { work_id => "referenced_work_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 referencing_work

Type: belongs_to

Related object: L<PAPS::Database::papsdb::Schema::Result::Work>

=cut

__PACKAGE__->belongs_to(
  "referencing_work",
  "PAPS::Database::papsdb::Schema::Result::Work",
  { work_id => "referencing_work_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07015 @ 2012-01-15 22:01:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:U8Vl7XxWwVvoFlg+4eeqrQ

=head1 Helper Methods

=head2 display_name

Returns a formatted version of this object suitable for display.

=cut

sub display_name {
    my ($self) = @_;

    my $referenced_text;
    if ($self->referenced_work_id) {
        $referenced_text = $self->referenced_work_id;
    }
    elsif ($self->reference_text) {
        if (length $self->reference_text > 33) {
            $referenced_text = substr($self->reference_text, 0, 30) . '...';
        }
        else {
            $referenced_text = $self->reference_text;
        }
    }
    else {
        $referenced_text = "Unknown";
    }

    return $self->referencing_work->display_name . " (Referencing) - " . $referenced_text . " (Referenced)";
}

# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
