#!/usr/bin/env perl 

use strict;
use warnings; 

my $msa = shift @ARGV; 
open MSA,"<",$msa or die "$!"; 
my $fa = {}; 

while (<MSA>) { 
  ## the script assumes that all the alignment is trimmed on the left and on the right
  m/^>(.*)$/; 
  my $id = $1; 
  chomp(my $seq = <MSA>); 
  $fa->{$id} = $seq; 
} 

foreach my $i (keys %{$fa}) { 
  foreach my $j (keys %{$fa}) { 
    my @n1  = split //,$fa->{$i}; 
    my @n2  = split //,$fa->{$j}; 
    my ($len,$match,$mismatch,$gap) = (0)x4; 
    for (my $k = 0; $k < scalar @n1; $k++) {
      if ($n1[$k] eq $n2[$k] && $n1[$k] ne "-") { 
        $len++;
        $match++;
      } elsif ($n1[$k] eq $n2[$k] && $n1[$k] eq "-") { 
        $gap++;
      } else { 
        $len++;
        $mismatch++; 
      } 
    } 
    printf "%s\t%s\t%.2f\n",$i,$j,100*$match/$len; 
  }
}

close MSA;
