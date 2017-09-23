#!/bin/bash

erl \
   -name vm@127.0.0.1 \
   -setcookie nocookie \
   -kernel inet_dist_listen_min 32199 \
   -kernel inet_dist_listen_max 32199 \
   -noshell
