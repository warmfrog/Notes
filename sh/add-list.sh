#!/bin/bash

dire=`ls ../articles`
for article in $dire
do
    len=`expr ${#article} - 3`
    filename=${article:0:${len}}
    spath="/articles/${article}"
    record="[${filename}](${spath})"
    echo $record
    echo $record >> ../readme.md
done
