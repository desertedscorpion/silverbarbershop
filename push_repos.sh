#!/bin/bash

ls "${@}" | while read REPO
do
    git -C "${@}"/"${REPO}" fetch origin master &&
    git -C "${@}"/"${REPO}" rebase origin/master &&
    git -C "${@}"/"${REPO}" push origin master
done
