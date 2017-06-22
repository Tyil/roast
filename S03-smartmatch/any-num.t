use v6;
use Test;
plan 20;

#L<S03/Smart matching/Any Num numeric equality>
{
    ok   (5 ~~ 5),               'Int ~~ Int works';
    nok  (5 ~~ 6),               'Int ~~ Int works';

    ok   ('05' ~~ 5),            '$something ~~ Int numifies';
    ok   ('05' ~~ 5.Rat),        '$something ~~ Rat numifies';
    ok   ('05' ~~ 5.Num),        '$something ~~ Num numifies';

    ok  ('1.2' ~~ 1.2),         '$thing ~~ Rat does numeric comparison';
    ok  ('1.2' ~~ 1.2.Num),     '$thing ~~ Num does numeric comparison';

    ok  !(Mu ~~ 0),              'Mu ~~ 0';
    ok  !(Mu ~~ 'foo'),          'Mu ~~ 0';
    ok  !(Mu ~~ 2.3),            'Mu ~~ $other_number';

    ok  (3+0i  ~~ 3),           'Complex ~~ Int (+)';
    nok (3+1i  ~~ 3),           'Complex ~~ Int (-)';
    nok (4+0i  ~~ 3),           'Complex ~~ Int (-)';
    ok  (3+0i  ~~ 3.Rat),       'Complex ~~ Rat (+)';
    nok (3+1i  ~~ 3.Rat),       'Complex ~~ Rat (-)';
    nok (4+0i  ~~ 3.Rat),       'Complex ~~ Rat (-)';
    ok  (3+0i  ~~ 3.Num),       'Complex ~~ Num (+)';
    nok (3+1i  ~~ 3.Num),       'Complex ~~ Num (-)';
    nok (4+0i  ~~ 3.Num),       'Complex ~~ Num (-)';
}

subtest 'Str ~~ Num' => {
    plan 4;
    is-deeply 'NaN' ~~  NaN, True,  ｢'NaN' ~~  NaN｣;
    is-deeply 'NaN' ~~ 42e0, False, ｢'NaN' ~~ 42e0｣;
    #?rakudo.jvm skip 'Failure from "x".Numeric is handled wrongly in is-deeply, RT #130775'
    is-deeply 'x'   ~~ 42e0, False, ｢'x'   ~~ 42e0｣;
    is-deeply '42'  ~~ 42e0, True,  ｢'42'  ~~ 42e0｣;
}

# vim: ft=perl6
