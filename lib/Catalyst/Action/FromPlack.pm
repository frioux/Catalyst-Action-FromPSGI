package Catalyst::Action::FromPlack;

use base 'Catalyst::Action';
use HTTP::Message::PSGI qw(res_from_psgi);
use Plack::App::URLMap;

sub execute {
   my ($self, $controller, $c, @rest) = @_;

   my $app = $self->code->();
   my $nest = Plack::App::URLMap->new;
   $nest->map( $self->attributes->{Path}->[0] => $app);
   my $res = res_from_psgi($nest->($c->req->env));
   $c->res->status($res->code);
   $c->res->body($res->content);
   $c->res->headers($res->headers);
   return;
}

1;
