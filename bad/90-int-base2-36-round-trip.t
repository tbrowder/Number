use Test;

use Number :ALL;
use Number::Wolfram :ALL;

my $res;

$res = w-rebase :num-i('11'), :base-i(2), :base-o(10);
is $res, '3';

done-testing;
exit;

$res = w-rebase :num-i('011010011111'), :base-i(2), :base-o(10);
#is $res.Numeric, '1695'.Numeric;
is $res, '1695';

$res = w-rebase :num-i('1695'), :base-i(10), :base-o(2);
#is $res.Numeric, '011010011111'.Numeric;
is $res, '011010011111';

$res = w-rebase :num-i('-011010011111'), :base-i(2), :base-o(10);
#is $res.Numeric, '-1695'.Numeric;
is $res, '-1695';

$res = w-rebase :num-i('-1695'), :base-i(10), :base-o(2);
#is $res.Numeric, '-011010011111'.Numeric;
is $res, '-011010011111';

$res = w-rebase :num-i('122022020211'), :base-i(3), :base-o(10);
#is $res.Numeric, '340627'.Numeric;
is $res, '340627';

$res = w-rebase :num-i('340627'), :base-i(10), :base-o(3);
#is $res.Numeric, '122022020211'.Numeric;
is $res, '122022020211';

$res = w-rebase :num-i('-122022020211'), :base-i(3), :base-o(10);
#is $res.Numeric, '-340627'.Numeric;
is $res, '-340627';

$res = w-rebase :num-i('-340627'), :base-i(10), :base-o(3);
#is $res.Numeric, '-122022020211'.Numeric;
is $res, '-122022020211';

$res = w-rebase :num-i('133022030321'), :base-i(4), :base-o(10);
#is $res.Numeric, '8168249'.Numeric;
is $res, '8168249';

$res = w-rebase :num-i('8168249'), :base-i(10), :base-o(4);
#is $res.Numeric, '133022030321'.Numeric;
is $res, '133022030321';

$res = w-rebase :num-i('-133022030321'), :base-i(4), :base-o(10);
#is $res.Numeric, '-8168249'.Numeric;
is $res, '-8168249';

$res = w-rebase :num-i('-8168249'), :base-i(10), :base-o(4);
#is $res.Numeric, '-133022030321'.Numeric;
is $res, '-133022030321';

$res = w-rebase :num-i('244033140432'), :base-i(5), :base-o(10);
#is $res.Numeric, '144818242'.Numeric;
is $res, '144818242';

$res = w-rebase :num-i('144818242'), :base-i(10), :base-o(5);
#is $res.Numeric, '244033140432'.Numeric;
is $res, '244033140432';

$res = w-rebase :num-i('-244033140432'), :base-i(5), :base-o(10);
#is $res.Numeric, '-144818242'.Numeric;
is $res, '-144818242';

$res = w-rebase :num-i('-144818242'), :base-i(10), :base-o(5);
#is $res.Numeric, '-244033140432'.Numeric;
is $res, '-244033140432';

$res = w-rebase :num-i('254144150532'), :base-i(6), :base-o(10);
#is $res.Numeric, '1071236216'.Numeric;
is $res, '1071236216';

$res = w-rebase :num-i('1071236216'), :base-i(10), :base-o(6);
#is $res.Numeric, '254144150532'.Numeric;
is $res, '254144150532';

$res = w-rebase :num-i('-254144150532'), :base-i(6), :base-o(10);
#is $res.Numeric, '-1071236216'.Numeric;
is $res, '-1071236216';

$res = w-rebase :num-i('-1071236216'), :base-i(10), :base-o(6);
#is $res.Numeric, '-254144150532'.Numeric;
is $res, '-254144150532';

$res = w-rebase :num-i('365145160643'), :base-i(7), :base-o(10);
#is $res.Numeric, '7838278514'.Numeric;
is $res, '7838278514';

$res = w-rebase :num-i('7838278514'), :base-i(10), :base-o(7);
#is $res.Numeric, '365145160643'.Numeric;
is $res, '365145160643';

