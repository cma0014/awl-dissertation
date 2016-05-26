#!/usr/local/bin/perl
my $count = 0;
my $sum = 0;
my $average = 0;

while ( $line = <STDIN> ) {
    chomp $line;
    $sum = $sum + $line;
    $count = $count + 1;
}

$average = $sum / $count;
print ",",$average,"\n";
