#!/bin/bash -e

function test {
  #local r s in out
  in="$1"$'\n'"$2"$'\n'
  if [[ "$1" != "$2" ]] ; then
    out=$'\e[31m-\e[0m '"$1"$'\n\e[32m+\e[0m '"$2"
  fi
  if r="$(2>&1 \
    ~/Projects/Stuff/Gadgets/bf/bf \
    ~/Projects/Stuff/Gadgets/bf/compare-string.bf  <<< "$in"
  )"
  r=${r/<<< <<< }
  then
    if ! [[ "$r" == "$out" ]] ; then
      {
        echo $'\e[31m'fail$'\e[0m' ${FUNCNAME[1]}
        echo expected:
        echo -n "${out:+$out$'\n'}"
        echo received:
        echo -n "${r:+$r$'\n'}"
      } >&2
      return 1
    fi
  else
    s=$?
    echo "$r" >&2
  fi
  return $s
}


function s1_empty-s2_empty {
  test '' ''
}


function s1_1-s2_empty {
  test a ''
}


function s1_1-s2_same {
  test a a
}


function s1_1-s2_1-diff {
  test a b
}


function all {
  s1_empty-s2_empty
  s1_1-s2_empty
  s1_1-s2_same
  s1_1-s2_1-diff
}

${1:-all}