$res = w-rebase :num-i('-365145160643'), :base-i(7), :base-o(10);
#is $res.Numeric, '-7838278514'.Numeric;
is $res, '-7838278514';

$res = w-rebase :num-i('-7838278514'), :base-i(10), :base-o(7);
#is $res.Numeric, '-365145160643'.Numeric;
is $res, '-365145160643';

$res = w-rebase :num-i('376155170653'), :base-i(8), :base-o(10);
#is $res.Numeric, '34119938475'.Numeric;
is $res, '34119938475';

$res = w-rebase :num-i('34119938475'), :base-i(10), :base-o(8);
#is $res.Numeric, '376155170653'.Numeric;
is $res, '376155170653';

$res = w-rebase :num-i('-376155170653'), :base-i(8), :base-o(10);
#is $res.Numeric, '-34119938475'.Numeric;
is $res, '-34119938475';

$res = w-rebase :num-i('-34119938475'), :base-i(10), :base-o(8);
#is $res.Numeric, '-376155170653'.Numeric;
is $res, '-376155170653';

$res = w-rebase :num-i('487166280753'), :base-i(9), :base-o(10);
#is $res.Numeric, '156205561449'.Numeric;
is $res, '156205561449';

$res = w-rebase :num-i('156205561449'), :base-i(10), :base-o(9);
#is $res.Numeric, '487166280753'.Numeric;
is $res, '487166280753';

$res = w-rebase :num-i('-487166280753'), :base-i(9), :base-o(10);
#is $res.Numeric, '-156205561449'.Numeric;
is $res, '-156205561449';

$res = w-rebase :num-i('-156205561449'), :base-i(10), :base-o(9);
#is $res.Numeric, '-487166280753'.Numeric;
is $res, '-487166280753';

$res = w-rebase :num-i('498177290864'), :base-i(10), :base-o(10);
#is $res.Numeric, '498177290864'.Numeric;
is $res, '498177290864';

$res = w-rebase :num-i('498177290864'), :base-i(10), :base-o(10);
#is $res.Numeric, '498177290864'.Numeric;
is $res, '498177290864';

$res = w-rebase :num-i('-498177290864'), :base-i(10), :base-o(10);
#is $res.Numeric, '-498177290864'.Numeric;
is $res, '-498177290864';

$res = w-rebase :num-i('-498177290864'), :base-i(10), :base-o(10);
#is $res.Numeric, '-498177290864'.Numeric;
is $res, '-498177290864';

$res = w-rebase :num-i('5a82772a0974'), :base-i(11), :base-o(10);
#is $res.Numeric, '1705374179161'.Numeric;
is $res, '1705374179161';

$res = w-rebase :num-i('1705374179161'), :base-i(10), :base-o(11);
#is $res.Numeric, '5a82772a0974'.Numeric;
is $res, '5a82772a0974';

$res = w-rebase :num-i('-5a82772a0974'), :base-i(11), :base-o(10);
#is $res.Numeric, '-1705374179161'.Numeric;
is $res, '-1705374179161';

$res = w-rebase :num-i('-1705374179161'), :base-i(10), :base-o(11);
#is $res.Numeric, '-5a82772a0974'.Numeric;
is $res, '-5a82772a0974';

$res = w-rebase :num-i('5b92882b0a75'), :base-i(12), :base-o(10);
#is $res.Numeric, '4443742116089'.Numeric;
is $res, '4443742116089';

$res = w-rebase :num-i('4443742116089'), :base-i(10), :base-o(12);
#is $res.Numeric, '5b92882b0a75'.Numeric;
is $res, '5b92882b0a75';

$res = w-rebase :num-i('-5b92882b0a75'), :base-i(12), :base-o(10);
#is $res.Numeric, '-4443742116089'.Numeric;
is $res, '-4443742116089';

$res = w-rebase :num-i('-4443742116089'), :base-i(10), :base-o(12);
#is $res.Numeric, '-5b92882b0a75'.Numeric;
is $res, '-5b92882b0a75';

