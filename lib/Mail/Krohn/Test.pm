package Mail::Krohn::Test;
use strict;
use warnings;
use utf8;
use parent qw/Mail::Krohn::Base/;

our @_MAILS;

sub clear {
    @_MAILS = ()
}

sub emails { @_MAILS }

sub send {
    my ($class, $message, @args) = @_;
    push @_MAILS, $message;
    return 1; # always return true value.
}

1;
__END__

=head1 NAME

Mail::Krohn::Test - Testing driver for Mail::Krohn

=head1 DESCRIPTION

    use Mail::Krohn::Test;

    # clear test data.
    Mail::Krohn::Test->clear();

    # set default driver to Mail::Krohn::Test.
    local $Mail::Krohn::DRIVER = 'Mail::Krohn::Test';

    # just send e-mail.
    my $mailer = Mail::Krohn->new();
    $mailer->send($mime);

    # and check it.
    my @emails = Mail::Krohn::Test->emails();
    is(0+@emails, 1);
    is($emails[0]->subject, 'foo');

=head1 DESCRIPTION

This is a test driver for Mail::Krohn.

=head1 POINTS

=over 4

=item You need to use C<< Mail::Krohn->new >> to use C<< $Mail::Krohn::DRIVER >>.

=back

=head1 METHODS

=over 4

=item Mail::Krohn::Test->clear();

Clear the mailbox in Mail::Krohn::Test.

=item my @mails = Mail::Krohn::Test->emails()

You can get a sent e-mail objects.

=back

=head1 SEE ALSO

L<Mail::Krohn>

