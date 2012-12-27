use strict;
use warnings;
use utf8;
use Test::More;
use Mail::Krohn;
use Mail::Krohn::Sendmail;
use File::Temp;
use Email::MIME;

plan skip_all => 'Missing /usr/bin/perl' unless -x '/usr/bin/perl';

my $tmpfile = File::Temp->new();

my $mail = Email::MIME->create(
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
$ENV{KROHN_TEST_TMPFILE} = $tmpfile->filename;
$Mail::Krohn::Sendmail::SENDMAIL = './xt/bin/sendmail_dummy';
my $mailer = Mail::Krohn->new();
ok($mailer->send($mail)) or diag $mailer->errstr;
my $src = do { local $/; <$tmpfile> };
like $src, qr{dankogai};
note $src;

done_testing;

