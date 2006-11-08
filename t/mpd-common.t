#!/usr/bin/env  perl
use Data::Dumper;

use Test::More tests => 9;

use_ok('Parallel::Mpich::MPD' );


#$Parallel::Mpich::MPD::Common::DEBUG=1;
#$Parallel::Mpich::MPD::Common::WARN=1;


sub testExec{
  my $cmd=shift;
  my $out="";
  my $pid="";
  my $err="";
  my $ret=Parallel::Mpich::MPD::Common::__exec($cmd,\$out,\$err,\$pid);
  return $ret;
}


my $stderr="";
ok(Parallel::Mpich::MPD::Common::__exec(cmd => "which bash")==0, "check good __exec");
ok(Parallel::Mpich::MPD::Common::__exec(cmd => "which basht")==1, "check wrong __exec");
ok(Parallel::Mpich::MPD::Common::__exec(cmd => "ls rekjf", stderr =>\$stderr)==2, "check wrong __exec");

#
ok(Parallel::Mpich::MPD::Common::__exec(cmd => "ls rekjf 2>/dev/null", spawn=>1)==0, "check wrong __exec with spawn");

#
my $out="";
my $err="";
my $pid ="";
Parallel::Mpich::MPD::Common::__exec(cmd => "ls rekjf", stdout =>\$out, stderr => \$err, pid => \$pid );
print "out=$out\n\n";
ok($out eq "", " out eq ''\n");

print "err=$err\n\n";
ok($err ne "", " out ne ''\n");
print "pid=$pid\n\n";
ok($pid ne "", " pid ne ''\n");

ok(Parallel::Mpich::MPD::Common::cleanTemp(),"clean tmp data");