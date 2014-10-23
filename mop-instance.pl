
use feature qw( say );
use Earl;
my $earl = Earl->new( );
$earl->meta->add_attribute( 'foo', is => 'rw' );
$earl->foo( "FOO!" );
say $earl->foo;
