
use Moops;
class Jester {
    has src => (
        is => 'ro',
        required => 1,
        isa => ConsumerOf['Jester::Source'],
    );
    has dest => (
        is => 'rw',
        required => 1,
        isa => ConsumerOf['Jester::Destination'],
    );
    has xform => (
        is => 'ro',
        default => sub { [] },
        isa => ArrayRef[ ConsumerOf['Jester::Xform'] ],
    );
    method add_xform ( Object $new_xform ) {
        push @{ $self->{xform} }, $new_xform;
        return;
    }
    method run ( Str $name ) {
        my $data = $self->src->read_data( $name );
        for my $xform ( @{ $self->xform } ) {
            $data = $xform->xform_data( $data );
        }
        $self->dest->write_data( $data );
        return;
    }
}
