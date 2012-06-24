package Catalyst::Action::FromPlack;

use base 'Catalyst::Action';
use HTTP::Message::PSGI qw(res_from_psgi);

sub execute {
   my ($self, $controller, $c, @rest) = @_;
   my $app = $self->code->();
   my $res = res_from_psgi($app->($c->req->env));
   $c->res->status($res->code);
   $c->res->body($res->content);
   $c->res->headers($res->headers);
   return;
}

1;
