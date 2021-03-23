#!/usr/bin/perl -w

use strict;
use vars qw ();

my $data_d = "/home/jibmaird/Projects/WMT_Basque";
my $gold_f = "$data_d/Gold/gns10-osakidetza-test.eu";

opendir(D,"$data_d/Participants-terms")||die;
my @Files = grep /\.txt/,readdir D;
closedir(D);

undef my %H;
undef my %B;
foreach my $f (@Files) {
#    $_ = `./eval_run_tokens.pl $data_d/Participants-terms/$f $gold_f`;
    $_ = `./eval_run.pl $data_d/Participants-terms/$f $gold_f`;
    chomp;
    m /ACC\: (.*?)$/;
    $H{$f} = $1;

    #bleu
    # open(I,"$data_d/Participants-terms/$f")||die;
    # open(G,"$gold_f")||die;
    # my $i = 0;
    # my $bl = 0;
    # while(<I>) {
    # 	chomp;
    # 	my $g = <G>;
    # 	chomp($g);
    # 	$_ = `python bleu_test.py \'$g\' \'$_\'`;
    # 	chomp;
    # 	$bl = $_ + $bl;
    # 	$i++;
	
    # 	#DEBUG
    # 	#last if $i == 5;
    # }
    # $B{$f} = $bl / $i;
    # close(I);
    # close(G);

}

print "Accuracy\n\n";

foreach my $f (sort {$H{$b}<=>$H{$a}} keys %H) {
    print "$f $H{$f}\n";
}

print "\nBLEU\n\n";

foreach my $f (sort {$B{$b}<=>$B{$a}} keys %B) {
    print "$f $B{$f}\n";
}
