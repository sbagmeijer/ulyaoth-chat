#!/usr/bin/perl

use Data::UUID;

$ug = new Data::UUID;
$ug->create_str();
print $ug->create_from_name_str(NameSpace_URL, "www.mycompany.com");
