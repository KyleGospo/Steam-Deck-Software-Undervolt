# Steam Deck Software Undervolt
This repository offers an easy way to undervolt a Steam Deck as safely as possible and without entering the BIOS or disabling read-only using [RyzenAdj](https://github.com/FlyGoat/RyzenAdj) and systemd targets based on [Chris Down's guide](https://chrisdown.name/2017/10/29/adding-power-related-targets-to-systemd.html). 

A precompiled version of RyzenAdj is provided for your convenience, built in Arch Linux from commit `f6fbf9d17f70d9736bc8294ccd8438ae94804aa9`.

## Warning

As with any undervolt exercise caution, while this project greatly reduces the risk of bricking your deck, it does not in any way guarantee you won't damage your hardware. Use at your own risk.

## Installation

Inside this repository is a `home` and `etc` folder, use this as a template to add these files to the root of your Steam Deck *(You will need root to add files to the etc folder, and they will survive SteamOS updates)*. The file `allowadj.txt` must be writable by deck user and the files `on.sh` and `off.sh` must be executable by deck user.

Once completed, run the following to apply the added udev config:
`sudo udevadm control --reload-rules`

The undervolt amount can be changed by editing `/home/deck/.local/bin/set-ryzenadj-tweaks.sh`

By default a `-5` [curve optimization](https://www.amd.com/system/files/documents/faq-curve-optimizer.pdf) is applied *(via `-set-coall`)*, which should be stable on most hardware.

## Activation

#### Ad-hoc on and off scripts
In order to enable the `on.sh`and `off.sh`scripts that allows you to enable and disable undervolt from game mode run the following to apply the path listener:
`systemctl enable --now set-ryzenadj-tweaks.path`

Having done that you can add `on.sh`and `off.sh` as non-steam apps and run them from game mode to control undervolt status. Useful to see effect of undervolt quickly.

#### To apply the undervolt until next restart, run the following:
`sudo systemctl start set-ryzenadj-tweaks.service`

#### Once you're happy with the undervolt and confirmed it's stable, run the following to ensure the undervolt is reapplied automatically going forward:
`sudo systemctl enable set-ryzenadj-tweaks.service`