$res = w-rebase :num-i('6ca2993c0b85'), :base-i(13), :base-o(10);
#is $res.Numeric, '12515550358095'.Numeric;
is $res, '12515550358095';

$res = w-rebase :num-i('12515550358095'), :base-i(10), :base-o(13);
#is $res.Numeric, '6ca2993c0b85'.Numeric;
is $res, '6ca2993c0b85';

$res = w-rebase :num-i('-6ca2993c0b85'), :base-i(13), :base-o(10);
#is $res.Numeric, '-12515550358095'.Numeric;
is $res, '-12515550358095';

$res = w-rebase :num-i('-12515550358095'), :base-i(10), :base-o(13);
#is $res.Numeric, '-6ca2993c0b85'.Numeric;
is $res, '-6ca2993c0b85';

$res = w-rebase :num-i('6cb29a3d0c96'), :base-i(14), :base-o(10);
#is $res.Numeric, '27999696102692'.Numeric;
is $res, '27999696102692';

$res = w-rebase :num-i('27999696102692'), :base-i(10), :base-o(14);
#is $res.Numeric, '6cb29a3d0c96'.Numeric;
is $res, '6cb29a3d0c96';

$res = w-rebase :num-i('-6cb29a3d0c96'), :base-i(14), :base-o(10);
#is $res.Numeric, '-27999696102692'.Numeric;
is $res, '-27999696102692';

$res = w-rebase :num-i('-27999696102692'), :base-i(10), :base-o(14);
#is $res.Numeric, '-6cb29a3d0c96'.Numeric;
is $res, '-6cb29a3d0c96';

$res = w-rebase :num-i('7dc2aa3e0c96'), :base-i(15), :base-o(10);
#is $res.Numeric, '68513017677216'.Numeric;
is $res, '68513017677216';

$res = w-rebase :num-i('68513017677216'), :base-i(10), :base-o(15);
#is $res.Numeric, '7dc2aa3e0c96'.Numeric;
is $res, '7dc2aa3e0c96';

$res = w-rebase :num-i('-7dc2aa3e0c96'), :base-i(15), :base-o(10);
#is $res.Numeric, '-68513017677216'.Numeric;
is $res, '-68513017677216';

$res = w-rebase :num-i('-68513017677216'), :base-i(10), :base-o(15);
#is $res.Numeric, '-7dc2aa3e0c96'.Numeric;
is $res, '-7dc2aa3e0c96';

$res = w-rebase :num-i('7ec3bb3f0da7'), :base-i(16), :base-o(10);
#is $res.Numeric, '139379125194151'.Numeric;
is $res, '139379125194151';

$res = w-rebase :num-i('139379125194151'), :base-i(10), :base-o(16);
#is $res.Numeric, '7ec3bb3f0da7'.Numeric;
is $res, '7ec3bb3f0da7';

$res = w-rebase :num-i('-7ec3bb3f0da7'), :base-i(16), :base-o(10);
#is $res.Numeric, '-139379125194151'.Numeric;
is $res, '-139379125194151';

$res = w-rebase :num-i('-139379125194151'), :base-i(10), :base-o(16);
#is $res.Numeric, '-7ec3bb3f0da7'.Numeric;
is $res, '-7ec3bb3f0da7';

$res = w-rebase :num-i('7fd3cc3g1eb7'), :base-i(17), :base-o(10);
#is $res.Numeric, '271710971646914'.Numeric;
is $res, '271710971646914';

$res = w-rebase :num-i('271710971646914'), :base-i(10), :base-o(17);
#is $res.Numeric, '7fd3cc3g1eb7'.Numeric;
is $res, '7fd3cc3g1eb7';

$res = w-rebase :num-i('-7fd3cc3g1eb7'), :base-i(17), :base-o(10);
#is $res.Numeric, '-271710971646914'.Numeric;
is $res, '-271710971646914';

$res = w-rebase :num-i('-271710971646914'), :base-i(10), :base-o(17);
#is $res.Numeric, '-7fd3cc3g1eb7'.Numeric;
is $res, '-7fd3cc3g1eb7';

