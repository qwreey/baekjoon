package Runtask;

use IPC::Open3;
use POSIX ":sys_wait_h";

sub runtask(@$te,@$t1s,@$t2s,@tc,@ti) {
    @tc=@{$_[3]};
    @ti=@{$_[4]};

    # Create children
    my@tp=map{
        open3 $t0->[$_],$t1->[$_],$t2->[$_],@{$tc[$_]} or die $!
    }my@t=my@te=my@t0=my@t1=my@t2=0..$#ti;

    # Write stdin
    print {$t0->[$_]} $ti[$_] for@t;
    close $t0->[$_] for@t;

    # Wait children
    my@te=map{
        sleep 0.01 until waitpid $tp[$_], WNOHANG;
        $?
    }@t;

    # Read stdout/stderr
    my@t1s=map{local$/;<$_>}@$t1;
    my@t2s=map{local$/;<$_>}@$t2;

    # Close stdout/stderr
    close $t1->[$_] for@t;
    close $t2->[$_] for@t;

    $_[0][$_]=$te[$_]for@t;
    $_[1][$_]=$t1s[$_]for@t;
    $_[2][$_]=$t2s[$_]for@t;
}

1;
