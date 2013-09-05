#!/usr/bin/perl

use YAML::Tiny;

$yaml = YAML::Tiny->read( 'config.yml' );


my $databaseserver = $yaml->[0]->{database}->{server};
my $databaseport = $yaml->[0]->{database}->{port};
my $databasename = $yaml->[0]->{database}->{database};
my $databaseuser = $yaml->[0]->{database}->{username};
my $databasepassword = $yaml->[0]->{database}->{password};


print "Content-type: text/html\n\n";
print "Your Database Server: $databaseserver\n";
print "Your Database Port: $databaseport\n";
print "Your Database Name: $databasename\n";
print "Your Database Username: $databaseuser\n";
print "Your Database Password: $databasepassword\n";