$res = w-rebase :num-i('8ge3cc4h1fb7'), :base-i(18), :base-o(10);
#is $res.Numeric, '574092610347553'.Numeric;
is $res, '574092610347553';

$res = w-rebase :num-i('574092610347553'), :base-i(10), :base-o(18);
#is $res.Numeric, '8ge3cc4h1fb7'.Numeric;
is $res, '8ge3cc4h1fb7';

$res = w-rebase :num-i('-8ge3cc4h1fb7'), :base-i(18), :base-o(10);
#is $res.Numeric, '-574092610347553'.Numeric;
is $res, '-574092610347553';

$res = w-rebase :num-i('-574092610347553'), :base-i(10), :base-o(18);
#is $res.Numeric, '-8ge3cc4h1fb7'.Numeric;
is $res, '-8ge3cc4h1fb7';

$res = w-rebase :num-i('8hf3dd4i1gc8'), :base-i(19), :base-o(10);
#is $res.Numeric, '1041053707916282'.Numeric;
is $res, '1041053707916282';

$res = w-rebase :num-i('1041053707916282'), :base-i(10), :base-o(19);
#is $res.Numeric, '8hf3dd4i1gc8'.Numeric;
is $res, '8hf3dd4i1gc8';

$res = w-rebase :num-i('-8hf3dd4i1gc8'), :base-i(19), :base-o(10);
#is $res.Numeric, '-1041053707916282'.Numeric;
is $res, '-1041053707916282';

$res = w-rebase :num-i('-1041053707916282'), :base-i(10), :base-o(19);
#is $res.Numeric, '-8hf3dd4i1gc8'.Numeric;
is $res, '-8hf3dd4i1gc8';

$res = w-rebase :num-i('9ig3ee4j1hd8'), :base-i(20), :base-o(10);
#is $res.Numeric, '2035807631855068'.Numeric;
is $res, '2035807631855068';

$res = w-rebase :num-i('2035807631855068'), :base-i(10), :base-o(20);
#is $res.Numeric, '9ig3ee4j1hd8'.Numeric;
is $res, '9ig3ee4j1hd8';

$res = w-rebase :num-i('-9ig3ee4j1hd8'), :base-i(20), :base-o(10);
#is $res.Numeric, '-2035807631855068'.Numeric;
is $res, '-2035807631855068';

$res = w-rebase :num-i('-2035807631855068'), :base-i(10), :base-o(20);
#is $res.Numeric, '-9ig3ee4j1hd8'.Numeric;
is $res, '-9ig3ee4j1hd8';

$res = w-rebase :num-i('9jg4ef4k1id9'), :base-i(21), :base-o(10);
#is $res.Numeric, '3482301537623442'.Numeric;
is $res, '3482301537623442';

$res = w-rebase :num-i('3482301537623442'), :base-i(10), :base-o(21);
#is $res.Numeric, '9jg4ef4k1id9'.Numeric;
is $res, '9jg4ef4k1id9';

$res = w-rebase :num-i('-9jg4ef4k1id9'), :base-i(21), :base-o(10);
#is $res.Numeric, '-3482301537623442'.Numeric;
is $res, '-3482301537623442';

$res = w-rebase :num-i('-3482301537623442'), :base-i(10), :base-o(21);
#is $res.Numeric, '-9jg4ef4k1id9'.Numeric;
is $res, '-9jg4ef4k1id9';

$res = w-rebase :num-i('akh4ff5l1je9'), :base-i(22), :base-o(10);
#is $res.Numeric, '6395163696912945'.Numeric;
is $res, '6395163696912945';

$res = w-rebase :num-i('6395163696912945'), :base-i(10), :base-o(22);
#is $res.Numeric, 'akh4ff5l1je9'.Numeric;
is $res, 'akh4ff5l1je9';

$res = w-rebase :num-i('-akh4ff5l1je9'), :base-i(22), :base-o(10);
#is $res.Numeric, '-6395163696912945'.Numeric;
is $res, '-6395163696912945';

