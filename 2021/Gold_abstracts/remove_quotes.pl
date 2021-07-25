#!/usr/bin/perl -wd

use strict;

open(I,"abstracts_basque_fixed_index.tsv")||die;
open(O,">abstracts_basque_fixed_index_noquotes.tsv")||die;

while(<I>) {
    chomp;
    my @F = split(/\t/,$_);
    $F[2] =~s /^\"//;
    $F[2] =~s /\"$//;
    $_ = join "\t",@F;
    print O "$_\n";
}
close(I);
close(O);
