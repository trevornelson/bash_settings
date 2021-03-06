# Set paths
export PATH="$PATH:/usr/local/bin/"
export PATH="/usr/local/git/bin:/sw/bin/:/usr/local/bin:/usr/local/:/usr/local/sbin:/usr/local/mysql/bin:$PATH"

alias refresh='source ~/.zshrc'
alias be='bundle exec'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias ll='ls -FGlAhp'
alias less='less -FSRXc'
alias ..='cd ../'
alias ...='cd ../../'
alias f='open -a Finder ./'
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
alias qfind="find . -name"
alias memHogsTop='top -l 1 -o rsize | head -20'
alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'
alias flushDNS='dscacheutil -flushcache'
alias editHosts='sudo edit /etc/hosts'
alias httpErr='tail /var/log/httpd/error_log'
alias apacheLogs='less +F /var/log/apache2/error_log'
cd () { builtin cd "$@"; ls; }

#   mcd: Make directory and cd into it
#   --------------------------------------------------------
mcd () { mkdir -p "$1" && cd "$1"; }

#   mans: Manual search
#   --------------------------------------------------------
mans () {
  man $1 | grep -iC2 --color=always $2 | less
}

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
       esac
   else
       echo "'$1' is not a valid file"
   fi
}

#   findPid: Find process id
#   ---------------------------------------------------------
findPid () {
  lsof -t -c "$@";
}

#   my_ps: List processes owned by current user
#   ---------------------------------------------------------
my_ps() {
  ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command;
}

#   httpHeaders: Grabs headers from web page
#   ---------------------------------------------------------
httpHeaders () {
  /usr/bin/curl -I -L $@;
}

#   httpDebug:  Download a web page and show info on what took time
#   -------------------------------------------------------------------
httpDebug () {
  /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n";
}

#   gitSlug: Returns a sluggified version of your git username.
#   -----------------------------------------------------------
gitSlug () {
  typeset -l output
  output=${"$(git config user.name)"// /}
  echo $output
}

#   gojira: Create a branch for a given Jira ticket number.
#   -----------------------------------------------------------
gojira () {
  echo $1
  if [ -z "$1" ]; then
    echo "You need to specify a Jira issue code, ya dingus!"
  else
    git checkout -b "$(gitSlug)/$1"
  fi
}

#   killport: Find and kill process running on a given port
#   ---------------------------------------------------------
killport () {
  lsof -i TCP:$1 | grep LISTEN | awk '{print $2}' | xargs kill -9
}

fuckYoBranches () {
  git branch --merged | egrep -v "(^\*|master|experiment)" | xargs git branch -d
}

# Force grep to always use the color option and show line numbers
export GREP_OPTIONS='--color=always'

# Change the prompt
print_before_the_prompt () {
  printf "$BPurple%s\n$Green%s\n$Cyan%s $Blue@%s$Color_Off" "__________________" "$PWD" "$USER"
}
 
PROMPT_COMMAND=print_before_the_prompt

PS1='~>'

export CLICOLOR=1

# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[0;105m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White



# Must be at the end of zsh profile
source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
