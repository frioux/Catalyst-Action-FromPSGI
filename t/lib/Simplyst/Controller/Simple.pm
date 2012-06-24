package Simplyst::Controller::Simple;

use base 'Catalyst::Controller';

sub from_plack :Path('/foo') :ActionClass('FromPlack') {
   A::App->to_psgi_app
}

sub from_plack2 :Path('/bar') :ActionClass('FromPlack') {
   A::App2->to_psgi_app
}

sub from_plack3 :Path('/msg') :ActionClass('FromPlack') {
   A::App3->new(msg => 'yolo')->to_psgi_app
}

1;

BEGIN {
package A::App;

use Web::Simple;

sub dispatch_request {
  sub (/foo/...) {
     sub (/) { [ 200, [ 'Content-type' => 'text/plain' ], [ 'Hello world' ] ] },
     sub (/foo) { [ 200, [ 'Content-type' => 'text/plain' ], [ 'Hello foo' ] ] },
  }
}

}

BEGIN {
package A::App2;

use Web::Simple;

sub dispatch_request {
  sub (/bar/...) {
     sub (/) { [ 200, [ 'Content-type' => 'text/plain' ], [ 'Hello world, from bar' ] ] },
     sub (/foo) { [ 200, [ 'Content-type' => 'text/plain' ], [ 'Hello foo, from bar' ] ] },
  }
}

}

BEGIN {
package A::App3;

use Web::Simple;

has msg => (
   is => 'ro',
   required => 1,
);

sub dispatch_request {
  sub (/msg/...) {
     sub (/) { [ 200, [ 'Content-type' => 'text/plain' ], [ $_[0]->msg ] ] },
  }
}

}
