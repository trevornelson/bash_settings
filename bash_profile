# Change the prompt
export PS1="________________________________________________________________________________\n| \w @ \h (\u) \n| => "
export PS2="| => "

# Set paths
export PATH="$PATH:/usr/local/bin/"
export PATH="/usr/local/git/bin:/sw/bin/:/usr/local/bin:/usr/local/:/usr/local/sbin:/usr/local/mysql/bin:$PATH"

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
cd () { builtin cd "$@"; ll; }

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

# Force grep to always use the color option and show line numbers
export GREP_OPTIONS='--color=always'

# Set sublime as the default editor
which -s subl && export EDITOR="subl --wait"

# Useful aliases

alias e="subl"
alias be="bundle exec"
