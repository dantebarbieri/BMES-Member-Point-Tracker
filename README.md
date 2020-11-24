# BMES-Member-Point-Tracker

## How to
### Execute the Code
First time setup should be done by executing the following commands:
```bash
git clone git@github.com:pulchroxloom/BMES-Member-Point-Tracker.git &&
cd ./BMES-Member-Point-Tracker.git &&
bundle install &&
yarn check --integrity &&
rails db:setup &&
```
The `&&` enable the above to be copy-pasted.

This clones the repository and sets up the database. You will need to run `rails db:create && rails db:migrate` if `rails db:setup` is producing errors. This is because Rails will try to use the `schema.rb` file which may change in configuration between different Rails versions.

To run a local server, simply run `rails server` which will start Puma on http://localhost:3000/ and it is at that link that the page is accessible. Synchronisation will not work unless you are on a `cron`-capable machine and run the following command: `whenever --update-crontab --set environment='development'`. The above scripts have assumed that you have `rails`, `yarn`, `git`, and `bundler` installed and added to your path. The syntax `&&` for the create and migrate command assumes a bash-like grammar and may not work on shells such as `fish`.

### Deploy the Code in Heroku
You can use the Heroku CLI but it is easiest to connect a repository to Heroku through their website and to enable auto-deploy whenever a branch is pushed to. Deploys were exclusively done as code was pulled into `master` during the development of BMES Member Point Tracker.

### Perform CI
This can be done with GitHub Actions and [Dante](https://github.com/pulchroxloom) configured some YAML to do this but it isn't fully working as desired. Alternatively, Heroku allows you to pay them and they will conduct CI. You should manually run `rspec` on every PR before merging it in order to verify testing accuracy.

### Security
Security is done through Auth0 at the domain https://bmes-member-tracker.us.auth0.com. This enables our app to store minimal secure information and therefore has little value. Security testing was done using Brakeman. Some tests determining whether page access is limited correctly are part of `rspec` so it should be run as well. In general, due to the small number of secure data stored in the app, there is little of value and what is stored is protected properly.

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


