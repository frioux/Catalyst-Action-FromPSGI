#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use lib 't/lib';

use Catalyst::Test 'Simplyst';

is( get('/complex/from_plack/foo'), 'Hello local world', 'app under Local works');
is( get('/globule/foo'), 'Hello globule world', 'app under Global works');
is( get('/chain1/frew/middle/frue/end/foo'), 'Hello chain: frew, frue world', 'app under Chain works');

done_testing();