$res = w-rebase :num-i('-6395163696912945'), :base-i(10), :base-o(22);
#is $res.Numeric, '-akh4ff5l1je9'.Numeric;
is $res, '-akh4ff5l1je9';

$res = w-rebase :num-i('ali4gg5m1jea'), :base-i(23), :base-o(10);
#is $res.Numeric, '10430845190615500'.Numeric;
is $res, '10430845190615500';

$res = w-rebase :num-i('10430845190615500'), :base-i(10), :base-o(23);
#is $res.Numeric, 'ali4gg5m1jea'.Numeric;
is $res, 'ali4gg5m1jea';

$res = w-rebase :num-i('-ali4gg5m1jea'), :base-i(23), :base-o(10);
#is $res.Numeric, '-10430845190615500'.Numeric;
is $res, '-10430845190615500';

$res = w-rebase :num-i('-10430845190615500'), :base-i(10), :base-o(23);
#is $res.Numeric, '-ali4gg5m1jea'.Numeric;
is $res, '-ali4gg5m1jea';

$res = w-rebase :num-i('bmj4hh5n1kfa'), :base-i(24), :base-o(10);
#is $res.Numeric, '18184082866852978'.Numeric;
is $res, '18184082866852978';

$res = w-rebase :num-i('18184082866852978'), :base-i(10), :base-o(24);
#is $res.Numeric, 'bmj4hh5n1kfa'.Numeric;
is $res, 'bmj4hh5n1kfa';

$res = w-rebase :num-i('-bmj4hh5n1kfa'), :base-i(24), :base-o(10);
#is $res.Numeric, '-18184082866852978'.Numeric;
is $res, '-18184082866852978';

$res = w-rebase :num-i('-18184082866852978'), :base-i(10), :base-o(24);
#is $res.Numeric, '-bmj4hh5n1kfa'.Numeric;
is $res, '-bmj4hh5n1kfa';

$res = w-rebase :num-i('bnk4hi5o1lgb'), :base-i(25), :base-o(10);
#is $res.Numeric, '28496507138310411'.Numeric;
is $res, '28496507138310411';

$res = w-rebase :num-i('28496507138310411'), :base-i(10), :base-o(25);
#is $res.Numeric, 'bnk4hi5o1lgb'.Numeric;
is $res, 'bnk4hi5o1lgb';

$res = w-rebase :num-i('-bnk4hi5o1lgb'), :base-i(25), :base-o(10);
#is $res.Numeric, '-28496507138310411'.Numeric;
is $res, '-28496507138310411';

$res = w-rebase :num-i('-28496507138310411'), :base-i(10), :base-o(25);
#is $res.Numeric, '-bnk4hi5o1lgb'.Numeric;
is $res, '-bnk4hi5o1lgb';

$res = w-rebase :num-i('cok5ii6p1mgb'), :base-i(26), :base-o(10);
#is $res.Numeric, '47541928564249403'.Numeric;
is $res, '47541928564249403';

$res = w-rebase :num-i('47541928564249403'), :base-i(10), :base-o(26);
#is $res.Numeric, 'cok5ii6p1mgb'.Numeric;
is $res, 'cok5ii6p1mgb';

$res = w-rebase :num-i('-cok5ii6p1mgb'), :base-i(26), :base-o(10);
#is $res.Numeric, '-47541928564249403'.Numeric;
is $res, '-47541928564249403';

$res = w-rebase :num-i('-47541928564249403'), :base-i(10), :base-o(26);
#is $res.Numeric, '-cok5ii6p1mgb'.Numeric;
is $res, '-cok5ii6p1mgb';

$res = w-rebase :num-i('cpl5jj6p1nhb'), :base-i(27), :base-o(10);
#is $res.Numeric, '72017761003016168'.Numeric;
is $res, '72017761003016168';

$res = w-rebase :num-i('72017761003016168'), :base-i(10), :base-o(27);
#is $res.Numeric, 'cpl5jj6p1nhb'.Numeric;
is $res, 'cpl5jj6p1nhb';

