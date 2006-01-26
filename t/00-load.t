#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'POE::Session::Attributes' );
}

diag( "Testing POE::Session::Attributes $POE::Session::Attributes::VERSION, Perl $], $^X" );
