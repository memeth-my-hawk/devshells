# devshells
Instant, temporary development shells with nix (WIP)

---

Even if this is a personal convenience project/tool, it can be easily modified and used wherever NixOS or Nix package manager (theoretically, just in case you are not on NixOS and still want to use this) are available with flakes and nix command enabled. 

## Why?

I use NixOS and i quite like it. I am a statistics student and I normally have common, general purpose statistics tools like R, RStudio and Python and some of their libraries installed on my system. However, they take a lot of time and power to get compiled at updates (looking at you tidyverse) and since I like using an unstable, rolling release system, these updates occur quite often. With these shell setups, I can have keep my OS footprint to a minimum in terms of storage (by not having them installed by default and cleaned once in a while) and power consumption (by having them on demand), and still have instant access to my favourite tools. This is applicable for other use cases such as creating documents with pandoc and LaTeX. Here's how devshells work with an example of ```stats-shell```:

- clone this repo on your machine with either NixOS or Nix (theoretically on Linux, not tested for MacOS) and enable nix command and flakes
- edit ```stats-shell/flake.nix``` according to your needs
- run ```nix develop $HOME/devshells/stats-shell``` (assuming you are at ```$HOME```, or wherever you have cloned it)
- it will take some time to initialize for the first time, download and cache the packages etc.
- once it is ready, you will see a shell prompt as ```(stats-shell)```
- this is just regular bash with now R, RStudio, Python and some of their libraries available to you
- just run ```exit``` to exit
- now you are at your regular shell and tools are gone! (or are they?)
- if you run ```nix develop $HOME/devshells/stats-shell``` again, the shell will take only a second or two to come up

This project will be enhanced over time, new shells will be added, flakes will be optimized and purer (in terms of doing things the Nix way, this whole project is me trying to do things more Nix way). Clone and play with it, let me know what happens, what works or not.

