#!/bin/bash

(
  cd t &&
  ./*$1*.sh -x -i
)
