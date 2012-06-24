#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use lib 't/lib';

use Catalyst::Test 'Simplyst';

is( get('/foo/'), 'Hello world', 'successfully loaded psgi in cat controller');
is( get('/foo/foo'), 'Hello foo', 'psgi based dispatching works');

is( get('/bar/'), 'Hello world, from bar', 'successfully loaded psgi in cat controller');
is( get('/bar/foo'), 'Hello foo, from bar', 'psgi based dispatching works');

is( get('/msg/'), 'yolo', 'passing data into plack app works');

done_testing();

