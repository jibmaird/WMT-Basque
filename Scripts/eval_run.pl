#!/usr/bin/perl -w

use strict;

use vars qw ();

#Normalize both candidate and annotated terminology (lower case and substitute hyphens by space).
#Do a comparison between each candidate and the manual annotation (this is just a simple if equals to)
#Compute the total number of correct matches and divide by the number of candidates
#We did not perform any kind on normalization regarding the number of words or lengths. It was a plain accuracy measure.

my $pred_f = $ARGV[0];
my $gold_f = $ARGV[1];

open(I,"$pred_f")||die;
open(G,"$gold_f")||die;
my $ok = 0;
my $ko = 0;
while(<I>) {
    chomp;
    my $p = lc($_);
    my $g = <G>;
    chomp($g);
    $g = lc($g);
    if ($p eq $g) {
	$ok++;
    }
    else {
	$ko++;
    }
}
close(I);
close(G);

#print "OK: $ok\n";
#print "KO: $ko\n";
$_ = $ok / ($ok + $ko);
printf("ACC: %1.2f\n",$_);
