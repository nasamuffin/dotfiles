#!/bin/bash

(
  cd t &&
  unbuffer ./*$1*.sh -i -x | less -r +G
)
