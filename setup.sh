#!/bin/bash
home="/home/sudokraft"
mc="$home/minecraft"

if [ ! -e '/home/sudokraft' ]
then
  echo "Please make a user named 'sudokraft' to run the server with."
  exit 1
fi


function myMakeLink() {
  here=$1
  target=$2
  mkdir -p `dirname $target` &> /dev/null
  if [ ! -e $target ] 
  then
    ln -s `pwd`/$here $target
  else
    echo "Replace $target? [Y/n]"
    read a
    if [ $a != "n" ]
    then
      rm -rf $target
      ln -s `pwd`/$here $target
    fi  
  fi  
}

myMakeLink backup/backup-hook.sh $home/backup-hook.sh

for plugin in `ls plugins` 
do
  myMakeLink plugin/$plugin $mc/plugins/$plugin
done

