#!/bin/bash
#add fix to exercise6-fix here
#The script will recive two path to copy and put it in the last argument.

DEST_FOLDER=${@: -1}
SIZE=0

#check which server the script is running on
if [ "$(hostname)" == "server1" ]
then
        SERVER=server2
else
        SERVER=server1
fi

#echo "The script will copy $FILE1 and $FILE2 to $SERVER in $DEST_FOLDER"
for file in ${@:1:$#-1}
do
scp -qi /home/vagrant/.ssh/id_rsa $file vagrant@$SERVER:$DEST_FOLDER
SIZE=$((${SIZE}+$(du -b $file | awk '{print$1}')))
done

if [ $? -eq 0 ]
then
       echo $SIZE
else
       echo "Error, ${@:1:$#-1} could not tranfer to $SERVER"
fi