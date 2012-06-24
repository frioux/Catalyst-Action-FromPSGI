#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use lib 't/lib';

use Catalyst::Test 'Simplyst';

is( get('/'), 'Hello world', 'successfully loaded psgi in cat controller');
is( get('/foo'), 'Hello foo', 'psgi based dispatching works');

done_testing();

