use strict;
use Test::More;

use_ok $_ for qw(
    Mail::Krohn
    Mail::Krohn::Base
    Mail::Krohn::Sendmail
    Mail::Krohn::Test
);

diag "SENDMAIL : " . (eval { Mail::Krohn->_find_sendmail() } || '-');

done_testing;
