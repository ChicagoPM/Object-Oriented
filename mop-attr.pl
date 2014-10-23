
use feature qw( say );
use Earl;
for my $attr ( Earl->meta->get_all_attributes ) {
    say $attr->name;
}
Earl->meta->add_attribute( 'foo', is => 'ro' );
my $earl = Earl->new(
);
say $earl->foo;
