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

#find / -type d > .tree
#NASCONDIGLIO=`cat .tree | sort --random-sort | head -1`


python <<END
import random
import os

subdir=None

def schiaffa():
	top_dir='/'
	recursion=random.randint(0, 33)
	
	subdirs = [name for name in os.listdir(top_dir) if os.path.isdir(os.path.join(top_dir, name))]
	subdirs.pop(subdirs.index('lost+found'))
	subdirs.pop(subdirs.index('proc'))
	subd = subdirs[random.randint(0, len(subdirs)-1)]
	
	subdir = None

	for dirname, dirnames, filenames in os.walk(os.path.join(top_dir,subd)):
		try:
			subdirname = dirnames[random.randint(0, len(dirnames)-1)]
			subdir = os.path.join(dirname, subdirname)
			#print subdir
		except:
			for subdirname in dirnames:
				#dirnames 
				subdir = os.path.join(dirname, subdirname)
				#print subdir
		recursion -= 1
		if recursion == 0 or recursion < 0: break
	return subdir

while not subdir:
	subdir = schiaffa()

#print subdir
#os.environ['NASCONDIGLIO'] = subdir
#for i in os.environ.items(): print i
f = open('.gnorla', 'w')
f.writelines(subdir)
f.close()
END

NASCONDIGLIO=(`cat .gnorla`)
#echo $NASCONDIGLIO
rm .gnorla

echo "$TRIPPER is taking away..."
mv ./$TRIPPER $NASCONDIGLIO/$NOME

MD5_HASH=`md5sum $NASCONDIGLIO/$NOME | awk -F' ' {'print $1'}`
mv $NASCONDIGLIO/$NOME $NASCONDIGLIO/$MD5_HASH$NOME
#rm .tree
echo "sono $NASCONDIGLIO/$MD5_HASH$NOME"
