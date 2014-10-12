#!/usr/bin/perl

use strict;
use warnings;
use Digest::SHA3;

my $memberid = "BUGDsyuadsguadsbhj";
my $password = "ulyaothchatpasswordtest";
my $sha3obj = new Digest::SHA3 512;

$sha3obj->add($password, $memberid);
my $digest = $sha3obj->hexdigest();
print "Hasing Password and Unique member id:\n";
print "$digest\n\n";
