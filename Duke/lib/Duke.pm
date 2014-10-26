package Duke;

sub new {
    my ( $class, %args ) = @_;

    die "src is required and must be Duke::Source object"
        unless blessed( $args{src} ) && $args{src}->isa( 'Duke::Source' );
    die "dest is required and must be Duke::Destination object"
        unless blessed( $args{dest} ) && $args{dest}->isa( 'Duke::Destination' );
    if ( $args{xform} ) {
        die "xform must be arrayref of Duke::Xform objects"
            if ref $args{xform} ne 'ARRAY'
                || grep {
                    !blessed( $_ ) || !$_->isa( 'Duke::Xform' )
                } @{ $args{xform} }
                ;
    }

    return bless {
        src   => $args{src},            # Extract
        xform => $args{xform} || [],    # Transform (optional)
        dest  => $args{dest},           # Load
    }, $class;
}
sub src {
    my ( $self ) = @_;
    return $self->{src};
}
sub xform {
    my ( $self ) = @_;
    return $self->{xform};
}
sub dest {
    my ( $self, $new_dest ) = @_;
    if ( $new_dest ) {
        $self->{dest} = $new_dest;
    }
    return $self->{dest};
}
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
