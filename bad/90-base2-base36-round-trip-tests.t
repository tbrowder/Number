use Test;

use Number :ALL;
use Number::Wolfram :ALL;

my $res;

$res = w-rebase :num-i('011010011111'), :base-i(2), :base-o(10);
is $res.Numeric, '1695'.Numeric;

$res = w-rebase :num-i('1695'), :base-i(10), :base-o(2);
is $res.Numeric, '011010011111'.Numeric;

$res = w-rebase :num-i('-1111001000001'), :base-i(2), :base-o(10);
is $res.Numeric, '-7745'.Numeric;

$res = w-rebase :num-i('-7745'), :base-i(10), :base-o(2);
is $res.Numeric, '-1111001000001'.Numeric;

$res = w-rebase :num-i('122022020211'), :base-i(3), :base-o(10);
is $res.Numeric, '340627'.Numeric;

$res = w-rebase :num-i('340627'), :base-i(10), :base-o(3);
is $res.Numeric, '122022020211'.Numeric;

$res = w-rebase :num-i('-1202110112002'), :base-i(3), :base-o(10);
is $res.Numeric, '-934229'.Numeric;

$res = w-rebase :num-i('-934229'), :base-i(10), :base-o(3);
is $res.Numeric, '-1202110112002'.Numeric;

$res = w-rebase :num-i('133022030321'), :base-i(4), :base-o(10);
is $res.Numeric, '8168249'.Numeric;

$res = w-rebase :num-i('8168249'), :base-i(10), :base-o(4);
is $res.Numeric, '133022030321'.Numeric;

$res = w-rebase :num-i('-1303111212102'), :base-i(4), :base-o(10);
is $res.Numeric, '-30235026'.Numeric;

$res = w-rebase :num-i('-30235026'), :base-i(10), :base-o(4);
is $res.Numeric, '-1303111212102'.Numeric;

$res = w-rebase :num-i('244033140432'), :base-i(5), :base-o(10);
is $res.Numeric, '144818242'.Numeric;

$res = w-rebase :num-i('144818242'), :base-i(10), :base-o(5);
is $res.Numeric, '244033140432'.Numeric;

$res = w-rebase :num-i('-1404111313103'), :base-i(5), :base-o(10);
is $res.Numeric, '-447760403'.Numeric;

$res = w-rebase :num-i('-447760403'), :base-i(10), :base-o(5);
is $res.Numeric, '-1404111313103'.Numeric;

$res = w-rebase :num-i('254144150532'), :base-i(6), :base-o(10);
is $res.Numeric, '1071236216'.Numeric;

$res = w-rebase :num-i('1071236216'), :base-i(10), :base-o(6);
is $res.Numeric, '254144150532'.Numeric;

$res = w-rebase :num-i('-2504221324104'), :base-i(6), :base-o(10);
is $res.Numeric, '-6211853320'.Numeric;

$res = w-rebase :num-i('-6211853320'), :base-i(10), :base-o(6);
is $res.Numeric, '-2504221324104'.Numeric;

$res = w-rebase :num-i('365145160643'), :base-i(7), :base-o(10);
is $res.Numeric, '7838278514'.Numeric;

$res = w-rebase :num-i('7838278514'), :base-i(10), :base-o(7);
is $res.Numeric, '365145160643'.Numeric;

$res = w-rebase :num-i('-2605222425104'), :base-i(7), :base-o(10);
is $res.Numeric, '-39761788679'.Numeric;

$res = w-rebase :num-i('-39761788679'), :base-i(10), :base-o(7);
is $res.Numeric, '-2605222425104'.Numeric;

$res = w-rebase :num-i('376155170653'), :base-i(8), :base-o(10);
is $res.Numeric, '34119938475'.Numeric;

$res = w-rebase :num-i('34119938475'), :base-i(10), :base-o(8);
is $res.Numeric, '376155170653'.Numeric;

$res = w-rebase :num-i('-2706322425205'), :base-i(8), :base-o(10);
is $res.Numeric, '-198428994181'.Numeric;

$res = w-rebase :num-i('-198428994181'), :base-i(10), :base-o(8);
is $res.Numeric, '-2706322425205'.Numeric;

$res = w-rebase :num-i('487166280753'), :base-i(9), :base-o(10);
is $res.Numeric, '156205561449'.Numeric;

$res = w-rebase :num-i('156205561449'), :base-i(10), :base-o(9);
is $res.Numeric, '487166280753'.Numeric;

