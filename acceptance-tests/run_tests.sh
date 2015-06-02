#################################################################################################
### This script is used to run any acceptance tests in the repository. It saves time and      ###
### confusion of executing any setup before the tests are run by including it all in one      ###
### handy script.                                                                             ###
#################################################################################################

#!/bin/bash

currentLocation="$(cd "$(dirname "$0")"; pwd)"

set -e

### Remove any test failure screenshots from previous runs.
rm -f sshot*

### Installs any gems specified in the gemfile.
bundle install --gemfile=$currentLocation/Gemfile

if [ -z "$1"]
  then
  ### If no arguments supplied when running this script then execute the following code.
  cucumber $currentLocation --tags ~@wip
else
  ### If arguments are supplied when running this script then depending on the arguments execute the following code.
  cucumber $currentLocation $1
fi
