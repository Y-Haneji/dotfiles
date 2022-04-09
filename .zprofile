# 影響ないなら全部消しちゃってもいいかも

# # homebrew
# if [[ "$(uname -m)" == "arm64" ]]; then
# 	eval "$(/usr/local/bin/brew shellenv)"
# 	eval "$(/opt/homebrew/bin/brew shellenv)"
# elif [[ "$(uname -m)" == "x86_64" ]]; then
# 	eval "$(/usr/local/bin/brew shellenv)"
# fi
# 
# # anyenv
# eval "$(anyenv init -)"
# 
# # opam configuration
# test -r /Users/yuto/.opam/opam-init/init.zsh && . /Users/yuto/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
# 
# # go
# export GOROOT="/usr/local/go"
# export GOPATH="$HOME/go"
# export PATH="$GOROOT/bin:$PATH"
# export PATH="$GOPATH/bin:$PATH"
# 
# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
#         . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
# 
# # 自作のスクリプト
# export PATH="$HOME/bin:$PATH"
# 
# # ls -G オプションで使う色設定
# export LSCOLORS=xbfxcxdxbxegedabagacad
