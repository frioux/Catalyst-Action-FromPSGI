package Catalyst::Component::FromPlack;

use Moose;;
use HTTP::Message::PSGI qw(res_from_psgi);

sub _DISPATCH {
  my ($self, $app) = @_;
  return sub {
    my ($self, $c) = @_;
    my $res = res_from_psgi($app->($c->req->env));
    $c->res->status($res->code);
    $c->res->body($res->content);
    $c->res->headers($res->headers);
    return;
  }
}

1;
