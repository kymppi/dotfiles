#!/usr/bin/env bash

function run {
  if ! pgrep $1 ; then
    $@&
  fi
}

run nitrogen --restore
run ckb-next-daemon
run pulseaudio -D
run gnome-keyring-daemon
