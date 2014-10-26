package Duke::Source::DBI;
use parent 'Duke::Source';
sub new {
    my ( $class, %args ) = @_;
    die "dsn is required" unless $args{dsn};
    die "db_user is required" unless $args{db_user};
    die "db_pass is required" unless $args{db_pass};
    my $self = $class->SUPER::new( %args );
    return $self;
}
sub read_data {
    my ( $self, $name ) = @_;

    if ( !$self->{_dbh} ) { # Lazy attribute
        $self->{_dbh} = DBI->connect( $self->{dsn}, $self->{db_user}, $self->{db_pass} );
    }

    my $data = $self->{_dbh}->selectall_hashref(
        'SELECT date,value FROM time_series WHERE name=?',
        'date', # the field used for keys
        {},
        [ $name ]
    );

    return Duke::TimeSeries->new(
        name => $name,
        data => $data,
    );
}
1;
