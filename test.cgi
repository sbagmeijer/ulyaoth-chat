#!/usr/bin/perl

use strict;
use warnings;
use CGI;

print foreach (
    "Content-Type: text/plain\n\n",
    "Versions:\n=================\n",
    "perl: $]\n",
    "CGI: $CGI::VERSION\n"
);

my $q = CGI::Vars();
print "\nCGI Values:\n=================\n";
foreach my $k ( sort keys %$q ) {
    print "$k [$q->{$k}]\n";
}

print "\nEnvironment Variables:\n=================\n";
foreach my $k ( sort keys %ENV ) {
    print "$k [$ENV{$k}]\n";
}
