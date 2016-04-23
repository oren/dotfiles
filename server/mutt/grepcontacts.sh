#!/bin/bash

if [[ $# < 1 ]]
then
  exit
fi

echo 'Grepping'
grep $1 ~/misc/backup/contacts.csv

