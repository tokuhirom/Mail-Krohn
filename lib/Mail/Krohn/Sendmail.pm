package Mail::Krohn::Sendmail;
use strict;
use warnings;
use utf8;
use parent qw/Mail::Krohn::Base/;
use Symbol qw(gensym);
use File::Spec ();

our $SENDMAIL;

sub _find_sendmail {
    my $class = shift;
    return $SENDMAIL if defined $SENDMAIL;

    my $sendmail;
    for my $dir (
        File::Spec->path,
        (
            $ENV{PERL_MAIL_KROHN_SENDMAIL_NO_EXTRA_PATHS}
            ? ()
            : ( File::Spec->catfile( '', qw(usr sbin) ), File::Spec->catfile( '', qw(usr lib) ), )
        )
      )
    {
        if ( -x "$dir/sendmail" ) {
            $sendmail = "$dir/sendmail";
            last;
        }
    }

    return $sendmail;
}
 
sub send {
    my ($self, $message, @args) = @_;
    my $sendmail = $self->_find_sendmail;
 
    return $self->error(
        "Couldn't find 'sendmail' executable in your PATH" . " and \$" . __PACKAGE__ . "::SENDMAIL is not set" ) unless $sendmail;
 
    return $self->error("Found $sendmail but cannot execute it")
        unless -x $sendmail;
     
    local $SIG{'CHLD'} = 'DEFAULT';
 
    my $pipe = gensym;
 
    ## no critic.
    open $pipe, "| $sendmail -t -oi @args"
        or return $self->error("Error executing $sendmail: $!");
    print $pipe $message->as_string
        or return $self->error("Error printing via pipe to $sendmail: $!");
    close $pipe
        or return $self->error("error when closing pipe to $sendmail: $!");
    return 1;
}

1;
__END__

=head1 NAME

Mail::Krohn::Sendmail - sendmail

=head1 SYNOPSIS

    my $mime = Email::MIME->create(
        header => [
            From => '#####@####.###',
            To   => '#####@####.###',
            Subject => Encode::encode( 'MIME-Header-ISO_2022_JP', 'こんにちは' ),
            'X-Mailer' => 'TestMailer',
        ],
        attributes => {
            content_type => 'text/plain',
            charset      => 'iso-2022-jp',　　# (1)
            encoding     => '7bit',
        },
        parts => [
                Encode::encode( 'iso-2022-jp', 'こんにちは、さようなら' ),
        ],
    );

    my $mailer = Mail::Krohn::Sendmail->new();
    $mailer->send($mime);

=head1 DESCRIPTION

You can use mail by B<sendmail(1)> with this module.

This module finds semdmail from $ENV{PATH}. If you want to specify the library path, Please set C<< $Mail::Krohn::Sendmail::SENDMAIL >>

=head1 THANKS TO

Most of the code was taken from L<Email::Send::Sendmail>, thanks RJBS.

