package Earl::TimeSeries;
use Moo;
use Types::Standard qw( Str HashRef Num );
has name => (
    is => 'ro',
    isa => Str,
    required => 1,
);
has _data => (
    is => 'ro',
    isa => HashRef[Num],
    required => 1,
    init_arg => 'data',
);
sub data {
    my ( $self, $date ) = @_;
    return $self->_data->{ $date };
}
1;
