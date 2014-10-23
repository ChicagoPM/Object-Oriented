package Earl::Source::DBI;
use Moo;
use Earl::TimeSeries;
with 'Earl::Source';
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
sub read_data {
    my ( $self, $name ) = @_;

    my $data = $self->_dbh->selectall_hashref(
        'SELECT date,value FROM time_series WHERE name=?',
        'date', # the field used for keys
        {},
        [ $name ]
    );

    return Earl::TimeSeries->new(
        name => $name,
        data => $data,
    );
}
1;
