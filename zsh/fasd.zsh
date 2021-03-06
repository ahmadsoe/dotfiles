if [ $commands[fasd] ]; then # check if fasd is installed
  fasd_cache="${ZSH_CACHE_DIR}/fasd-init-cache"

  if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init zsh-hook >| "$fasd_cache"
  fi

  source "$fasd_cache"
  unset fasd_cache
fi
