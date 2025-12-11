#!/usr/bin/env perl

use strict;
use Test::More;

printf "\n%s\n", "Make sure CA certificate stores are older than their SPKI hashes \"~/etc/ca_hashes.txt\" ...";

my $newer_bundles=`find etc/*.pem -newer etc/ca_hashes.txt`;

#1
is($newer_bundles,"","Checking if there's an output with a *.pem file. If so: run \"~/utils/create_ca_hashes.sh\"");

printf "\n";
done_testing;


#  vim:ts=5:sw=5:expandtab

