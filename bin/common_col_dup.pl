#!/usr/bin/env perl
use strict;

###
#   common_col_dup.pl
#   JJE, 07.18.2011
#
###

# finds the lines having first column (presumably an id) common in two files
#   even with non-unique duplicate entries in the same file. (only prints 2nd file, diff than common_col.pl)
my $message = "usage: common_col_dup.pl file1 file2 (finds common ids in col1 even if duplicate/nonunique).\n";
die $message unless exists $ARGV[0] && exists $ARGV[1];

my $f1 = $ARGV[0];
my $f2 = $ARGV[1];

my @ordr;

# go through first file and load of hash by first column values as keys
my %f1_words;
open(my $f1_fh,$f1) || die "Cannot open first file: ".$f1." .\n";
while(<$f1_fh>){
   my @words = split(/\t/,$_);
   $words[-1] =~ s/\n$//;#chomp

   my $id = shift(@words);

   $f1_words{$id} = join("\t",@words);

   push(@ordr,$id);
}
close($f1_fh);

##print if exists without loading them
open(my $f2_fh,$f2) || die "Cannot open second file: ".$f2." .\n";
while(<$f2_fh>){
   my @words = split(/\t/,$_);
   $words[-1] =~ s/\n$//;#chomp

   my $id = shift(@words);

   print if defined($f1_words{$id});
}
close($f2_fh);


exit;
