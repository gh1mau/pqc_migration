#!/usr/bin/env perl

# Check revoked.badssl.com whether certificate is revoked
# and cloudflare whether is is not
# Maybe amended
#
# We don't use a full run, only the certificate section.

use strict;
use Test::More;
use Data::Dumper;
use Text::Diff;

my $tests = 0;
my $prg="./testssl.sh";
my $csv="tmp.csv";
my $cat_csv="";
my $check2run="-q -S --color 0 --phone-out --ip=one --severity CRITICAL --csvfile $csv";
my $uri="revoked.badssl.com";
my @args="";

die "Unable to open $prg" unless -f $prg;

# Provide proper start conditions
unlink $csv;

#1 run
printf "\n%s\n", "Unit test for certificate revocation against \"$uri\"";
@args="$prg $check2run $uri >/dev/null";
system("@args") == 0
     or die ("FAILED: \"@args\" ");
$cat_csv=`cat $csv`;

# Is the certificate revoked? (formerly: OCSP, now: CRL)
like($cat_csv, qr/"cert_crlRevoked".*"CRITICAL","revoked"/,"The certificate should be revoked");
$tests++;
unlink $csv;

$uri="cloudflare.com";
@args="$prg $check2run $uri >/dev/null";
system("@args") == 0
     or die ("FAILED: \"@args\" ");
$cat_csv=`cat $csv`;

# this should not be revoked --> no such line
unlike($cat_csv, qr/cert_ocspRevoked/,"There should be no certificate revocation entry");
$tests++;
unlink $csv;

done_testing($tests);
printf "\n";


# vim:ts=5:sw=5:expandtab

