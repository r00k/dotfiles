#compdef hk

# hk Autocomplete plugin for Oh-My-Zsh. To install it, drop this plugin into a
# file called `_hk` within /usr/local/share/zsh/site-functions or another
# directory in your $fpath.
#
# You'll also need to enable compinit. Oh-my-zsh does this for you by default:
# https://github.com/robbyrussell/oh-my-zsh/blob/master/oh-my-zsh.sh#L51-L53
#
# Finally, completion of arguments like app names works best if completion
# caching is enabled. Oh-my-zsh also does this for you:
# https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/completion.zsh#L34-L36
#
# Requires: The hk Heroku client (https://hk.heroku.com)
# Author: Blake Gentry (https://bgentry.io)

_hk_is_default_cloud() {
  ( [[ -z $HEROKU_API_URL ]] || [[ "https://api.heroku.com" == $HEROKU_API_URL ]] )
}

_hkcmdnames() {
  print -l ${(f)"$(hk help commands | cut -f 2 -d ' ')"}
}

_hkcmdnames_needing_app() {
  print -l ${(f)"$(hk help commands | grep -F '[-a <app>]' | cut -f 2 -d ' ')"}
}

_hkrawcmds() {
  print -l ${(f)"$(hk help commands)"}
}

__args_for_command() {
  for i in _hkrawcmds; do
    if [[ "${${=i}[2]}" == $line[1] ]]; then
      local arglist; arglist=()
      #for j in (${^${i#*${line}[1] }}); do
      # print -l ${=${i#*${${line}[1]} }}
      for j in ${=${${i#*${${line}[1]} }%*\#*}}; do
        arglist+=($j)
      done
      _describe -t opts 'opts' arglist && ret=0

      # _arguments \
      #   '-a:appname'
      # ret=0
      return
    fi
  done
}

###########################################################
##       Functions to get data from hk and cache it      ##
###########################################################

__hk_complete_addon_service_and_plan() {
  local -a suf
  if compset -P '*:'; then
    __hk_addon_plans ${IPREFIX%%\:*} # strip : from $IPREFIX to get provider
  else
    __hk_addon_services
  fi
}

__hk_addon_services() {
  # set a local curcontext to use for caching
  local curcontext=${curcontext%:*:*}:hk-__hk_addon_services: state line cache_policy ret=1
  local cache_name=":completion:${curcontext}:"

  # See if a cache-policy is already set up, and set one if not
  zstyle -s $cache_name cache-policy cache_policy
  [[ -z "$cache_policy" ]] && zstyle $cache_name cache-policy _hk_addon_services_caching_policy

  # If _addon_services isn't populated or the cache is invalid, and we fail to
  # retrieve the cache:
  if ( ((${#_addon_services} == 0)) || _cache_invalid $cache_name ) \
    && ! _retrieve_cache $cache_name; then
    # If we've gotten to this point, the app names aren't cached. Fetch them.
    _addon_services=(${(f)"$(hk addon-services)"})
    # Store _addon_services in the cache if this is a default cloud
    ( _hk_is_default_cloud ) && _store_cache $cache_name _addon_services
  fi

  # the -S ':' gives us a : suffix after completion
  compadd -S ':' $_addon_services
  # don't let this var persist in non-default clouds
  ( ! _hk_is_default_cloud ) && unset _addon_services
}

_hk_addon_services_caching_policy() {
  local -a oldp
  if ( ! _hk_is_default_cloud ); then
    return 0 # don't cache data in non-default clouds
  fi
  # Rebuild if cache is older than 1 week
  oldp=( "$1"(Nmw+1) )
  (( $#oldp ))
}

__hk_addon_plans() {
  # set a local curcontext to use for caching. Add service provider name ($1)
  # as a a suffix for caching.
  service=$1
  local curcontext=${curcontext%:*:*}:hk-__hk_addon_plans_$service: state line cache_policy ret=1
  local cache_name=":completion:${curcontext}:"
  local varname="_addon_plans_${service//-/_}" # replace - in service name w/ _
  plans_for_service=${(P)varname}

  # See if a cache-policy is already set up, and set one if not
  zstyle -s $cache_name cache-policy cache_policy
  [[ -z "$cache_policy" ]] && zstyle $cache_name cache-policy _hk_addon_plans_caching_policy

  # If $varname isn't populated or the cache is invalid, and we fail to retrieve
  # the cache:
  if ( ((${#plans_for_service} == 0)) || _cache_invalid $cache_name ) \
    && ! _retrieve_cache $cache_name; then
    # If we've gotten to this point, the plan names aren't cached. Fetch them.
    plans_for_service=(${(f)"$(hk addon-plans $service | cut -f 1 -d ' ')"})
    # Store _addon_plans in the cache if this is a default cloud
    ( _hk_is_default_cloud ) && _store_cache $cache_name plans_for_service
  fi

  compadd $plans_for_service
  # don't let this var persist in non-default clouds
  ( ! _hk_is_default_cloud ) && unset $varname
}

_hk_addon_plans_caching_policy() {
  local -a oldp
  if ( ! _hk_is_default_cloud ); then
    return 0 # don't cache data in non-default clouds
  fi
  # Rebuild if cache is older than 2 weeks
  oldp=( "$1"(Nmw+2) )
  (( $#oldp ))
}

__hk_app_names() {
  # set a local curcontext to use for caching
  local curcontext=${curcontext%:*:*}:hk-__hk_app_names: state line cache_policy ret=1
  local cache_name=":completion:${curcontext}:"

  # See if a cache-policy is already set up, and set one if not
  zstyle -s $cache_name cache-policy cache_policy
  [[ -z "$cache_policy" ]] && zstyle $cache_name cache-policy _hk_app_names_caching_policy

  # If _app_names isn't populated or the cache is invalid, and we fail to
  # retrieve the cache:
  if ( ((${#_app_names} == 0)) || _cache_invalid $cache_name ) \
    && ! _retrieve_cache $cache_name; then
    # If we've gotten to this point, the app names aren't cached. Fetch them.
    _app_names=(${(f)"$(hk apps | cut -f 1 -d ' ')"})
    # Store _app_names in the cache if this is a default cloud
    ( _hk_is_default_cloud ) && _store_cache $cache_name _app_names
  fi

  compadd $* - $_app_names
  # don't let this var persist in non-default clouds
  ( ! _hk_is_default_cloud ) && unset _app_names
}

_hk_app_names_caching_policy() {
  # Rebuild if cache is older than 1 hour.
  local -a oldp
  if ( ! _hk_is_default_cloud ); then
    return 0 # don't cache data in non-default clouds
  fi

  # This is a glob expansion for file modification time.
  # N sets NULL_GLOB, deleting the pattern from the arg list if it doesn't match.
  # m matches files with a given modification time, and h modifies the units to hours.
  # Finally, the +1 makes this match files modified at least 1 hour ago.
  oldp=( "$1"(Nmh+1) )
  # return the length of oldp (given by #)
  (( $#oldp ))
}

__hk_org_names() {
  # set a local curcontext to use for caching
  local curcontext=${curcontext%:*:*}:hk-__hk_org_names: state line cache_policy ret=1
  local cache_name=":completion:${curcontext}:"

  # See if a cache-policy is already set up, and set one if not
  zstyle -s $cache_name cache-policy cache_policy
  [[ -z "$cache_policy" ]] && zstyle $cache_name cache-policy _hk_org_names_caching_policy

  # If _org_names isn't populated or the cache is invalid, and we fail to
  # retrieve the cache:
  if ( ((${#_org_names} == 0)) || _cache_invalid $cache_name ) \
    && ! _retrieve_cache $cache_name; then
    # If we've gotten to this point, the org names aren't cached. Fetch them.
    _org_names=(${(f)"$(hk orgs | cut -f 1 -d ' ')"})
    # Store _org_names in the cache if this is a default cloud
    ( _hk_is_default_cloud ) && _store_cache $cache_name _org_names
  fi

  compadd $* - $_org_names
  # don't let this var persist in non-default clouds
  ( ! _hk_is_default_cloud ) && unset _region_names
}

_hk_org_names_caching_policy() {
  # Rebuild if cache is older than 2 weeks.
  local -a oldp
  if ( ! _hk_is_default_cloud ); then
    return 0 # don't cache data in non-default clouds
  fi

  # This is a glob expansion for file modification time.
  # N sets NULL_GLOB, deleting the pattern from the arg list if it doesn't match.
  # m matches files with a given modification time, and w modifies the units to weeks.
  # Finally, the +1 makes this match files modified at least 2 weeks ago.
  oldp=( "$1"(Nmw+2) )
  # return the length of oldp (given by #)
  (( $#oldp ))
}

__hk_region_names() {
  # set a local curcontext to use for caching
  local curcontext=${curcontext%:*:*}:hk-__hk_region_names: state line cache_policy ret=1
  local cache_name=":completion:${curcontext}:"

  # See if a cache-policy is already set up, and set one if not
  zstyle -s $cache_name cache-policy cache_policy
  [[ -z "$cache_policy" ]] && zstyle $cache_name cache-policy _hk_region_names_caching_policy

  # If _region_names isn't populated or the cache is invalid, and we fail to
  # retrieve the cache:
  if ( ((${#_region_names} == 0)) || _cache_invalid $cache_name ) \
    && ! _retrieve_cache $cache_name; then
    # If we've gotten to this point, the region names aren't cached. Fetch them.
    _region_names=(${(f)"$(hk regions | cut -f 1 -d ' ')"})
    # Store _region_names in the cache if this is a default cloud
    ( _hk_is_default_cloud ) && _store_cache $cache_name _region_names
  fi

  compadd $* - $_region_names
  # don't let this var persist in non-default clouds
  ( ! _hk_is_default_cloud ) && unset _region_names
}

_hk_region_names_caching_policy() {
  # Rebuild if cache is older than 2 weeks.
  local -a oldp
  if ( ! _hk_is_default_cloud ); then
    return 0 # don't cache data in non-default clouds
  fi

  # This is a glob expansion for file modification time.
  # N sets NULL_GLOB, deleting the pattern from the arg list if it doesn't match.
  # m matches files with a given modification time, and w modifies the units to weeks.
  # Finally, the +1 makes this match files modified at least 2 weeks ago.
  oldp=( "$1"(Nmw+2) )
  # return the length of oldp (given by #)
  (( $#oldp ))
}

# Completion for any command that takes only the app arg
_hk_complete_only_app_flag() {
  # -C: modify $curcontext for an action of the form '->state'
  # -S: no options completed after a --
  _arguments -C -S \
    $app_flag \
    '*:->args:' \
   && ret=0

  ## If we want to automatically guess which commands take an app flag:
  # check if word is in array from _hkcmdnames_needing_app:
  # (${~${(j:|:)$(_hkcmdnames_needing_app)}})

  return ret
}

###########################################################
##                     hk commands                       ##
###########################################################

_hk-access() {
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-access-add() {
  local curcontext=$curcontext state line ret=1

  _arguments -C -S \
    $app_flag \
    '(-s --silent)'{-s,--silent}'[add user silently with no email notification]' \
    '*:user email:' \
      && ret=0

  return ret
}

_hk-access-remove() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-addons() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-addon-add() {
  local curcontext=$curcontext state line ret=1

  _arguments -C -S \
    $app_flag \
    '::addon service and plan:__hk_complete_addon_service_and_plan' \
    '*::config options:' \
  && ret=0

  return ret
}

_hk-addon-destroy() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-addon-plan() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-addon-plans() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-addon-services() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-apps() {
  local curcontext=$curcontext state line ret=1

  _arguments -w -C -S -s \
    '(-o --org)'{-o,--org=}'[heroku organization name]:: :__hk_org_names' \
   && ret=0

  return ret
}

_hk-create() {
  local curcontext=$curcontext state line ret=1

  _arguments -w -C -S -s \
    '(-o --org)'{-o,--org=}'[heroku organization name]:: :__hk_org_names' \
    '(-r --region)'{-r,--region=}'[heroku region name]:: :__hk_region_names' \
    '*:app name:' \
   && ret=0

  return ret
}

_hk-domain-add() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-domain-remove() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-domains() {
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-drains() {
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-drain-add() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-drain-info() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-drain-remove() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-dynos() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-env() {
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-feature-disable() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-feature-enable() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-feature-info() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-features() {
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-get() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-help() {
  local curcontext=$curcontext state line ret=1

  if (( CURRENT < 3 )); then
    compadd $(_hkcmdnames) && ret=0
  fi
  return ret
}

_hk-info() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-log() {
  local curcontext=$curcontext state line ret=1

  _arguments -C -S \
    $app_flag \
    '(-n --number)'{-n,--number=}'[print at most N log lines]:: :' \
    '(-s --source)'{-s,--source=}'[filter log source]:: :(heroku app)' \
    '(-d --dyno)'{-d,--dyno=}'[filter dyno or process type]:: :' \
  && ret=0

  return ret
}

_hk-maintenance() {
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-maintenance-disable() {
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-maintenance-enable() {
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-members() {
  local curcontext=$curcontext state line ret=1

  _arguments -w -C -S -s \
    '1:: :__hk_org_names' \
   && ret=0

  return ret
}

_hk-open() {
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-pg-info() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-pg-list() {
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-pg-unfollow() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-psql() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-releases() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-restart() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-rollback() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-run() {
  local curcontext=$curcontext state line ret=1

  # there is currently no way to list possible dyno sizes, so just use a
  # constant array for that option
  _arguments -C -S \
    $app_flag \
    '(-s --size)'{-s,--size=}'[dyno size]:: :(1X 2X PX)' \
    '(-d --detached)'{-d,--detached}'[run in detached mode]' \
    '*:->args:' \
  && ret=0

  return ret
}

_hk-scale() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-set() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-ssl() {
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-ssl-cert-add() {
  local curcontext=$curcontext state line ret=1

  _arguments -C -S \
    $app_flag \
    '1:: :_files'\
    '2:: :_files'\
  && ret=0

  return ret
}

_hk-ssl-cert-rollback() {
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-ssl-destroy() {
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-transfer() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-transfer-accept() {
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-transfer-cancel() {
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-transfer-decline() {
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-transfers() {
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-unset() {
  # TODO: other optional args besides app flag
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-url() {
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

_hk-which-app() {
  local curcontext=$curcontext state line ret=1
  _hk_complete_only_app_flag
}

# The main command
_hk() {
  integer ret=1
  local curcontext=$curcontext state line

  _arguments -C \
    '(-): :->command' \
    '*:: :->option-or-argument' \
  && return
    #'(-)*:: :->option-or-argument' \
  #   '2:help:->help' \
  #   '2:generators:->generator_lists' \
  #   '*:: :->args' \

  case "$state" in
    (command)
      # _describe -t commands 'hk command' hkcmds && ret=0
      # _describe -t commands 'help' hkcmdnames && ret=0
      #
      # _describe -t commands "hk command" cmdnames && ret=0
      #
      # compadd $(hk help commands | awk '{print $2}')

      #_describe_hkcmdnames
      compadd $(_hkcmdnames) && ret=0
    ;;
    (option-or-argument)
      local -a app_flag; app_flag=('(-a --app)'{-a=,--app=}'[application or git remote name]: :__hk_app_names')

      curcontext=${curcontext%:*:*}:hk-$words[1]:
      _call_function ret _hk-$words[1]
    ;;
  esac

  return ret
}

_hk
