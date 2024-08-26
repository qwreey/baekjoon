$ID:load(){
    lib:path-alloc2 PATH_$ID $DIR/bin :
    alias bjpull="$ID:BJPULLHOOK"
}
$ID:unload(){
    lib:path-free PATH_$ID
    unalias bjpull
}

$ID:BJPULLHOOK(){
    file=$(\bjpull "$@")
    code $file
    cd $(dirname "$file")
}
