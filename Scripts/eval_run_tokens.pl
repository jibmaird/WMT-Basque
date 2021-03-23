#!/usr/bin/perl -w

use strict;

use vars qw ();

#Normalize both candidate and annotated terminology (lower case and substitute hyphens by space).
#Do a comparison between each candidate and the manual annotation (this is just a simple if equals to)
#Compute the total number of correct matches and divide by the number of candidates
#We did not perform any kind on normalization regarding the number of words or lengths. It was a plain accuracy measure.

my $pred_f = $ARGV[0];
my $gold_f = $ARGV[1];

open(I,"$pred_f")||die "$pred_f\n";
open(G,"$gold_f")||die;
my $tot = 0;
my $i = 0;
while(<I>) {
    chomp;
    my $p = lc($_);
    my $g = <G>;
    chomp($g);
    $g = lc($g);

    my @G = split(/ /,$g);
    my @P = split(/ /,$p);

    my $ok = 0;
    for(my $j=0;$j<=$#G;$j++) {
	if ((defined $P[$j])&&
	    ($G[$j] eq $P[$j])) {
	    $ok++;
	}
    }
    $tot += $ok / ($#G + 1);
    $i++;
}
close(I);
close(G);

#print "OK: $ok\n";
#print "KO: $ko\n";
$_ = $tot / $i;
printf("ACC: %1.2f\n",$_);
