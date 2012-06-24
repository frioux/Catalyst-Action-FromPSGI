package Catalyst::Action::FromPlack;

use base 'Catalyst::Action';
use HTTP::Message::PSGI qw(res_from_psgi);
use Plack::App::URLMap;

sub nest_app {
   my ($self, $c, $app) = @_;

   my $nest = Plack::App::URLMap->new;

   my $path = '/' . $c->request->path;
   my $rest = join '/', @{$c->request->arguments};
   $path =~ s/\Q$rest\E$//;
   $nest->map( $path => $app );

   return $nest
}

sub execute {
   my ($self, $controller, $c, @rest) = @_;

   my $app = $self->code->($controller, $c, @rest);
   my $nest = $self->nest_app($c, $app);
   my $res = res_from_psgi($nest->($c->req->env));

   $c->res->status($res->code);
   $c->res->body($res->content);
   $c->res->headers($res->headers);
   return;
}

1;
