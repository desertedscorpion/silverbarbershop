#!/bin/bash

ls "${@}" | while read REPO
do
    git fetch origin master &&
    git rebase origin/master &&
    git push origin master
done
