#!/usr/bin/perl


#use strict;
#use warnings;
use CGI();
use CGI::Session();
use CGI::Session::Driver::mysql;
use DBI;
use DBD::mysql;
use YAML::Tiny;
use Digest::SHA2;
use Data::UUID;


my $yaml = YAML::Tiny->read( '/ulyaothchat/configuration/config.yml' );

my $db_driver = $yaml->[0]->{database}->{driver};
my $db_host = $yaml->[0]->{database}->{host};
my $db_port = $yaml->[0]->{database}->{port};
my $db_name = $yaml->[0]->{database}->{database};
my $db_user = $yaml->[0]->{database}->{username};
my $db_pass = $yaml->[0]->{database}->{password};

my $dbh = DBI->connect("DBI:$db_driver:host=$db_host:$db_port;database=$db_name",$db_user,$db_pass)
    or die "Unable to connect to database: \"$DBI::errstr\" $! \n";
    
my $member = "INSERT INTO members(first_name, last_name, email_address, country, city, birthday) VALUES('James', 'bond', 'james@bond.com', 'England', 'London', '1946-12-11')";
my $sth = $dbh->prepare($member) or die "Cannot prepare: " . $dbh->errstr();
$sth->execute() or die "Cannot execute: " . $sth->errstr();
$sth->finish();

my $uniqueid = qq`SELECT uniqueid FROM members WHERE email_address="james@bond.com"`;
my $sth = $dbh->prepare($uniqueid) or die "Cannot prepare: " . $dbh->errstr();
$sth->execute() or die "Cannot execute: " . $sth->errstr();
my $uniqueid = $sth->fetchrow_array();
$sth->finish();

$ug = new Data::UUID;
$ug->create_str();

my $chatid = $ug->create_from_name_str(NameSpace_URL, "$uniqueid");
my $password = "JamesBondIsSoStrong123456";
my $sha2obj = new Digest::SHA2 512;
$sha2obj->add($password, $chatid);
my $digest = $sha2obj->hexdigest();

my $memberdata = "INSERT INTO member_data(chatid, username, password, exempt) VALUES('$chatid', 'Admin', '$digest', 'Administrator')";
my $sth = $dbh->prepare($memberdata) or die "Cannot prepare: " . $dbh->errstr();
$sth->execute() or die "Cannot execute: " . $sth->errstr();
$sth->finish();
