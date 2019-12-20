# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# get current status of git repo
parse_git_dirty() {
  status=`git status 2>&1 | tee`
  modified=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
  untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
  ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"` 
  newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
  renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
  deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
  bits=''

  if [ "${renamed}" == "0" ]; then
    bits=">${bits}"
  fi
  if [ "${ahead}" == "0" ]; then
    bits="*${bits}"
  fi
  if [ "${newfile}" == "0" ]; then
    bits="+${bits}"
  fi
  if [ "${untracked}" == "0" ]; then
    bits="?${bits}"
  fi
  if [ "${deleted}" == "0" ]; then
    bits="x${bits}"
  fi
  if [ "${modified}" == "0" ]; then
    bits="!${bits}"
  fi
  if [ ! "${bits}" == "" ]; then
    echo " ${bits}"
  else
    :
  fi
}

# get current branch in git repo
parse_git_branch() {
  branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  if [ ! "${branch}" == "" ]; then
    stat=`parse_git_dirty`
    echo "(${branch}${stat}) "
  else
    :
  fi
}

# Colored Shell Prompt with git status
export PS1="[\[\e[1;32m\]\u\[\e[m\]@\[\e[1;31m\]\h\[\e[m\] \[\e[1;10m\]\W\[\e[m\]]\\$ \[\e[1;36m\]\`parse_git_branch\`\[\e[m\]"