$res = w-rebase :num-i('-3707332536206'), :base-i(9), :base-o(10);
is $res.Numeric, '-1069812841551'.Numeric;

$res = w-rebase :num-i('-1069812841551'), :base-i(10), :base-o(9);
is $res.Numeric, '-3707332536206'.Numeric;

$res = w-rebase :num-i('498177290864'), :base-i(10), :base-o(10);
is $res.Numeric, '498177290864'.Numeric;

$res = w-rebase :num-i('498177290864'), :base-i(10), :base-o(10);
is $res.Numeric, '498177290864'.Numeric;

$res = w-rebase :num-i('-3808333637207'), :base-i(10), :base-o(10);
is $res.Numeric, '-3808333637207'.Numeric;

$res = w-rebase :num-i('-3808333637207'), :base-i(10), :base-o(10);
is $res.Numeric, '-3808333637207'.Numeric;

$res = w-rebase :num-i('5a82772a0974'), :base-i(11), :base-o(10);
is $res.Numeric, '1705374179161'.Numeric;

$res = w-rebase :num-i('1705374179161'), :base-i(10), :base-o(11);
is $res.Numeric, '5a82772a0974'.Numeric;

$res = w-rebase :num-i('-4909443637307'), :base-i(11), :base-o(10);
is $res.Numeric, '-15143681790409'.Numeric;

$res = w-rebase :num-i('-15143681790409'), :base-i(10), :base-o(11);
is $res.Numeric, '-4909443637307'.Numeric;

$res = w-rebase :num-i('5b92882b0a75'), :base-i(12), :base-o(10);
is $res.Numeric, '4443742116089'.Numeric;

$res = w-rebase :num-i('4443742116089'), :base-i(10), :base-o(12);
is $res.Numeric, '5b92882b0a75'.Numeric;

$res = w-rebase :num-i('-4a09443748308'), :base-i(12), :base-o(10);
is $res.Numeric, '-43142797574072'.Numeric;

$res = w-rebase :num-i('-43142797574072'), :base-i(10), :base-o(12);
is $res.Numeric, '-4a09443748308'.Numeric;

$res = w-rebase :num-i('6ca2993c0b85'), :base-i(13), :base-o(10);
is $res.Numeric, '12515550358095'.Numeric;

$res = w-rebase :num-i('12515550358095'), :base-i(10), :base-o(13);
is $res.Numeric, '6ca2993c0b85'.Numeric;

$res = w-rebase :num-i('-4b0a543749309'), :base-i(13), :base-o(10);
is $res.Numeric, '-113016496679745'.Numeric;

$res = w-rebase :num-i('-113016496679745'), :base-i(10), :base-o(13);
is $res.Numeric, '-4b0a543749309'.Numeric;

$res = w-rebase :num-i('6cb29a3d0c96'), :base-i(14), :base-o(10);
is $res.Numeric, '27999696102692'.Numeric;

$res = w-rebase :num-i('27999696102692'), :base-i(10), :base-o(14);
is $res.Numeric, '6cb29a3d0c96'.Numeric;

$res = w-rebase :num-i('-5c0b55485a309'), :base-i(14), :base-o(10);
is $res.Numeric, '-332299556080725'.Numeric;

$res = w-rebase :num-i('-332299556080725'), :base-i(10), :base-o(14);
is $res.Numeric, '-5c0b55485a309'.Numeric;

$res = w-rebase :num-i('7dc2aa3e0c96'), :base-i(15), :base-o(10);
is $res.Numeric, '68513017677216'.Numeric;

$res = w-rebase :num-i('68513017677216'), :base-i(10), :base-o(15);
is $res.Numeric, '7dc2aa3e0c96'.Numeric;

$res = w-rebase :num-i('-5d0c55495a40a'), :base-i(15), :base-o(10);
is $res.Numeric, '-761653557372160'.Numeric;

$res = w-rebase :num-i('-761653557372160'), :base-i(10), :base-o(15);
is $res.Numeric, '-5d0c55495a40a'.Numeric;

$res = w-rebase :num-i('7ec3bb3f0da7'), :base-i(16), :base-o(10);
is $res.Numeric, '139379125194151'.Numeric;

$res = w-rebase :num-i('139379125194151'), :base-i(10), :base-o(16);
is $res.Numeric, '7ec3bb3f0da7'.Numeric;

$res = w-rebase :num-i('-5e0d65495b40b'), :base-i(16), :base-o(10);
is $res.Numeric, '-1654586030273547'.Numeric;

