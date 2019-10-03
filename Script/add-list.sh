#!/bin/bash

dire=`ls ../articles`
for article in $dire
do
    len=`expr ${#article} - 3`
    filename=${article:0:${len}}
    spath="/articles/${article}"
    record="[${filename}](${spath})\n"
    echo $record
    echo -e $record >> ../readme.md
done
