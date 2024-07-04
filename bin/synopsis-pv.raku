#!/usr/bin/env raku
use Physics::Vector;
use Physics::Measure :ALL;

my $v1 = Physics::Vector.new([1, 2, 3], 'm/s');

my $v = (3,4,0), my $u = 'm/s';
my $v2 = Physics::Vector.new(:$v, :$u);
say ~$v2;

say ~($v1+$v2);
say ~(-$v1);

my $m = 10kg;

my $p = $m * $v1;
say ~$p;