$res = w-rebase :num-i('-cpl5jj6p1nhb'), :base-i(27), :base-o(10);
#is $res.Numeric, '-72017761003016168'.Numeric;
is $res, '-72017761003016168';

$res = w-rebase :num-i('-72017761003016168'), :base-i(10), :base-o(27);
#is $res.Numeric, '-cpl5jj6p1nhb'.Numeric;
is $res, '-cpl5jj6p1nhb';

$res = w-rebase :num-i('dpm5jk6q1oic'), :base-i(28), :base-o(10);
#is $res.Numeric, '115455423408218948'.Numeric;
is $res, '115455423408218948';

$res = w-rebase :num-i('115455423408218948'), :base-i(10), :base-o(28);
#is $res.Numeric, 'dpm5jk6q1oic'.Numeric;
is $res, 'dpm5jk6q1oic';

$res = w-rebase :num-i('-dpm5jk6q1oic'), :base-i(28), :base-o(10);
#is $res.Numeric, '-115455423408218948'.Numeric;
is $res, '-115455423408218948';

$res = w-rebase :num-i('-115455423408218948'), :base-i(10), :base-o(28);
#is $res.Numeric, '-dpm5jk6q1oic'.Numeric;
is $res, '-dpm5jk6q1oic';

$res = w-rebase :num-i('dqn5kk6r1pic'), :base-i(29), :base-o(10);
#is $res.Numeric, '169881537645692824'.Numeric;
is $res, '169881537645692824';

$res = w-rebase :num-i('169881537645692824'), :base-i(10), :base-o(29);
#is $res.Numeric, 'dqn5kk6r1pic'.Numeric;
is $res, 'dqn5kk6r1pic';

$res = w-rebase :num-i('-dqn5kk6r1pic'), :base-i(29), :base-o(10);
#is $res.Numeric, '-169881537645692824'.Numeric;
is $res, '-169881537645692824';

$res = w-rebase :num-i('-169881537645692824'), :base-i(10), :base-o(29);
#is $res.Numeric, '-dqn5kk6r1pic'.Numeric;
is $res, '-dqn5kk6r1pic';

$res = w-rebase :num-i('ero5ll7s1pjd'), :base-i(30), :base-o(10);
#is $res.Numeric, '264425177271830083'.Numeric;
is $res, '264425177271830083';

$res = w-rebase :num-i('264425177271830083'), :base-i(10), :base-o(30);
#is $res.Numeric, 'ero5ll7s1pjd'.Numeric;
is $res, 'ero5ll7s1pjd';

$res = w-rebase :num-i('-ero5ll7s1pjd'), :base-i(30), :base-o(10);
#is $res.Numeric, '-264425177271830083'.Numeric;
is $res, '-264425177271830083';

$res = w-rebase :num-i('-264425177271830083'), :base-i(10), :base-o(30);
#is $res.Numeric, '-ero5ll7s1pjd'.Numeric;
is $res, '-ero5ll7s1pjd';

$res = w-rebase :num-i('esp6lm7t1qkd'), :base-i(31), :base-o(10);
#is $res.Numeric, '379334974002590372'.Numeric;
is $res, '379334974002590372';

$res = w-rebase :num-i('379334974002590372'), :base-i(10), :base-o(31);
#is $res.Numeric, 'esp6lm7t1qkd'.Numeric;
is $res, 'esp6lm7t1qkd';

$res = w-rebase :num-i('-esp6lm7t1qkd'), :base-i(31), :base-o(10);
#is $res.Numeric, '-379334974002590372'.Numeric;
is $res, '-379334974002590372';

$res = w-rebase :num-i('-379334974002590372'), :base-i(10), :base-o(31);
#is $res.Numeric, '-esp6lm7t1qkd'.Numeric;
is $res, '-esp6lm7t1qkd';

$res = w-rebase :num-i('ftp6mn7u1rke'), :base-i(32), :base-o(10);
#is $res.Numeric, '573970039831588494'.Numeric;
is $res, '573970039831588494';

