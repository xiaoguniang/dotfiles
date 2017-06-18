Keep backup of dotfiles

## Install
./dotfiles install

## Backup to github
./dotfiles push

## Hardlink on osx
https://github.com/selkhateeb/hardlink

- hln src dst
- hln -u dst

## Encryped private files
Using [git-crypt](https://github.com/AGWA/git-crypt)

- git-crypt init
- git-crypt export-key /path/to/key
- git-crypt unlocak /path/to/key
- git-crypt status -e
