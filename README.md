# Steam Deck Software Undervolt
This repository offers an easy way to undervolt a Steam Deck as safely as possible and without entering the BIOS or disabling read-only using [JamesCJ60's fork](https://github.com/JamesCJ60/RyzenAdj) of [RyzenAdj](https://github.com/FlyGoat/RyzenAdj) and systemd targets based on  [Chris Down's guide](https://chrisdown.name/2017/10/29/adding-power-related-targets-to-systemd.html). 

A precompiled version of JamesCJ60's fork is provided for your convenience.

## Installation

Inside this repository is a `home` and `etc` folder, use this as a template to add these files to the root of your Steam Deck *(You will need root to add files to the etc folder, and they will survive SteamOS updates)*.

Once completed, run the following to apply the added udev config:
`sudo udevadm control --reload-rules`

The undervolt amount can be changed by editing `/home/deck/.local/bin/set-ryzenadj-tweaks.sh`

By default a `-5` [curve optimization](https://www.amd.com/system/files/documents/faq-curve-optimizer.pdf) is applied *(via `-set-coall`)*, which should be stable on most hardware.

## Activation

#### To apply the undervolt, run the following:
`sudo systemctl start set-ryzenadj-tweaks.service`

#### Once you're happy with the undervolt and confirmed it's stable, run the following to ensure the undervolt is reapplied automatically going forward:
`sudo systemctl enable set-ryzenadj-tweaks.service`

## Warning

As with any undervolt exercise caution, while this project greatly reduces the risk of bricking your deck, it does not in any way guarantee you won't damage your hardware. Use at your own risk.
