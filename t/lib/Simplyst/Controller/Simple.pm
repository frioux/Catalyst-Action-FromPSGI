package Simplyst::Controller::Simple;

use base 'Catalyst::Controller';

sub from_plack :Path('/') :ActionClass('FromPlack') {
   A::App->to_psgi_app
}

1;

BEGIN {
package A::App;

use Web::Simple;

sub dispatch_request {
  sub (/) { [ 200, [ 'Content-type' => 'text/plain' ], [ 'Hello world' ] ] },
  sub (/foo) { [ 200, [ 'Content-type' => 'text/plain' ], [ 'Hello foo' ] ] },
}

}
