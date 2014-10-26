package Earl;
use Moo;
use Types::Standard qw( :all );
has src => (
    is => 'ro',
    required => 1,
    isa => ConsumerOf['Earl::Source'],
);
has dest => (
    is => 'rw',
    required => 1,
    isa => ConsumerOf['Earl::Destination'],
);
has xform => (
    is => 'ro',
    default => sub { [] },
    isa => ArrayRef[ ConsumerOf['Earl::Xform'] ],
);
sub add_xform {
    my ( $self, $new_xform ) = @_;
    push @{ $self->{xform} }, $new_xform;
    return;
}
sub run {
    my ( $self, $name ) = @_;
    my $data = $self->src->read_data( $name );
    for my $xform ( @{ $self->xform } ) {
        $data = $xform->xform_data( $data );
    }
    $self->dest->write_data( $data );
    return;
}
1;
