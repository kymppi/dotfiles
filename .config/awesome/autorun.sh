#!/usr/bin/env bash

function run {
  if ! pgrep $1 ; then
    $@&
  fi
}

run nitrogen --restore
run ckb-next-daemon
run ckb-next
run gnome-keyring-daemon
run xcompmgr &
run sxhkd &
run discord
run firefox
run xscreensaver
run breaktimer
run thunderbird
