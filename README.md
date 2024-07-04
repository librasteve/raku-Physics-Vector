[![License: Artistic-2.0](https://img.shields.io/badge/License-Artistic%202.0-0298c3.svg)](https://opensource.org/licenses/Artistic-2.0)

# Physics::Vector

## Synopsis

```raku
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
```

### Copyright
copyright(c) 2024 Henley Cloud Consulting Ltd.
