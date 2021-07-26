#!/usr/bin/perl -w

use strict;
use vars qw ();

my $data_d = "/home/davidm/Projects/WMT-Basque/2021";
my $gold_f = "$data_d/Gold/icd_codes_test_eu_2021.eu";

opendir(D,"$data_d/Participants-terms")||die "$data_d/Participants-terms";
my @Files = grep /\.txt/,readdir D;
closedir(D);

undef my %H;
undef my %B;
foreach my $f (@Files) {
    #$_ = `./eval_run_tokens.pl $data_d/Participants-terms/$f $gold_f`;
    $_ = `./eval_run.pl $data_d/Participants-terms/$f $gold_f`;
    #$_ = `./eval_run_nospace.pl $data_d/Participants-terms/$f $gold_f`;
    chomp;
    m /ACC\: (.*?)$/;
    $H{$f} = $1;

    #bleu
    open(I,"$data_d/Participants-terms/$f")||die;
    open(G,"$gold_f")||die;
    my $i = 0;
    my $bl = 0;
    while(<I>) {
     	chomp;
	my $g = <G>;
	chomp($g);

	$g =~s /^.*?\t//;
	s /^.*?\t//;
	
	#DEBUG
	#print "python bleu_test.py \'$g\' \'$_\'\n";
	#$_ = 0;
	
	$_ = `python bleu_test.py \'$g\' \'$_\'`;
	chomp;
	print "$i BLEU SCORE: $_\n";
	
	$bl = $_ + $bl;
	$i++;
	
    # 	#DEBUG
    # 	#last if $i == 5;
    }
    $B{$f} = $bl / $i;

    print "BLEU TOTAL COMPARISONS: $i\n";
    close(I);
    close(G);

}

print "Accuracy\n\n";

foreach my $f (sort {$H{$b}<=>$H{$a}} keys %H) {
    print "$f $H{$f}\n";
}

print "\nBLEU\n\n";

foreach my $f (sort {$B{$b}<=>$B{$a}} keys %B) {
    print "$f $B{$f}\n";
}
