#!/usr/bin/perl


use strict;
use warnings;
use CGI();
use CGI::Session();
use CGI::Session::Driver::mysql;
use DBI;
use DBD::mysql;
use YAML::Tiny;
use Digest::SHA2;
use Data::UUID;


my $emailtest = '';
my $usernametest = '';
my $error = '';

my $yaml = YAML::Tiny->read( '/Library/WebServer/ulyaothchat/configuration/config.yml' );

my $db_driver = $yaml->[0]->{database}->{driver};
my $db_host = $yaml->[0]->{database}->{host};
my $db_port = $yaml->[0]->{database}->{port};
my $db_name = $yaml->[0]->{database}->{database};
my $db_user = $yaml->[0]->{database}->{username};
my $db_pass = $yaml->[0]->{database}->{password};

my $dbh = DBI->connect("DBI:$db_driver:host=$db_host:$db_port;database=$db_name",$db_user,$db_pass)
    or die "Unable to connect to database: \"$DBI::errstr\" $! \n";

my $formdata = "sbagmeijer\@live.com";

my $sth = $dbh->prepare( 'SELECT email_address FROM members WHERE email_address = "sbagmeijer@live.com" ') or die "Couldn't prepare statement: " . $dbh->errstr;
my @row = $dbh->selectrow_array( $sth,{} );
if( @row ) {
$error = "Sorry this email address is already in use.";
$emailtest = 0;
$sth->finish();
}else{
$emailtest = 1;
}

if ($emailtest == 1){
my $sth = $dbh->prepare( 'SELECT username FROM member_data WHERE username = "Etherus" ') or die "Couldn't prepare statement: " . $dbh->errstr;
my @row = $dbh->selectrow_array( $sth, "Etherus" );
if( @row ) {
$error = "Sorry this username is already in use.";
$usernametest = 0;
$sth->finish();
}else{
$usernametest = 1;
}}

EXIT_IF: {
if ($emailtest == 0){
last EXIT_IF;
}elsif ($usernametest == 0){
last EXIT_IF;
}else{
my $member = "INSERT INTO members(first_name, last_name, email_address, country, city, birthday) VALUES('Sjir', 'Bagmeijer', 'sbagmeijer\@live.com', 'Sweden', 'Stockholm', '1984-11-14')";
$sth = $dbh->prepare($member) or die "Cannot prepare: " . $dbh->errstr();
$sth->execute() or die "Cannot execute: " . $sth->errstr();
$sth->finish();

my $sth = $dbh->prepare( 'SELECT user_id FROM members WHERE email_address = "sbagmeijer@live.com" ') or die "Couldn't prepare statement: " . $dbh->errstr;
$sth->execute() or die "Cannot execute: " . $sth->errstr();
my $user_id = $sth->fetchrow_array();
$sth->finish();

my $ug = new Data::UUID;
$ug->create_str();

my $member_id = $ug->create_from_name_str(NameSpace_URL, "$user_id");
my $unhashedpassword = "Rambo123";
my $sha2obj = new Digest::SHA2 512;
$sha2obj->add($unhashedpassword, $member_id);
my $hashedpassword = $sha2obj->hexdigest();

my $memberdata = "INSERT INTO member_data(user_id, member_id, username, password, exempt) VALUES('$user_id', '$member_id', 'Etherus', '$hashedpassword', 'Administrator')";
$sth = $dbh->prepare($memberdata) or die "Cannot prepare: " . $dbh->errstr();
$sth->execute() or die "Cannot execute: " . $sth->errstr();
$sth->finish();
}}

print $error;
