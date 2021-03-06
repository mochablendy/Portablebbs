use FindBin;
use lib "$FindBin::Bin/../lib";
use lib "$FindBin::Bin/../extlib/lib/perl5";

use Mojo::Base -strict;
use Test::More 'no_plan';
use Test::Mojo;

$ENV{PORTABLEBBE_DBNAME} = 'portablebbs_test';

use_ok 'Portablebbs';
my $t = Test::Mojo->new('Portablebbs');

# Install
$t->get_ok('/install');
$t->post_form_ok('/bbs/init');

# Create entry
$t->post_form_ok('/entry/create', {title => 'foo', message => 'bar'});
$t->get_ok('/')->content_like(qr/foo/)->content_like(qr/bar/);

