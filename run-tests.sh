#!/bin/bash -eu

for t in tests/*; do
  cmd="$(head -1 $t)"
  expected="$(tail -1 $t | sed "s,\$HOME,$HOME,g")"

  echo -n "${t} ... "
  actual="$(eval TEST=1 PATH=.:${PATH} "${cmd}" 2>&1 | sed "s/.*Executing: //")"
  if echo "${actual}" | grep "^${expected}$" >/dev/null; then
    echo "ok"
  else
    echo "failed"
    echo
    echo -e "\tExpected: ${expected}"
    echo
    echo -e "\tActual:   ${actual}"
    echo
  fi
done