$res = w-rebase :num-i('573970039831588494'), :base-i(10), :base-o(32);
#is $res.Numeric, 'ftp6mn7u1rke'.Numeric;
is $res, 'ftp6mn7u1rke';

$res = w-rebase :num-i('-ftp6mn7u1rke'), :base-i(32), :base-o(10);
#is $res.Numeric, '-573970039831588494'.Numeric;
is $res, '-573970039831588494';

$res = w-rebase :num-i('-573970039831588494'), :base-i(10), :base-o(32);
#is $res.Numeric, '-ftp6mn7u1rke'.Numeric;
is $res, '-ftp6mn7u1rke';

$res = w-rebase :num-i('fuq6nn7v2sle'), :base-i(33), :base-o(10);
#is $res.Numeric, '805295114548762082'.Numeric;
is $res, '805295114548762082';

$res = w-rebase :num-i('805295114548762082'), :base-i(10), :base-o(33);
#is $res.Numeric, 'fuq6nn7v2sle'.Numeric;
is $res, 'fuq6nn7v2sle';

$res = w-rebase :num-i('-fuq6nn7v2sle'), :base-i(33), :base-o(10);
#is $res.Numeric, '-805295114548762082'.Numeric;
is $res, '-805295114548762082';

$res = w-rebase :num-i('-805295114548762082'), :base-i(10), :base-o(33);
#is $res.Numeric, '-fuq6nn7v2sle'.Numeric;
is $res, '-fuq6nn7v2sle';

$res = w-rebase :num-i('fvr6oo7w2tmf'), :base-i(34), :base-o(10);
#is $res.Numeric, '1118479736511095775'.Numeric;
is $res, '1118479736511095775';

$res = w-rebase :num-i('1118479736511095775'), :base-i(10), :base-o(34);
#is $res.Numeric, 'fvr6oo7w2tmf'.Numeric;
is $res, 'fvr6oo7w2tmf';

$res = w-rebase :num-i('-fvr6oo7w2tmf'), :base-i(34), :base-o(10);
#is $res.Numeric, '-1118479736511095775'.Numeric;
is $res, '-1118479736511095775';

$res = w-rebase :num-i('-1118479736511095775'), :base-i(10), :base-o(34);
#is $res.Numeric, '-fvr6oo7w2tmf'.Numeric;
is $res, '-fvr6oo7w2tmf';

$res = w-rebase :num-i('gws6op8x2umf'), :base-i(35), :base-o(10);
#is $res.Numeric, '1635281972985990785'.Numeric;
is $res, '1635281972985990785';

$res = w-rebase :num-i('1635281972985990785'), :base-i(10), :base-o(35);
#is $res.Numeric, 'gws6op8x2umf'.Numeric;
is $res, 'gws6op8x2umf';

$res = w-rebase :num-i('-gws6op8x2umf'), :base-i(35), :base-o(10);
#is $res.Numeric, '-1635281972985990785'.Numeric;
is $res, '-1635281972985990785';

$res = w-rebase :num-i('-1635281972985990785'), :base-i(10), :base-o(35);
#is $res.Numeric, '-gws6op8x2umf'.Numeric;
is $res, '-gws6op8x2umf';

$res = w-rebase :num-i('gxt7pp8y2vnf'), :base-i(36), :base-o(10);
#is $res.Numeric, '2229567490575720123'.Numeric;
is $res, '2229567490575720123';

$res = w-rebase :num-i('2229567490575720123'), :base-i(10), :base-o(36);
#is $res.Numeric, 'gxt7pp8y2vnf'.Numeric;
is $res, 'gxt7pp8y2vnf';

$res = w-rebase :num-i('-gxt7pp8y2vnf'), :base-i(36), :base-o(10);
#is $res.Numeric, '-2229567490575720123'.Numeric;
is $res, '-2229567490575720123';

$res = w-rebase :num-i('-2229567490575720123'), :base-i(10), :base-o(36);
#is $res.Numeric, '-gxt7pp8y2vnf'.Numeric;
is $res, '-gxt7pp8y2vnf';


done-testing;
