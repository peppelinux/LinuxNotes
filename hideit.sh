#!/bin/bash
# per trovarlo se è stato rinominato con il vecchio sistema RANDOM
#find . -iregex '\./[a-z0-9/]*[0-9]$' -regextype posix-egrep -type f -cmin -5 | grep -e '/[0-9]*$'

# per trovarlo se è stato rinominato con il sistema MD5SUM+RANDOM :)
#find . -iregex '\./[a-z0-9/]*[0-9]$' -regextype posix-egrep -type f -cmin -5'


if [ -n "$1" ]
	then 
		echo "$1 è la vittima sacrificale :)"
		TRIPPER=$1
	else
		echo "vai $0, immolati nel filesystem... "
	
	TRIPPER=$0
fi

NOME=$RANDOM

TOP_DIR="/"
CWD="$PWD"
P=''
LIST_PATH=`ls -d $TOP_DIR/ | sort --random-sort | head -1 | xargs readlink --canonicalize`

RECURSION=12

#TOP_DIR=ls -d *"$P"/ | sort --random-sort | head -1 | xargs readlink --canonicalize
cd $TOP_DIR
#echo "$TOP_DIR"
COUNTER=0
while [  $COUNTER -lt $RECURSION ]; do
 #echo The counter is $COUNTER
 let COUNTER=COUNTER+1 
 CD=`ls -d "$P"/* | sed -e 's/lost+found//g' | sed -e 's/opt//g'  |sort --random-sort | head -1 | xargs readlink --canonicalize`
 #echo "$CD"
 if [ -d "$CD" -a -w "$CD" ]

	then
		#echo "Directory scrivibile: $CD"
		P="$CD"
		#cd "$CD"
	else
		#echo "Directory non scrivibile: $CD"
		P=`echo "$CD" | sed -e 's/[a-zA-Z0-9\.\_\+-]*$//g'`
		#echo "Directory modificata: $P"
 fi
	if [[ -z "$P" ]]
	 then
	
	#echo "manovra a u... ad monkiax"
		let COUNTER=COUNTER+1
		P="$P""./.."
		#echo "$P"
	fi
done

cd "$CWD"
NASCONDIGLIO="$P"


echo "$TRIPPER is taking away..."
mv ./$TRIPPER $NASCONDIGLIO/$NOME

MD5_HASH=`md5sum $NASCONDIGLIO/$NOME | awk -F' ' {'print $1'}`
mv $NASCONDIGLIO/$NOME $NASCONDIGLIO/$MD5_HASH$NOME
#rm .tree
echo "sono $NASCONDIGLIO/$MD5_HASH$NOME"
