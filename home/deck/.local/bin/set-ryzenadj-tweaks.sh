#!/bin/sh
set -eu

allow=$(</home/deck/.local/bin/allowadj.txt)
experimental=$(</home/deck/.local/bin/experimentaladj.txt)

# https://github.com/NGnius/PowerTools/issues/84#issuecomment-1482736698
# https://www.amd.com/system/files/documents/faq-curve-optimizer.pdf
# Expect your UV to be 3-5x your set curve value. IE: -5 = -15mv to -25mv

if [[ $allow = "1" ]]
then
    if [[ $experimental = "1" ]]
    then
        echo "0" > /home/deck/.local/bin/experimentaladj.txt

        # Put experimental settings here - these
        # will not be restored at next startup

        # CPU
        # 0x100000 - 15 (Range: -30, 30)
        /home/deck/.local/bin/ryzenadj --set-coall=0xFFFF0

        # GPU
        # 0x100000 - 15 (Range: -30, 30)
        /home/deck/.local/bin/ryzenadj --set-cogfx=0xFFFF0

        echo "Experimental on" > /home/deck/.local/bin/statusadj.txt
    else
        # Put verified settings here.
        # WARNING: when service is enabled these will be restored
        # at next startup and can make your device unaccessible until you
        # repair/reimage your deck!

        # CPU
        # 0x100000 - 5 (Range: -30, 30)
        /home/deck/.local/bin/ryzenadj --set-coall=0xFFFFB

        # GPU
        # 0x100000 - 5 (Range: -30, 30)
        /home/deck/.local/bin/ryzenadj --set-cogfx=0xFFFFB

        echo "Undervolt on" > /home/deck/.local/bin/statusadj.txt
    fi
else
    # Put default values here so the off.sh script can disable your tweaks.
    # If you have experimental settings you forget to restore here a restart
    # of your deck will also put the values back to default

    # CPU
    # 0x100000 - 0
    /home/deck/.local/bin/ryzenadj --set-coall=0x100000

    # GPU
    # 0x100000 - 0
    /home/deck/.local/bin/ryzenadj --set-cogfx=0x100000

    echo "Undervolt off" > /home/deck/.local/bin/statusadj.txt
fi
