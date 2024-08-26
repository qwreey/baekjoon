package Readdir;

sub readdir(@$entry){
    $dir=$_[1];
    opendir my$dh, $dir or die "Couldn't open dir '$dir': $!";
    @l=grep{$_ ne '.' && $_ ne'..'}readdir$dh;
    $_[0][$_]=$l[$_]for(0..$#l);
    closedir $dh;
}

1;
