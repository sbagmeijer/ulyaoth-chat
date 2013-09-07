#!/usr/bin/perl


use strict;
use warnings;
use CGI();
use CGI::Session();
use CGI::Session::Driver::mysql;
use DBI;
use DBD::mysql;
use YAML::Tiny;


my $yaml = YAML::Tiny->read( '/opt/ulyaothchat/configuration/config.yml' );

my $db_driver = $yaml->[0]->{database}->{driver};
my $db_host = $yaml->[0]->{database}->{host};
my $db_port = $yaml->[0]->{database}->{port};
my $db_name = $yaml->[0]->{database}->{database};
my $db_user = $yaml->[0]->{database}->{username};
my $db_pass = $yaml->[0]->{database}->{password};

my $dbh = DBI->connect("DBI:$db_driver:host=$db_host:$db_port;database=$db_name",$db_user,$db_pass)
    or die "Unable to connect to database: \"$DBI::errstr\" $! \n";

my ($ulyaothid);
{
   my $ulyaoth = CGI::Session->new( 'driver:mysql', undef, { Handle => $dbh } ) or die "Unable to create session because: $!";
   $ulyaoth->expire('3s');
   $ulyaoth->param(-name=>'NICKNAME', -value=>'Etherus');
   $ulyaoth->flush;
   $ulyaothid = $ulyaoth->id;

   print "set exire to 3 seconds\n";
   print "Your Nickname is set to: = ", $ulyaoth->param('NICKNAME'), "\n";
}

for my $loop ( 1 .. 4 ) {
  sleep 1;
  my $ulyaothchat = CGI::Session->load( 'driver:mysql', $ulyaothid, { Handle => $dbh } ) or die "Unable to create session because: $!";
  print "one second later $ulyaothchat / $ulyaothid load\n";
}

for my $loop ( 1 .. 4 ) {
  sleep 2;
  my $ulyaothchat = CGI::Session->load( 'driver:mysql', $ulyaothid, { Handle => $dbh } ) or die "Unable to create session because: $!";
  print "two seconds later ";
  if ( $ulyaothchat->is_expired ) {
    print "$ulyaothchat / $ulyaothid is_expired\n";
  } else {
    print "Your Nickname = ", $ulyaothchat->param('NICKNAME'), "\n";
  }
}

{
  sleep 3;
  my $ulyaothchat = CGI::Session->load( 'driver:mysql', $ulyaothid, { Handle => $dbh } ) or die "Unable to create session because: $!";
  print "three seconds later  ";
  if ( $ulyaothchat->is_expired ) {
    print "$ulyaothchat / $ulyaothid is_expired\n";
  } else {
    print "Your Nickname = ", $ulyaothchat->param('NICKNAME'), "\n";
  }
}
