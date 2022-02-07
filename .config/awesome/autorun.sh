#!/usr/bin/env bash

function run {
  if ! pgrep $1 ; then
    $@&
  fi
}

run nitrogen --restore
run ckb-next-daemon
run gnome-keyring-daemon
run xcompmgr &
run sxhkdd &
