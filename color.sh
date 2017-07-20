# Colors
COL_RESET=$'\e[39;49;00m'
RED=$'\e[31;01m'
GREEN=$'\e[32;01m'
YELLOW=$'\e[33;01m'
BLUE=$'\e[34;01m'
MAGENTA=$'\e[35;01m'
CYAN=$'\e[36;01m'


# @info:    Prints error messages
# @args:    error-message
echoError ()
{
  echo "\033[0;31mFAIL\n\n$1 \033[0m"
}

# @info:    Prints warning messages
# @args:    warning-message
echoWarn ()
{
  echo "\033[0;33mWarning: \033[0m$1"
}

# @info:    Prints success messages
# @args:    success-message
echoSuccess ()
{
  echo "\033[0;32m$1 \033[0m"
}

# @info:    Prints check messages
# @args:    success-message
echoInfo ()
{
  echo "\033[1;34m===> \033[0m$1"
}

# @info:    Prints property messages
# @args:    property-message
echoProperties ()
{
  echo "\t\033[0;35m- $1 \033[0m"
}
