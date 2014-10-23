use Moops;

class Jester::Source::DBI with Jester::Source {
    use Jester::TimeSeries;

    has dsn => (
        is => 'ro',
        required => 1,
    );
    has db_user => (
        is => 'ro',
        required => 1,
    );
    has db_pass => (
        is => 'ro',
    );
    has _dbh => (
        is => 'ro',
        lazy => 1,
        default => sub {
            my ( $self ) = @_;
            return DBI->connect( $self->{dsn}, $self->{db_user}, $self->{db_pass} );
        },
    );
    method read_data( Str $name ) {
        my $data = $self->_dbh->selectall_hashref(
            'SELECT date,value FROM time_series WHERE name=?',
            'date', # the field used for keys
            {},
            [ $name ]
        );

        return Jester::TimeSeries->new(
            name => $name,
            data => $data,
        );
    }
}
