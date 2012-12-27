package Mail::Krohn::Base;
use strict;
use warnings;
use utf8;

use Class::Accessor::Lite (
    new => 1,
    rw  => [qw/errstr/],
);

sub error {
    my ($self, $msg) = @_;
    $self->errstr($msg);
    return undef;
}


1;

