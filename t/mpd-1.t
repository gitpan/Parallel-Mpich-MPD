#!/usr/bin/env  perl
use Data::Dumper;

use Test::More tests => 1;

use_ok('Parallel::Mpich::MPD');

my ($cmd, $parms)=0?("burncpu.pl", "--time=20 --cpu=1"):("sleep", "20");


### THIS TEST COULD BE AUTOMATIZED
exit;
#$Parallel::Mpich::MPD::Common::DEBUG=1;
#$Parallel::Mpich::MPD::Common::WARN=1;
my $jobs;
my $job;

#ok(defined(Parallel::Mpich::MPD::Common::env_User("evaleto")),"start mpd for user evaleto");
ok(Parallel::Mpich::MPD::Common::env_Check(), "check environment");
ok(Parallel::Mpich::MPD::Common::env_Print(), "print environment");



print "#\n";
print "#\n";
print "# mpd test\n";
ok(Parallel::Mpich::MPD::boot(), "boot mpd if not already up");
#ok(print Parallel::Mpich::MPD::check(), "check mpd if not already up");
my $alias1=Parallel::Mpich::MPD::makealias();
ok(Parallel::Mpich::MPD::createJob(cmd => $cmd, params => $parms, ncpu => '2', alias => $alias1), "create a new job $alias1");
my $alias2=Parallel::Mpich::MPD::makealias();
ok(Parallel::Mpich::MPD::createJob(cmd => $cmd, params => $parms, ncpu => '2', alias => $alias2), "create a new job $alias2");
ok(defined(Parallel::Mpich::MPD::listJobs()), "get all jobs information");

print "#\n";
print "#\n";
print "# find one job\n"; 
ok(defined($job=Parallel::Mpich::MPD::findJob(jobalias => $alias1, getone => '1')), "find a job information");
print "JOB=".$job."\n";




ok($job->sigstop(),"stop the current job for 8 sec.");
ok($job->sigcont(),"continue the current job");
ok($job->kill(),"kill the current job");
my $trace="";
ok(Parallel::Mpich::MPD::trace(\$trace), "trace jobs");
#print "Parallel::Mpich::MPD::trace()-->".$trace."\n";
#ok(Parallel::Mpich::MPD::clean(), "clean jobs");
ok(Parallel::Mpich::MPD::shutdown(), "shutdown mpd");

