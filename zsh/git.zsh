# https://github.com/so-fancy/diff-so-fancy
hash diff-so-fancy &>/dev/null && forgit_fancy='|diff-so-fancy'
# https://github.com/wfxr/emoji-cli
hash emojify &>/dev/null && forgit_emojify='|emojify'

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf "$@"
}

# git commit viewer
glf() {
  is_in_git_repo || return
  local cmd="echo {} |grep -o '[a-f0-9]\{7\}' |head -1 |xargs -I% git show --color=always % $* $forgit_emojify $forgit_fancy"
  eval "git log --graph --color=always --format='%C(auto)%h%d %s %C(black)%C(bold)%cr' $* $forgit_emojify" |
    fzf-down +s +m --tiebreak=index \
    --bind="enter:execute($cmd |LESS='-R' less)" \
    --bind="ctrl-y:execute-silent(echo {} |grep -o '[a-f0-9]\{7\}' |${FORGIT_COPY_CMD:-pbcopy})" \
    --preview="$cmd"
  }

gaf() {
  is_in_git_repo || return
  local changed unmerged untracked files
  changed=$(git config --get-color color.status.changed red)
  unmerged=$(git config --get-color color.status.unmerged red)
  untracked=$(git config --get-color color.status.untracked red)
  files=$(git -c color.status=always status --short |
    grep -F -e "$changed" -e "$unmerged" -e "$untracked"|
    awk '{printf "[%10s]  ", $1; $1=""; print $0}' |
    fzf-down -0 -m --nth 2..,.. \
    --preview="git diff --color=always -- {-1} $forgit_emojify $forgit_fancy" |
    cut -d] -f2 |
    sed 's/.* -> //') # for rename case
  [[ -n "$files" ]] && echo "$files" |xargs -I{} git add {} && git status --short && return
  echo 'Nothing to add.'
}

gtag() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}
