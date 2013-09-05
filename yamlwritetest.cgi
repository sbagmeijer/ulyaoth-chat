#!/usr/bin/perl

use YAML::Tiny;

my $yaml = YAML::Tiny->new;

$yaml = YAML::Tiny->read( 'config.yml' );

$yaml->[1]->{chat} = { this => 'chat', hello => 'sjir'  } ;

$yaml->write( '/config.yml' );
