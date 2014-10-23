package Duke::Xform;
use Duke::TimeSeries;
sub new {
    my ( $class, %args ) = @_;
    return bless \%args, $class;
}
sub xform_data {
    my ( $self, $in_data ) = @_;
    my %out_data;
    # ...
    return Duke::TimeSeries->new(
        name => $in_data->name,
        data => \%out_data,
    );
}
1;
