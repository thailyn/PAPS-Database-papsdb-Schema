use strict;
use warnings;

use DBIx::Class::Schema::Loader qw/ make_schema_at /;

make_schema_at(
    'PAPS::Database::papsdb::Schema',
    { debug => 1,
      dump_directory => './lib',
      naming => 'v7',
      components => [ 'InflateColumn::DateTime', 'TimeStamp', 'EncodedColumn', ],
      use_moose => 1,
    },
    [ 'dbi:Pg:dbname="papsdb"', 'papsuser', '',
       { },
    ],
);
