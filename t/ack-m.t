#!perl

use strict;
use warnings;

use Test::More tests => 4;

use lib 't';
use Util;

prep_environment();

my @text  = glob( 't/text/s*.txt' );
my $myth  = File::Next::reslash( 't/text/science-of-myth.txt' );
my $happy = File::Next::reslash( 't/text/shut-up-be-happy.txt' );

my @expected = split( /\n/, <<"EOF" );
$myth:3:In the case of Christianity and Judaism there exists the belief
$myth:6:The Buddhists believe that the functional aspects override the myth
$myth:7:While other religions use the literal core to build foundations with
$happy:10:Anyone caught outside the gates of their subdivision sector after curfew will be shot.
$happy:12:Your neighborhood watch officer will be by to collect urine samples in the morning.
$happy:13:Anyone gaught intefering with the collection of urine samples will be shot.
EOF

ack_lists_match( [ '-m', 3, '-w', 'the', @text ], \@expected );

@expected = split( /\n/, <<"EOF" );
$myth:3:In the case of Christianity and Judaism there exists the belief
EOF

ack_lists_match( [ '-1', '-w', 'the', @text ], \@expected, 'We should only get one line back for the entire run, not just per file.' );