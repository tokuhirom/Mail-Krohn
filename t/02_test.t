use strict;
use warnings;
use utf8;
use Test::More;
use Mail::Krohn;
use Mail::Krohn::Test;
use Email::MIME;

{
    my $mime = Email::MIME->create(
        header_str => [
            To   => 'yappo@example.com',
            From => 'dankogai@example.com',
        ],
        attributes => {
            content_type => "text/plain",
            disposition  => "attachment",
            charset      => "US-ASCII",
            encoding     => "quoted-printable",
        },
        body_str => "Yahho!",
    );

    local $Mail::Krohn::DRIVER = 'Mail::Krohn::Test';
    my $mailer = Mail::Krohn->new();
    ok($mailer->send($mime)) or diag $mailer->errstr;
    my @mails = Mail::Krohn::Test->emails();
    is(0+@mails, 1);
    is($mails[0]->header('From'), 'dankogai@example.com');
}

done_testing;

