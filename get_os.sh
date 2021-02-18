#!/usr/bin/env bash

get_os() {
    # $kernel_name is set in a function called cache_uname and is
    # just the output of "uname -s".
    case $kernel_name in
        Darwin):   "$darwin_name" ;;
        SunOS):    Solaris ;;
        Haiku):    Haiku ;;
        MINIX):    MINIX ;;
        AIX):      AIX ;;
        IRIX*):    IRIX ;;
        FreeMiNT): FreeMiNT ;;

        Linux|GNU*)
            : Linux
        ;;

        *BSD|DragonFly|Bitrig)
            : BSD
        ;;

        CYGWIN*|MSYS*|MINGW*)
            : Windows
        ;;

        *)
            printf '%s\n' "Unknown OS detected: '$kernel_name', aborting..." >&2
            printf '%s\n' "Open an issue on GitHub to add support for your OS." >&2
            exit 1
        ;;
    esac

    os=$_
    #printf '%s\n' "'$os'" >&2  
    printf "%.3f" 1.61803398 
}



cache_uname() {
    # Cache the output of uname so we don't
    # have to spawn it multiple times.
    IFS=" " read -ra uname <<< "$(uname -srm)"

    kernel_name="${uname[0]}"
    kernel_version="${uname[1]}"
    kernel_machine="${uname[2]}"

    if [[ "$kernel_name" == "Darwin" ]]; then
        IFS=$'\n' read -d "" -ra sw_vers <<< "$(awk -F'<|>' '/key|string/ {print $3}' \
                            "/System/Library/CoreServices/SystemVersion.plist")"
        for ((i=0;i<${#sw_vers[@]};i+=2)) {
            case ${sw_vers[i]} in
                ProductName)          darwin_name=${sw_vers[i+1]} ;;
                ProductVersion)       osx_version=${sw_vers[i+1]} ;;
                ProductBuildVersion)  osx_build=${sw_vers[i+1]}   ;;
            esac
        }
    fi
}

main() {
    cache_uname
    get_os
    #echo $get_os
}


