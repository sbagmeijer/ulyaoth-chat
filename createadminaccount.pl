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


my $yaml = YAML::Tiny->read( 'config.yml' );

my $db_driver = $yaml->[0]->{database}->{driver};
my $db_host = $yaml->[0]->{database}->{host};
my $db_port = $yaml->[0]->{database}->{port};
my $db_name = $yaml->[0]->{database}->{database};
my $db_user = $yaml->[0]->{database}->{username};
my $db_pass = $yaml->[0]->{database}->{password};

my $dbh = DBI->connect("DBI:$db_driver:host=$db_host:$db_port;database=$db_name",$db_user,$db_pass)
    or die "Unable to connect to database: \"$DBI::errstr\" $! \n";
    
my $formdata = "jamesbond\@live.com";

my $sth = $dbh->prepare( 'SELECT email_address FROM members WHERE email_address = "jamesbond@live.com" ') or die "Couldn't prepare statement: " . $dbh->errstr;
my @row = $dbh->selectrow_array( $sth,{} );
if( @row ) {
print "Sorry your this email address is already in use.";
$sth->finish();
}else{
my $member = "INSERT INTO members(first_name, last_name, email_address, country, city, birthday) VALUES('James', 'Bond', 'jamesbond\@live.com', 'United Kingdom', 'London', '1963-9-14')";
$sth = $dbh->prepare($member) or die "Cannot prepare: " . $dbh->errstr();
$sth->execute() or die "Cannot execute: " . $sth->errstr();
$sth->finish();

$sth = $dbh->prepare( 'SELECT user_id FROM members WHERE email_address = "jamesbond@live.com" ') or die "Couldn't prepare statement: " . $dbh->errstr;
$sth->execute() or die "Cannot execute: " . $sth->errstr();
my $user_id = $sth->fetchrow_array();
$sth->finish();

my $ug = new Data::UUID;
$ug->create_str();

my $member_id = $ug->create_from_name_str(NameSpace_URL, "$user_id");
my $unhashedpassword = "JamesBondIsCool007";
my $sha2obj = new Digest::SHA2 512;
$sha2obj->add($unhashedpassword, $member_id);
my $hashedpassword = $sha2obj->hexdigest();

my $memberdata = "INSERT INTO member_data(user_id, member_id, username, password, exempt) VALUES('$user_id', '$member_id', 'Admin, '$hashedpassword', 'Administrator')";
$sth = $dbh->prepare($memberdata) or die "Cannot prepare: " . $dbh->errstr();
$sth->execute() or die "Cannot execute: " . $sth->errstr();
$sth->finish();

}
