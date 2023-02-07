#!/bin/bash -e


BASEDIR=`dirname $0`  # careful, this is good enough for my use

V=`[[ "$1" == -v ]] && echo 1 || echo`
if [[ "$V" ]] ; then shift ; fi

# using DB features breaks tests
DB=`[[ "$1" == -d ]] && echo -d || echo`
if [[ "$DB" ]] ; then shift ; fi

# exceptional conditions only occur in the
# interpreter so they are not considered


# the first three functions must be first
function test {
  if [[ "$V" ]] ; then
    echo ${FUNCNAME[1]}
  fi
  local r s in out
  in="$1"$'\n'"$2"$'\n'
  if [[ "$1" != "$2" ]] ; then
    out=$'\e[31m-\e[0m '"$1"$'\n\e[32m+\e[0m '"$2"  # magic!
  fi
  if
    r="`2>&1 "$BASEDIR"/bf $DB "$BASEDIR"/compare-string.bf  <<< "$in"`" \
    && r=${r/<<< <<< }  # magic!
  then
    if ! [[ "$r" == "$out" ]] ; then
      {
        echo $'\e[31m* fail\e[0m' ${FUNCNAME[1]}
        echo expected:
        echo -n "${out:+$out$'\n'}"
        echo received:
        echo -n "${r:+$r$'\n'}"
      } >&2
      s=1
    fi
  else
    s=$?
    echo "$r" >&2
  fi
  return $s
}


function ctrl {
  for ((i=0; i<${2:-1}; i++)) ; do
    builtin echo -en "\x$1"
  done
}


function run {
  local r="$*"
  eval "${r// /;}"
}


function all {
  local r
  r=`declare -F`
  r=( ${r//declare -f} )
  run ${r[*]:3}  # this adds two yet informative frames to the call stack
}


# todo: test non [:alpha:] chars? shouldn't make a difference...
#       but now, they're handled to i'd like to do
# realization: these should have been an associative array
# comparison is from end to start so overlap is at the end
function s1_empty-s2_empty { test '' '' ; }
function s1_1-s2_empty { test a '' ; }
function s1_2-s2_empty { test ab '' ; }
function s1_3-s2_empty { test abc '' ; }
function s1_4-s2_empty { test abcd '' ; }
function s1_many-s2_empty { test abcdefghijklm '' ; }
function s1_empty-s2_1 { test '' a ; }
function s1_empty-s2_2 { test '' ab ; }
function s1_empty-s2_3 { test '' abc ; }
function s1_empty-s2_4 { test '' abcd ; }
function s1_empty-s2_many { test '' abcdefghijklm ; }
function s1_1-s2_same { test a a ; }
function s1_1-s2_1-diff { test a b ; }
function s1_2-s2_same { test ab ab ; }
function s1_2-s2_2_diff { test ab cd ; }
function s1_3-s2_same { test abc abc ; }
function s1_3-s2_3_diff { test abc def ; }
function s1_4-s2_same { test abcd abcd ; }
function s1_4-s2_4_diff { test abcd efgh ; }
function s1_many-s2_same { test abcdefghijklm abcdefghijklm ; }
function s1_many-s2_many_diff { test abcdefghijklm nopqrstuvwxyz ; }
function s1-longer-than-s2-overlap_1 { test abcd bcd ; }
function s1-longer-than-s2-overlap_2 { test abcde cde ; }
function s1-longer-than-s2-overlap_3 { test abcdef def ; }
function s1-longer-than-s2-overlap_4 { test abcdefg efg ; }
function s1-longer-than-s2-overlap_many { test abcdefghijklm klm ; }
function s1-shorter-than-s2-overlap_1 { test bcd abcd ; }
function s1-shorter-than-s2-overlap_2 { test cde abcde ; }
function s1-shorter-than-s2-overlap_3 { test def abcdef ; }
function s1-shorter-than-s2-overlap_4 { test efg abcdefg ; }
function s1-shorter-than-s2-overlap_many { test klm abcdefghijklm ; }
# todo: ...
function ctrlchars { test `ctrl 01`  `ctrl 01`  ; }
function ctrlcharss { test `ctrl 01 2`  `ctrl 01 2`  ; }
function ctrlcharsss { test `ctrl 01 3`  `ctrl 01 3`  ; }
function ctrlcharssss { test `ctrl 02 4`  `ctrl 01 4`  ; }
function ctrlcharsssss { test $'\00\00\00' $'\00\00\00' ; }


run ${*:-all}
