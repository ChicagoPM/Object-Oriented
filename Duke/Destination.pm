package Duke::Destination;
sub new {
    my ( $class, %args ) = @_;
    return bless \%args, $class;
}
sub write_data {
    my ( $self, $time_series ) = @_;
    # ...
    return;
}
1;
