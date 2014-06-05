use v6;

use Test;

plan 11;

dies_ok { Supply.Channel }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    {
        my $s = Supply.new;
        my $c = $s.Channel;
        isa_ok $c, Channel, 'we got a Channel';
        $s.more(42);
        is $c.receive, 42, 'got first mored value';
        $s.more(43);
        $s.more(44);
        is $c.receive, 43, 'got second mored value';
        is $c.receive, 44, 'got third mored value';
        $s.done;
        ok $c.closed, 'doneing closes the Channel';
    }
}
