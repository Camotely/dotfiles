#!/bin/bash

## Grows rapidly and /etc/X11/Xsession did nothing
## So at least until I figure that out

rm $HOME/.xsession-errors .xsession-errors.old
ln -s /dev/null $HOME/.xsession-errors
