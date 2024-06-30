<!--
 Copyright (C) 2024 Chris Laprade

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU Affero General Public License as
 published by the Free Software Foundation, either version 3 of the
 License, or (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU Affero General Public License for more details.

 You should have received a copy of the GNU Affero General Public License
 along with this program.   If not, see <https://www.gnu.org/licenses/>.
-->

# Hephaestus dotfiles

This repository contains the dotfiles for my personal Klipper printer.

It is a work in progress and is constantly being updated.

> **Note:** Nobody should try to use this repository as is.

See [my guide](https://github.com/rootiest/zippy_guides/guides/chezmoi) for more information on how to use chezmoi with your klipper configuration.

## What is Klipper?

[Klipper](https://klipper3d.org) is a 3D printer firmware that runs on
Linux-based systems with Python3 installed.

It is not a fork of Marlin or any other firmware,
but a completely different project that achieves many of the same goals.

Klipper's main advantage is that it offloads the calculations from the printer's
microcontroller to the host computer, which can be much more powerful.

Presumably, if you've found this repository, you already have some idea
of what Klipper is and how it works. You've likely come across my other
Klipper repositories and guides.

## What are dotfiles?

Dotfiles are configuration files that are used to customize the behavior of
programs and tools in Unix-like operating systems.

The name "dotfiles" comes from the fact that these files are _usually_ hidden
from view in the file manager because they start with a dot (`.`) or are in a
hidden directory.

Klipper does not place its configuration files in hidden directories,
but the term "dotfiles" is still used to refer to the configuration files
of the system.

## Why chezmoi?

[Chezmoi](https://www.chezmoi.io/) is a tool that helps manage dotfiles.

There are many such tools available, with varying levels of complexity and
features.

### Why not manually copy your config to another machine or external drive?

One can certainly do that.

The limitations of that solution are that it is manual and lacks any version
control.

If you make a change to your configuration, you need to remember to copy it
to your backup location.

If you realize later a change was a mistake, you need to manually revert it.

You won't have any history of changes or the ability to easily compare
different versions of your configuration.

### Why not just use git?

One could also simply push their Klipper config to a git repository and pull
it down on a new machine.

This is a simple and effective way to back up and restore your configuration.

The limitations of this solution are that it is not very flexible.

You must manually remember to scrub any sensitive information from your
configuration before pushing it to a public repository.

You could use a private repository, but then you won't be able to share your
beautiful configuration with others.

Virtually every distro comes with git installed, so this is a very accessible
solution.

However, you will need to manually install any other packages, using that distro's
package manager manually.

You also will quickly face a lot of complexity if you hope to manage directories
and files in other locations, or if you want to use templates to generate files.

### Why not another dotfiles manager?

There are many other dotfiles managers available.

Some popular ones include:

- [GNU Stow](https://www.gnu.org/software/stow/)
- [yadm](https://yadm.io/)
- [rcm](https://thoughtbot.github.io/rcm/)

All of these are also great options. Use the one that works best for you.

I chose chezmoi because I liked its feature set and found it easy to use.

Many other dotfile managers expect you to store the dotfiles in their directory and
then symlink them to the appropriate location.

chezmoi allows you to keep your dotfiles in their original location and symlink
them to the repository instead.

I found this to be a more intuitive and less confusing way to manage my dotfiles.

## Why this repository?

I created this repository to keep track of my printer dotfiles and to make it
easier to set up my own new machines.

It is public so I can share with others the tools and configurations I use.

This repository can be a great resource for inspiration or to copy from.
Both as a Klipper resource and as a learning tool for working with
dotfiles and chezmoi.

I intend to update this repository over time.
In the near-term, I plan on

- adding more configurations via dotfiles
- scripting functions with chezmoi
  - installing packages: initializing a new machine will also automatically
    install klipper, moonraker, and other software.
  - the OS and distro will be detected and the appropriate package manager will be used
- Secrets management: I will be using chezmoi to manage secrets
  - Files containing secrets will be encrypted with gpg
  - Secrets will mostly be kept in a single fish config file and shared via
    environment variables
  - The gpg key will be stored in a password manager
  - chezmoi will retrieve the key from the password manager and decrypt the files
  - This will allow me to keep my secrets in the repository without worrying
    about them being exposed

### So is this just a fancy way to backup my Klipper configuration?

Well.. it _can_ be. If that's all you want it to do.

I will certainly outline how to do so,
and include some quick-start scripts so if all you wish to do is quickly
and easily backup your Klipper configuration,
you can do so by following my guide.

But I will be including a _**lot**_ more than just the Klipper configuration in my
repository.

And I will also document how I did so and how you can do the same.

## Dotfiles Installation

> > **WARNING:** This repository is NOT intended for public use.
> >
> > If you follow the instructions below, you will likely make a mess of
> > your own dotfiles and Klipper configuration.

This repository is built with [chezmoi](https://www.chezmoi.io/).

To install the dotfiles, run the following command:

```sh
chezmoi init --apply https://github.com/rootiest/hephaestus_dotfiles.git
```

However,
as noted above,
**this repository is not intended for public use**
and you're likely instead to make a mess of (or replace!) your own dotfiles
and Klipper configuration.

These steps are included for reference only.

### Troubleshooting

In order for all of this to work,
you need to have chezmoi installed.

On my Klipper machine,
it was not available in the apt repositories
so I had to install it manually.

You may or may not experience similar issues
depending on your distribution.

These are the steps I took to get it running on my machine:

```sh
# Download and install the binary
sh -c "$(curl -fsLS get.chezmoi.io)"
```

According to the docs,
this is all you should need to do.

But in my cases I needed to symlink the binary to a directory in my `PATH`.

```sh
# Symlink the binary to a directory in your PATH
sudo ln -s /home/$USER/.bin/chezmoi /usr/local/bin/chezmoi
```

Now try running the following command:

```sh
chezmoi --version
```

If you see the version number, you're good to go!

To install my dotfiles, run the following command:

```sh
chezmoi init https://github.com/rootiest/hephaestus_dotfiles.git
```

This will clone the repository.

To view the changes that will be made, run the following command:

```sh
chezmoi diff
```

You will then be presented with all the changes that will be made.

There will likely be a lot, because running the next command will overwrite
your existing configuration with mine.

To apply the dotfiles, run the following command:
(again, please don't do this with my config
unless you know what you're doing!)

```sh
chezmoi apply
```

## Wiki and Guides

I will be creating a wiki for this repository that will contain information
on how to use chezmoi, how to set up a new machine, and how to use or replicate
the scripts I include.

I will also be documenting my own learning process with chezmoi and dotfiles.

Hopefully, this will be a useful resource for others who are interested in
using chezmoi and dotfiles.

The structure will be split between two main parts:

1. **Wiki Blog**: This will be a blog-style documentation of my learning process
   with chezmoi and dotfiles. I will document my successes, failures, and
   discoveries as I go along.

   This will be available in
   [this repository's wiki](http://github.com/rootiest/hephaestus_dotfiles/wiki).

2. **Guides**: This will be a more structured set of guides that will walk you
   through how to use chezmoi and dotfiles. It will include a quick-start guide
   for those who just want to back up their Klipper configuration, as well as
   more in-depth guides for those who want to use chezmoi for more complex
   configurations.

   This will be available in
   [my zippy-guides repository](https://github.com/rootiest/zippy_guides/guides/chezmoi).

   > **Note:** The guides and blog are not yet available.
   > I will update this README when they become available.

## Contributing

I am not currently accepting contributions to this repository specifically.

However, I am always open to feedback and suggestions, particularly with my
guides and other documentation.

I would also welcome any suggestions for how to improve my dotfiles and chezmoi
configuration.

I am also happy to help with any questions you may have about chezmoi or dotfiles
or Klipper. Feel free to reach out to me on Discord or via this repository's issue
tracker.

## License

This repository is licensed under the GNU Affero General Public License v3.0.