$res = w-rebase :num-i('-1654586030273547'), :base-i(10), :base-o(16);
is $res.Numeric, '-5e0d65495b40b'.Numeric;

$res = w-rebase :num-i('7fd3cc3g1eb7'), :base-i(17), :base-o(10);
is $res.Numeric, '271710971646914'.Numeric;

$res = w-rebase :num-i('271710971646914'), :base-i(10), :base-o(17);
is $res.Numeric, '7fd3cc3g1eb7'.Numeric;

$res = w-rebase :num-i('-6e0e665a6c40b'), :base-i(17), :base-o(10);
is $res.Numeric, '-3977244653980734'.Numeric;

$res = w-rebase :num-i('-3977244653980734'), :base-i(10), :base-o(17);
is $res.Numeric, '-6e0e665a6c40b'.Numeric;

$res = w-rebase :num-i('8ge3cc4h1fb7'), :base-i(18), :base-o(10);
is $res.Numeric, '574092610347553'.Numeric;

$res = w-rebase :num-i('574092610347553'), :base-i(10), :base-o(18);
is $res.Numeric, '8ge3cc4h1fb7'.Numeric;

$res = w-rebase :num-i('-6f0e765a6c51c'), :base-i(18), :base-o(10);
is $res.Numeric, '-7907872472513202'.Numeric;

$res = w-rebase :num-i('-7907872472513202'), :base-i(10), :base-o(18);
is $res.Numeric, '-6f0e765a6c51c'.Numeric;

$res = w-rebase :num-i('8hf3dd4i1gc8'), :base-i(19), :base-o(10);
is $res.Numeric, '1041053707916282'.Numeric;

$res = w-rebase :num-i('1041053707916282'), :base-i(10), :base-o(19);
is $res.Numeric, '8hf3dd4i1gc8'.Numeric;

$res = w-rebase :num-i('-6g1f775b6d51d'), :base-i(19), :base-o(10);
is $res.Numeric, '-15154830443875840'.Numeric;

$res = w-rebase :num-i('-15154830443875840'), :base-i(10), :base-o(19);
is $res.Numeric, '-6g1f775b6d51d'.Numeric;

$res = w-rebase :num-i('9ig3ee4j1hd8'), :base-i(20), :base-o(10);
is $res.Numeric, '2035807631855068'.Numeric;

$res = w-rebase :num-i('2035807631855068'), :base-i(10), :base-o(20);
is $res.Numeric, '9ig3ee4j1hd8'.Numeric;

$res = w-rebase :num-i('-7h1g776c7e51e'), :base-i(20), :base-o(10);
is $res.Numeric, '-32172220583634034'.Numeric;

$res = w-rebase :num-i('-32172220583634034'), :base-i(10), :base-o(20);
is $res.Numeric, '-7h1g776c7e51e'.Numeric;

$res = w-rebase :num-i('9jg4ef4k1id9'), :base-i(21), :base-o(10);
is $res.Numeric, '3482301537623442'.Numeric;

$res = w-rebase :num-i('3482301537623442'), :base-i(10), :base-o(21);
is $res.Numeric, '9jg4ef4k1id9'.Numeric;

$res = w-rebase :num-i('-7i1h876c7f51e'), :base-i(21), :base-o(10);
is $res.Numeric, '-57826285986839678'.Numeric;

$res = w-rebase :num-i('-57826285986839678'), :base-i(10), :base-o(21);
is $res.Numeric, '-7i1h876c7f51e'.Numeric;

$res = w-rebase :num-i('akh4ff5l1je9'), :base-i(22), :base-o(10);
is $res.Numeric, '6395163696912945'.Numeric;

$res = w-rebase :num-i('6395163696912945'), :base-i(10), :base-o(22);
is $res.Numeric, 'akh4ff5l1je9'.Numeric;

$res = w-rebase :num-i('-8j1i886d7f61f'), :base-i(22), :base-o(10);
is $res.Numeric, '-113990819254851125'.Numeric;

$res = w-rebase :num-i('-113990819254851125'), :base-i(10), :base-o(22);
is $res.Numeric, '-8j1i886d7f61f'.Numeric;

$res = w-rebase :num-i('ali4gg5m1jea'), :base-i(23), :base-o(10);
is $res.Numeric, '10430845190615500'.Numeric;

$res = w-rebase :num-i('10430845190615500'), :base-i(10), :base-o(23);
is $res.Numeric, 'ali4gg5m1jea'.Numeric;

