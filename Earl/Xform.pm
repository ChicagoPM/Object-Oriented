package Earl::Xform;
use Moo::Role;
# use Type::Params qw( validate ); ### Future!
requires 'xform_data';
around xform_data => sub {
    my ( $orig, $self, $in_data ) = @_;
    die "input data must be Earl::TimeSeries"
        unless blessed $in_data && $in_data->isa( 'Earl::TimeSeries' );
    my $out_data = $self->$orig( $in_data );
    die "output data must be Earl::TimeSeries"
        unless blessed $out_data && $out_data->isa( 'Earl::TimeSeries' );
    return $out_data;
};
1;
