use Math::Vector;
use Physics::Unit;
use Physics::Measure;

class Physics::Vector is Math::Vector {
    has Unit $.units;

    multi method new(@v, Str $defn) {
        self.bless(components => @v, units => Unit.new(:$defn) );
    }

    multi method new(@v, Unit $units) {
        self.bless(components => @v, :$units );
    }

    multi method new(:v(:$value), :u(:$units)) {
        self.bless(components => |$value, units => Unit.new(defn => $units) );
    }

    method Str {
        my $parent = callsame;
        $parent ~ $!units;
    }
}

sub affine($a, $b) {
    $a.dim == $b.dim               &&
    $a.units.same-unit: $b.units;
}

sub threefine($a, $b) {
    $a.dim == $b.dim == 3          &&
    $a.units.same-unit: $b.units;
}

multi infix:<+> (Physics::Vector $a, Physics::Vector $b where affine($a,$b)) is export
{
    Physics::Vector.new( [($a.add: $b).components], $a.units );
}

multi infix:<->(Physics::Vector $a, Physics::Vector $b where affine($a,$b)) is export
{
    Physics::Vector.new( [($a.subtract: $b).components], $a.units );
}

multi prefix:<->(Physics::Vector $a) is export
{
    Physics::Vector.new( [($a.negate).components], $a.units );
}

multi infix:<*>(Physics::Vector $a, Physics::Measure::Measure $b) is export
{
    Physics::Vector.new( [($a.scale: $b).components], ($a.units.multiply: $b.units)[1] );
}

multi infix:<*>(Physics::Measure::Measure $a, Physics::Vector $b) is export
{
    Physics::Vector.new( [($b.scale: $a).components], ($b.units.multiply: $a.units)[1] );
}

multi infix:</>(Physics::Vector $a, Physics::Measure::Measure $b) is export
{
    Physics::Vector.new( [($a.scale: (1/$b.value)).components], ($a.units.divide: $b.units)[1] );
}

multi infix:<⋅>(Physics::Vector $a, Physics::Vector $b where affine($a,$b)) is export
{
    Physics::Vector.new( [($a.dot: $b).components], $a.units );
}

multi infix:<dot>(Physics::Vector $a, Physics::Vector $b where affine($a,$b)) is export
{
    Physics::Vector.new( [($a.dot: $b).components], $a.units );
}

multi infix:<×>(Physics::Vector $a , Physics::Vector $b where threefine($a,$b)) is export
{
    Physics::Vector.new( [($a.cross: $b).components], $a.units );
}

multi infix:<cross>(Physics::Vector $a, Physics::Vector $b where threefine($a,$b)) is export
{
    Physics::Vector.new( [($a.cross: $b).components], $a.units );
}

multi circumfix:<⎡ ⎤>(Physics::Vector $a) is export
{
    Physics::Vector.new( [($a.length).components], $a.units );
}

multi infix:<cmp>(Physics::Vector $a, Physics::Vector $b where affine($a,$b)) is export
{
    $a.cmp: $b;
}