package Mail::Krohn;
use strict;
use warnings;
use 5.008005;
our $VERSION = '0.01';

our $DRIVER = "Mail::Krohn::Sendmail";

sub new {
    my $class = shift;
    $DRIVER->new(@_);
}

1;
__END__

=encoding utf8

=head1 NAME

Mail::Krohn - Yet another mail sender

=head1 SYNOPSIS

    use Mail::Krohn;

    local $Mail::Krohn::DRIVER = "Mail::Krohn::Sendmail";
    my $mailer = Mail::Krohn->new();
    $mailer->send($mime, '-f', 'foo@example.com');

=head1 DESCRIPTION

Mail::Krohn is yet another mail sender class for Perl5.

You can use this module with L<Email::MIME>.

=head1 MOTIVATION

L<Email::Sender> is great. But, sometimes when I do not want to use the Moose.

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom AAJKLFJEF@ GMAIL COME<gt>

=head1 SEE ALSO

Mail::Krohn uses L<Email::MIME> as message object.

L<Email::Send> is simple mail sender class, but deprecated.  

L<Email::Sender> is mail sender class, using Moose. Sometimes when I do not want to use the Moose.

=head1 LICENSE

Copyright (C) Tokuhiro Matsuno

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
