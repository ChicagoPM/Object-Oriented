package Earl::Destination;
use Moo::Role;
requires 'write_data';
before write_data => sub {
    my ( $self, $data ) = @_;
    die "data must be Earl::TimeSeries"
        unless blessed $data && $data->isa( 'Earl::TimeSeries' );
};
1;
