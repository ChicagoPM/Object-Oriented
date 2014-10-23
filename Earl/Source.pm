package Earl::Source;
use Moo::Role;
requires 'read_data';
before read_data => sub {
    my ( $self, $name ) = @_;
    die "name is required" unless $name;
};
1;