$res = w-rebase :num-i('-8k1j887d8g61g'), :base-i(23), :base-o(10);
is $res.Numeric, '-194449493875068673'.Numeric;

$res = w-rebase :num-i('-194449493875068673'), :base-i(10), :base-o(23);
is $res.Numeric, '-8k1j887d8g61g'.Numeric;

$res = w-rebase :num-i('bmj4hh5n1kfa'), :base-i(24), :base-o(10);
is $res.Numeric, '18184082866852978'.Numeric;

$res = w-rebase :num-i('18184082866852978'), :base-i(10), :base-o(24);
is $res.Numeric, 'bmj4hh5n1kfa'.Numeric;

$res = w-rebase :num-i('-8l1j987e8h61g'), :base-i(24), :base-o(10);
is $res.Numeric, '-324232710040921000'.Numeric;

$res = w-rebase :num-i('-324232710040921000'), :base-i(10), :base-o(24);
is $res.Numeric, '-8l1j987e8h61g'.Numeric;

$res = w-rebase :num-i('bnk4hi5o1lgb'), :base-i(25), :base-o(10);
is $res.Numeric, '28496507138310411'.Numeric;

$res = w-rebase :num-i('28496507138310411'), :base-i(10), :base-o(25);
is $res.Numeric, 'bnk4hi5o1lgb'.Numeric;

$res = w-rebase :num-i('-9l1k997f9h61h'), :base-i(25), :base-o(10);
is $res.Numeric, '-586682796048706917'.Numeric;

$res = w-rebase :num-i('-586682796048706917'), :base-i(10), :base-o(25);
is $res.Numeric, '-9l1k997f9h61h'.Numeric;

$res = w-rebase :num-i('cok5ii6p1mgb'), :base-i(26), :base-o(10);
is $res.Numeric, '47541928564249403'.Numeric;

$res = w-rebase :num-i('47541928564249403'), :base-i(10), :base-o(26);
is $res.Numeric, 'cok5ii6p1mgb'.Numeric;

$res = w-rebase :num-i('-9m1la97f9i71i'), :base-i(26), :base-o(10);
is $res.Numeric, '-939865538243784872'.Numeric;

$res = w-rebase :num-i('-939865538243784872'), :base-i(10), :base-o(26);
is $res.Numeric, '-9m1la97f9i71i'.Numeric;

$res = w-rebase :num-i('cpl5jj6p1nhb'), :base-i(27), :base-o(10);
is $res.Numeric, '72017761003016168'.Numeric;

$res = w-rebase :num-i('72017761003016168'), :base-i(10), :base-o(27);
is $res.Numeric, 'cpl5jj6p1nhb'.Numeric;

$res = w-rebase :num-i('-9n1maa8g9j71i'), :base-i(27), :base-o(10);
is $res.Numeric, '-1479086697213538839'.Numeric;

$res = w-rebase :num-i('-1479086697213538839'), :base-i(10), :base-o(27);
is $res.Numeric, '-9n1maa8g9j71i'.Numeric;

$res = w-rebase :num-i('dpm5jk6q1oic'), :base-i(28), :base-o(10);
is $res.Numeric, '115455423408218948'.Numeric;

$res = w-rebase :num-i('115455423408218948'), :base-i(10), :base-o(28);
is $res.Numeric, 'dpm5jk6q1oic'.Numeric;

$res = w-rebase :num-i('-ao1naa8gak71j'), :base-i(28), :base-o(10);
is $res.Numeric, '-2521770296451420831'.Numeric;

$res = w-rebase :num-i('-2521770296451420831'), :base-i(10), :base-o(28);
is $res.Numeric, '-ao1naa8gak71j'.Numeric;

$res = w-rebase :num-i('dqn5kk6r1pic'), :base-i(29), :base-o(10);
is $res.Numeric, '169881537645692824'.Numeric;

$res = w-rebase :num-i('169881537645692824'), :base-i(10), :base-o(29);
is $res.Numeric, 'dqn5kk6r1pic'.Numeric;

$res = w-rebase :num-i('-ap1oba8hak81k'), :base-i(29), :base-o(10);
is $res.Numeric, '-3843935135258206321'.Numeric;

$res = w-rebase :num-i('-3843935135258206321'), :base-i(10), :base-o(29);
is $res.Numeric, '-ap1oba8hak81k'.Numeric;

$res = w-rebase :num-i('ero5ll7s1pjd'), :base-i(30), :base-o(10);
is $res.Numeric, '264425177271830083'.Numeric;

