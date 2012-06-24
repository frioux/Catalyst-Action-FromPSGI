package Simplyst::Controller::Simple;

use Web::Simple;

sub dispatch_request {
  sub (/) { [ 200, [ 'Content-type' => 'text/plain' ], [ 'Hello world' ] ] }
}

use HTTP::Response;
use HTTP::Message::PSGI qw(res_from_psgi);

sub _DISPATCH {
  my ($self, $c) = @_;
  my $res = res_from_psgi($self->to_psgi_app->($c->req->env));
  $c->res->status($res->code);
  $c->res->body($res->content);
  $c->res->headers($res->headers);
  return;
}

sub COMPONENT { shift->new }

sub register_actions {
  my ($self, $app) = @_;
  $app->dispatcher->register(
    $app, Catalyst::Action->new(
      name => '_DISPATCH',
      namespace => 'simple',
      reverse => 'simple/_DISPATCH',
      class => ref($self),
      code => $self->can('_DISPATCH'),
      attributes => {
        Path => [ '/' ],
      }
    )
  );
}

__PACKAGE__->run_if_script;
