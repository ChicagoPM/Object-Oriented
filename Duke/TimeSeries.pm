package Duke::TimeSeries;
sub new {
    my ( $class, %args ) = @_;
    return bless {
        name => $args{name},    # Descriptive name
        data => $args{data},    # Hashref of date => value pairs
    }, $class;
}
sub name {
    my ( $self ) = @_; # read only
    return $self->{name};
}
sub data {
    my ( $self, $date ) = @_; # read only
    return $self->{data}{$date};
}
1;
