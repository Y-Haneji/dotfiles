#------------------------------------------
#環境変数の設定
#------------------------------------------
# homebrew
if [[ "$(uname -m)" == "arm64" ]]; then
	eval "$(/usr/local/bin/brew shellenv)"
	eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$(uname -m)" == "x86_64" ]]; then
	eval "$(/usr/local/bin/brew shellenv)"
fi

# anyenv
eval "$(anyenv init -)"

# opam configuration
test -r /Users/yuto/.opam/opam-init/init.zsh && . /Users/yuto/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# go
export GOROOT="/usr/local/go"
export GOPATH="$HOME/go"
export PATH="$GOROOT/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# 自作のスクリプト
export PATH="$HOME/bin:$PATH"

# ls -G オプションで使う色設定
export LSCOLORS=xbfxcxdxbxegedabagacad

#-------------------------------------------
#プラグイン
#-------------------------------------------
if [[ "$(uname -m)" == "arm64" ]]; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ "$(uname -m)" == "x86_64" ]]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

#-------------------------------------------
#ビルトインモジュール
#-------------------------------------------
# 色を使用出来るようにする
autoload -U colors
colors

# zsh-completions(補完機能)の設定
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
autoload -U compinit
compinit -u
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt complete_in_word

#-------------------------------------------
#オプション設定
#-------------------------------------------
setopt share_history
setopt hist_ignore_all_dups
setopt print_eight_bit
setopt correct
setopt auto_pushd
setopt pushd_ignore_dups
set -o noclobber

#---------------------------------------------
#エイリアス
#---------------------------------------------
alias tree="pwd;find . | sort | sed '1d;s/^\.//;s/\/\([^/]*\)$/|--\1/;s/\/[^/|]*/| /g'"

alias ls="ls -G"

alias lswd='ls -G -a -F -1 | grep "^\..*[^/]$" && ls -G -a -F -1 | grep "/$" && ls -G -a -F -1 | grep -v -e "^\." -e "/$"'

alias relogin="exec $SHELL -l"

alias gst="git status"

alias gdf="git diff"

alias gdfc="git diff --cached"

alias gad="git add"

alias gada="git add -A"

alias gadu="git add -u"

alias gcm="git commit"

alias gcmm="git commit -m"

alias gft="git fetch"

alias gpl="git pull"

alias gps="git push"

alias gbr="git branch"

alias gch="git checkout"

alias glg="git log"

if (( $+commands[arch] )); then
  alias a64="exec arch -arch arm64e '$SHELL'"
  alias x64="exec arch -arch x86_64 '$SHELL'"
  alias x86="exec arch -arch x86_64 '$SHELL'"
fi

if [[ "$(uname -m)" == "x86_64" ]]; then
  alias brew_x86="/usr/local/bin/brew"
  alias conda_x86="/usr/local/bin/conda"
fi

#---------------------------------------------
#hook関数
#---------------------------------------------
#cdした後に自動でlsされる
chpwd() {
    if [[ $(pwd) != $HOME ]]; then;
        ls -F -1 | grep /
    fi
}

#---------------------------------------------
#プロンプトの設定
#---------------------------------------------
PS1='
%F{green}%(5~,%-1~/.../%2~,%~) %n@%m [%T] $(uname -m)%f
%F{green}%B●%b%f :'

#gitのブランチ状態を表示
autoload -Uz vcs_info
setopt prompt_subst

# true | false
# trueで作業ブランチの状態に応じて表示を変える
zstyle ':vcs_info:*' check-for-changes true
# addしてない場合の表示
zstyle ':vcs_info:*' unstagedstr "%F{red}%B＋%b%f"
# commitしてない場合の表示
zstyle ':vcs_info:*' stagedstr "%F{yellow}★ %f"
# デフォルトの状態の表示
zstyle ':vcs_info:*' formats "%u%c%F{green}【 %b 】%f"
# コンフリクトが起きたり特別な状態になるとformatsの代わりに表示
zstyle ':vcs_info:*' actionformats '【%b | %a】'

precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'
