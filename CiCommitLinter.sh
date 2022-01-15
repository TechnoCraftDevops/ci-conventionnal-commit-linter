#!/bin/bash

# Data commits
CONVCOMMIT_COUNT=$(git log -s --format=%s master..$1  | grep --color=never -P '^(build|ci|feat|fix|refactor|style|docs|test)?\([a-z]*\): (.{1,50}$)' | wc -l);
INCONVCOMMIT_COUNT=$(git log -s --format=%s master..$1  | wc -l);

CONVCOMMIT_LIST=$(git log -s --format=%s master..$1  | grep -U --color=never -P '^(feat|fix|refactor|test)?\([a-z]*\): (.{1,50}$)');
INCONVCOMMIT_LIST=$(git log -s --format=%s master..$1 );

DIFF=$(diff  <(echo -e "$INCONVCOMMIT_LIST") <(echo -e "$CONVCOMMIT_LIST"));
DIFF_COUNT= $(diff  <(echo -e "$INCONVCOMMIT_LIST") <(echo -e "$CONVCOMMIT_LIST") | wc -l);

# Styles
red=`tput setaf 1`;
green=`tput setaf 2`;
blue=`tput setaf 4`;
yellow=`tput setaf 3`;

# whiteBg=`tput setab 8`

bold=$(tput bold);
underline=`(tput sgr 0 1)`;

reset=`tput sgr0`;
echo ${DIFF_COUNT} 
echo ${DIFF} 

# if [ ${DIFF_COUNT} -ge 1 ];then
#   echo ${underline}${red}  "${bold}not conventionnal commit found" ${reset};
#   echo ${yellow} "-------------" ${reset};
#   echo ${red}"$DIFF" ${reset};
#   echo ${yellow} "-------------" ${reset};
#   echo ${red} "please try => ${yellow}/!\one by one commit/!\\"${rest};
#   echo ${red} "1- ${bold}${whiteBg}git rebase -i HEAD~${INCONVCOMMIT_COUNT}"${reset};
#   echo ${red} "2- ${bold}${whiteBg}replace pick by reward on the commit, save & quit" ${reset};
#   echo ${red} "3- ${bold}${whiteBg}fix the commit message with convientionnal format, save & quit " ${reset};
#   echo ${red} "${bold}${whiteBg}Et voila !" ${reset};
#   echo "";
#   echo ${red} "${bold}<-- don't be afraid of rebase we believe in you -->";
#   exit 1;
# else
#   echo ${green} ${bold} "all commit are conventionnals" ${reset};
#   echo ${blue} "-------------" ${reset};
#   echo ${green} "$CONVCOMMIT_LIST" ${reset};
#   echo ${blue} "-------------" ${reset};
#   echo ${bold} ${blue} "good job !" ${reset}
#   exit 0;
# fi