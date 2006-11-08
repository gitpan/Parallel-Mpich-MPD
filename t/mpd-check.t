#!/usr/bin/env  perl
use Data::Dumper;

use Test::More tests => 5;
use File::Basename;

use_ok('Parallel::Mpich::MPD');



#$Parallel::Mpich::MPD::Common::DEBUG=1;
#$Parallel::Mpich::MPD::Common::WARN=1;

Parallel::Mpich::MPD::Common::env_MpichHome('/opt/mpich-2.1/');
ok(Parallel::Mpich::MPD::Common::env_Check(), "check environment");

Parallel::Mpich::MPD::Common::checkHosts();
my %info=Parallel::Mpich::MPD::info();

ok($info{port}=~/\S+/ , "checking mpd info :master $info{master} ");
ok($info{port}=~/\d{4}/ , "checking mpd info :port $info{port} ");
ok($info{hostname}=~/\S+/ , "checking mpd info :host $info{hostname}");

print Dumper(\%info);

my %hostsup=Parallel::Mpich::MPD::check(resize =>1);
#print Dumper(\%hostsup). " :";