use v6;
use Test;

plan 10;

sub showset($s) { $s.keys.sort.join(' ') }
sub showkv($x) { $x.sort.map({ .key ~ ':' ~ .value }).join(' ') }

my $s = set <I'm afraid it isn't your day>;
my $sh = SetHash.new(<I'm afraid it is>); # Tom Stoppard
my $b = bag <Whoever remains for long here in this earthly life will enjoy and endure more than enough>; # Seamus Heaney
my $bh = BagHash.new(<Come, take your bread with joy, and your wine with a glad heart>); # Ecclesiastes 9:7

# Union tests moved to union.t

# Intersection tests moved to intersection.t

# set subtraction moved to difference.t

# symmetric difference moved to set_symmetric_difference.t

# symmetric difference with Bag moved to bag.t

# is subset of moved to subset.t

# is proper subset of moved to proper-subset.t

# is not a proper subset of moved to proper-subset.t

# is superset of moved to subset.t

# is not a superset of moved to proper-subset.t

{
    my $a = set <Zeus Hera Artemis Apollo Hades Aphrodite Ares Athena Hermes Poseidon Hephaestus>;
    my $b = set <Jupiter Juno Neptune Minerva Mars Venus Apollo Diana Vulcan Vesta Mercury Ceres>;
    my $c = [<Apollo Arclight Astor>];
    my @d;

    is showset([∪] @d), showset(∅), "Union reduce works on nothing";
    is showset([∪] $a), showset($a), "Union reduce works on one set";
    is showset([∪] $a, $b), showset(set($a.keys, $b.keys)), "Union reduce works on two sets";
    is showset([∪] $a, $b, $c), showset(set($a.keys, $b.keys, $c.values)), "Union reduce works on three sets";

    is showset([(|)] @d), showset(∅), "Union reduce works on nothing (texas)";
    is showset([(|)] $a), showset($a), "Union reduce works on one set (texas)";
    is showset([(|)] $a, $b), showset(set($a.keys, $b.keys)), "Union reduce works on two sets (texas)";
    is showset([(|)] $a, $b, $c), showset(set($a.keys, $b.keys, $c.values)), "Union reduce works on three sets (texas)";
}

# RT #117997
{
    throws-like 'set;', Exception,
        'set listop called without arguments dies (1)',
        message => { m/'Function "set" may not be called without arguments'/ };
    throws-like 'set<a b c>;', X::Syntax::Confused,
        'set listop called without arguments dies (2)',
        message => { m/'Use of non-subscript brackets after "set" where postfix is expected'/ };
}

# vim: ft=perl6
