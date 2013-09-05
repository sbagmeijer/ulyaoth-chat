#!/usr/bin/perl


use Mojolicious::Lite;

get '/' => sub {
  my $self = shift;
  $self->stash( file => __FILE__ );
  $self->render('index');
};

app->start;

__DATA__

@@ index.html.ep
% title 'Ulyaoth Chat - Please login';
<!DOCTYPE html>
<html>
  <head>
        <meta charset="utf-8">
        <title><%= title %></title>
        <link rel="stylesheet" type="text/css" href="../css/form.css" />
  </head>
<body>
<div class="container">
        <section id="content">
                <form action="">
                        <h1>Please Login</h1>
                        <div>
                                <input type="text" placeholder="Username" required="" id="username" />
                        </div>
                        <div>
                                <input type="password" placeholder="Password" id="password" />
                        </div>
                        <div>
                                <input type="submit" value="Log in" />
                                <a href="#">Lost your password?</a>
                                <a href="#">Register</a>
                        </div>
                </form>
        </section>
</div>
</body>
</html>
