package Simplyst::Controller::Simple;

use base 'Catalyst::Component::FromPlack';

sub app { A::App->to_psgi_app }

sub register_actions {
  my ($self, $app) = @_;
  $app->dispatcher->register(
    $app, Catalyst::Action->new(
      name => '_DISPATCH',
      namespace => 'simple',
      reverse => 'simple/_DISPATCH',
      class => ref($self),
      code => $self->_DISPATCH($self->app),
      attributes => {
        Path => [ '/' ],
      }
    )
  );
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
