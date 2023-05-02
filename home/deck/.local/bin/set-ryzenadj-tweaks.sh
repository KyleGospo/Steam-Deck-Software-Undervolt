#!/bin/sh
set -eu

# https://github.com/NGnius/PowerTools/issues/84#issuecomment-1482736698

# CPU
# 0x100000 - 5 (Range: -30, 30)
/home/deck/.local/bin/ryzenadj --set-coall=1048571

# GPU
# 0x100000 - 5 (Range: -30, 30)
/home/deck/.local/bin/ryzenadj --set-cogfx=1048571
