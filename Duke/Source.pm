package Duke::Source;
use Duke::TimeSeries;
sub new {
    my ( $class, %args ) = @_;
    return bless \%args, $class;
}
sub read_data {
    my ( $self, $name ) = @_;
    my %data;
    # ...
    return Duke::TimeSeries->new(
        name => $name,
        data => \%data,
    );
}
1;
