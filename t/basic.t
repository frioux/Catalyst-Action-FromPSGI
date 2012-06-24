#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use lib 't/lib';

use Catalyst::Test 'Simplyst';

is( get('/'), 'Hello world', 'successfully loaded psgi in cat controller');

done_testing();

