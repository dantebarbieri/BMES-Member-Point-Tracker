# BMES-Member-Point-Tracker

## GitHub/Git Information
### Master/Develop Protections
`master` and `develop` are protected and cannot be pushed to. You have to push into a different branch and then create a PR that must receive at least 1 approval before you can merge/rebase. This is for protection and should improve code quality at the possible cost of speed.

### Conflict Resolution
The default resolution in `git` is merge with fast-forward, but I find rebase to be more intuitive. Here's information on rebase: https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase

### Branch Naming Conventions
Branch names should follow the general pattern of:
```
who-you-are/what-you're-doing
```
Example:
```
dante/database-config
```

### SSH Keys
Please create an SSH key if you plan on using git much at all, it is easy to do and will simplify your life. Here's the GitHub Tutorial on how to do it:
https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh

### GPG Keys
If you are willing to create and register a GPG key, I highly recommend it. It allows you to verify that you are the one who completed your work. I sign all of my commits with a GPG key. Here's how to generate your own:
https://docs.github.com/en/github/authenticating-to-github/managing-commit-signature-verification

## Ruby Versioning
You will need to install ruby 2.7.1 with the devkit to most easily use the rails application.
Download here: https://rubyinstaller.org/downloads/

Once you have ruby 2.7.1 installed, clone this repo, and run bundle install.
You may also be asked to run the following command:
yarn install --check-files


