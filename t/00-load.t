#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'PAPS::Database::papsdb::Schema' ) || print "Bail out!\n";
}

diag( "Testing PAPS::Database::papsdb::Schema $PAPS::Database::papsdb::Schema::VERSION, Perl $], $^X" );
