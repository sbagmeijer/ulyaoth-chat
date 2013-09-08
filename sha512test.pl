#!/usr/bin/perl

use strict;
use warnings;
use Digest::SHA2;

my $memberid = "BUGDsyuadsguadsbhj";
my $password = "ulyaothchatpasswordtest";
my $sha2obj = new Digest::SHA2 512;

$sha2obj->add($password, $memberid);
my $digest = $sha2obj->hexdigest();
print "Hasing Password and Unique member id:\n";
print "$digest\n\n";
