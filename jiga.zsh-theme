rescol="green"

SEPARATOR=''
CURRENT_BG='NONE'
ARROW=''
ERR='✘'
DONE='☭'

element() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1

  [[ -n $3 ]] && echo -n "$3"
}
promt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG='NONE'
}

result() {
  if (( $? != 0 )) && echo -n $ERR || echo -n $DONE
}

build_prompt() {
  element red black $(result)
  element blue red "> %n > "
  element black green "> %~ >"
  promt_end
  echo 
  element black red "> "
  promt_end
}

PROMPT='%{%f%b%k%}$(build_prompt)'
