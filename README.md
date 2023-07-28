# Steam Deck Software Undervolt
This repository offers an easy way to undervolt a Steam Deck as safely as possible and without entering the BIOS or disabling read-only using [RyzenAdj](https://github.com/FlyGoat/RyzenAdj) and systemd targets based on [Chris Down's guide](https://chrisdown.name/2017/10/29/adding-power-related-targets-to-systemd.html). 

A precompiled version of RyzenAdj is provided for your convenience, built in Arch Linux from commit `f6fbf9d17f70d9736bc8294ccd8438ae94804aa9`.

## Warning

As with any undervolt exercise caution, while this project greatly reduces the risk of bricking your deck, it does not in any way guarantee you won't damage your hardware. Use at your own risk.

## Installation
Clone this repository, with the repository root folder as current folder make the script `install.sh` executeable with `chmod +x install.sh`and run it with root privileges: `sudo ./install.sh`

It will install a new service `set-ryzenadj-tweaks.service`, create some additional service activation rules, and copy a bunch of files to the `/home/deck/.local/bin` folder.


Undervolt amount can be changed by editing `/home/deck/.local/bin/set-ryzenadj-tweaks.sh`

By default a `-5` [curve optimization](https://www.amd.com/system/files/documents/faq-curve-optimizer.pdf) is applied *(via `-set-coall`)*, in the 'undervolt-on' section which should be stable on most hardware.

A much more ambitious `-15` curve optimization is applied in the `experimental` setting. This setting might be stable but it might also cause a crash/hang if applied.

## Activation

By default no undervolt is applied until you run either the `on.sh` or the `experimental.sh` scripts:

#### The on, off, and experimental scripts
Add `on.sh`, `off.sh`, and `experimental.sh` from the `/home/deck/.local/bin` folder as non-steam apps and run them from game mode to control undervolt status.
* `on.sh` enables undervolt in the `undervolt-on` section. This setting will be restored if you restart your deck unless you have run the `off.sh` script before restart.
* `experimental.sh` enables undervolt in the `experimental` section. The experimental setting is applied only once and is not restored if you restart your steam deck.
* `off.sh` disables undervolt.

## Uninstall
If you don't want to undervolt anymore you can uninstall the service `set-ryzenadj-tweaks.service`, the additional service activation roles, and delete the files from `/home/deck/.local/bin` via the uninstall.sh script.
With the repository root folder as current folder make the script `uninstall.sh` executable with `chmod +x uninstall.sh` and run it with root privileges: `sudo ./uninstall.sh`
