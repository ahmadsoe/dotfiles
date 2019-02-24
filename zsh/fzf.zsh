export FZF_DEFAULT_OPTS="
  --ansi
  --layout=reverse
  --height 90%
  --preview '(bat --color=always --style=header,grid --line-range :300 {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -300'
"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_COMPLETION_TRIGGER=''

bindkey '^O' fzf-completion
bindkey '^I' $fzf_default_completion

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1" | tee >(fasd -Rfl "$1")
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1" | tee >(fasd -Rdl "$1")
}

# Base16 OceanicNext
# Author: https://github.com/voronianski/oceanic-next-color-scheme
_gen_fzf_default_opts() {
  local color00='#1B2B34'
  local color01='#343D46'
  local color02='#4F5B66'
  local color03='#65737E'
  local color04='#A7ADBA'
  local color05='#C0C5CE'
  local color06='#CDD3DE'
  local color07='#D8DEE9'
  local color08='#EC5f67'
  local color09='#F99157'
  local color0A='#FAC863'
  local color0B='#99C794'
  local color0C='#5FB3B3'
  local color0D='#6699CC'
  local color0E='#C594C5'
  local color0F='#AB7967'

  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
    --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
    --color=fg:$color04,header:$color0D,info:$color03,pointer:$color0C
    --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
  "
}

_gen_fzf_default_opts