$res = w-rebase :num-i('264425177271830083'), :base-i(10), :base-o(30);
is $res.Numeric, 'ero5ll7s1pjd'.Numeric;

$res = w-rebase :num-i('-aq1obb9ial81l'), :base-i(30), :base-o(10);
is $res.Numeric, '-5776062546677074251'.Numeric;

$res = w-rebase :num-i('-5776062546677074251'), :base-i(10), :base-o(30);
is $res.Numeric, '-aq1obb9ial81l'.Numeric;

$res = w-rebase :num-i('esp6lm7t1qkd'), :base-i(31), :base-o(10);
is $res.Numeric, '379334974002590372'.Numeric;

$res = w-rebase :num-i('379334974002590372'), :base-i(10), :base-o(31);
is $res.Numeric, 'esp6lm7t1qkd'.Numeric;

$res = w-rebase :num-i('-br1pcb9ibm81l'), :base-i(31), :base-o(10);
is $res.Numeric, '-9351810662562859617'.Numeric;

$res = w-rebase :num-i('-9351810662562859617'), :base-i(10), :base-o(31);
is $res.Numeric, '-br1pcb9ibm81l'.Numeric;

$res = w-rebase :num-i('ftp6mn7u1rke'), :base-i(32), :base-o(10);
is $res.Numeric, '573970039831588494'.Numeric;

$res = w-rebase :num-i('573970039831588494'), :base-i(10), :base-o(32);
is $res.Numeric, 'ftp6mn7u1rke'.Numeric;

$res = w-rebase :num-i('-bs1qcb9jbn81m'), :base-i(32), :base-o(10);
is $res.Numeric, '-13692997143197622326'.Numeric;

$res = w-rebase :num-i('-13692997143197622326'), :base-i(10), :base-o(32);
is $res.Numeric, '-bs1qcb9jbn81m'.Numeric;

$res = w-rebase :num-i('fuq6nn7v2sle'), :base-i(33), :base-o(10);
is $res.Numeric, '805295114548762082'.Numeric;

$res = w-rebase :num-i('805295114548762082'), :base-i(10), :base-o(33);
is $res.Numeric, 'fuq6nn7v2sle'.Numeric;

$res = w-rebase :num-i('-cs1rccajbn91n'), :base-i(33), :base-o(10);
is $res.Numeric, '-21432655252881155900'.Numeric;

$res = w-rebase :num-i('-21432655252881155900'), :base-i(10), :base-o(33);
is $res.Numeric, '-cs1rccajbn91n'.Numeric;

$res = w-rebase :num-i('fvr6oo7w2tmf'), :base-i(34), :base-o(10);
is $res.Numeric, '1118479736511095775'.Numeric;

$res = w-rebase :num-i('1118479736511095775'), :base-i(10), :base-o(34);
is $res.Numeric, 'fvr6oo7w2tmf'.Numeric;

$res = w-rebase :num-i('-ct1sdcakco91n'), :base-i(34), :base-o(10);
is $res.Numeric, '-30676312985346380381'.Numeric;

$res = w-rebase :num-i('-30676312985346380381'), :base-i(10), :base-o(34);
is $res.Numeric, '-ct1sdcakco91n'.Numeric;

$res = w-rebase :num-i('gws6op8x2umf'), :base-i(35), :base-o(10);
is $res.Numeric, '1635281972985990785'.Numeric;

$res = w-rebase :num-i('1635281972985990785'), :base-i(10), :base-o(35);
is $res.Numeric, 'gws6op8x2umf'.Numeric;

$res = w-rebase :num-i('-cu1tddalcp91o'), :base-i(35), :base-o(10);
is $res.Numeric, '-43452195149041737334'.Numeric;

$res = w-rebase :num-i('-43452195149041737334'), :base-i(10), :base-o(35);
is $res.Numeric, '-cu1tddalcp91o'.Numeric;

$res = w-rebase :num-i('gxt7pp8y2vnf'), :base-i(36), :base-o(10);
is $res.Numeric, '2229567490575720123'.Numeric;

$res = w-rebase :num-i('2229567490575720123'), :base-i(10), :base-o(36);
is $res.Numeric, 'gxt7pp8y2vnf'.Numeric;

$res = w-rebase :num-i('-dv1tedbldpa2p'), :base-i(36), :base-o(10);
is $res.Numeric, '-65685872153984995393'.Numeric;

$res = w-rebase :num-i('-65685872153984995393'), :base-i(10), :base-o(36);
is $res.Numeric, '-dv1tedbldpa2p'.Numeric;


done-testing;
