#!/bin/sh
set -eu

allow=$(</home/deck/.local/bin/allowadj.txt)

# https://github.com/NGnius/PowerTools/issues/84#issuecomment-1482736698
# https://www.amd.com/system/files/documents/faq-curve-optimizer.pdf
# Expect your UV to be 3-5x your set curve value. IE: -5 = -15mv to -25mv

# CPU
# 0x100000 - 22 (Range: -30, 30)
if [[$allow = "1"]]
then 
    # 0x100000 - 22 (Range: -30, 30)
    /home/deck/.local/bin/ryzenadj --set-coall=0xFFFED
else
    # 0x100000 - 0
    /home/deck/.local/bin/ryzenadj --set-coall=0x100000
fi

# GPU - Not functional
# 0x100000 - 5 (Range: -30, 30)
#/home/deck/.local/bin/ryzenadj --set-cogfx=0xFFFFB
