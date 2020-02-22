#!/bin/bash
#add fix to exercise6-fix here

DEST_FOLDER=${@: -1}
SIZE=0

#check which server the script is running on
if [ "$(hostname)" == "server1" ]
then
        SERVER=server2
else
        SERVER=server1
fi

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
