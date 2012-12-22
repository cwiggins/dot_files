#!/usr/bin/env bash
# Open vimprobable instances in tabbed

exec vimprobable2 -e $(</tmp/tabbed.xid) "$1"
