#!/bin/sh
now=$(date +"%d%m%Y")
old=$(date --date="7 days ago" +"%d%m%Y")
dir="$PWD/backup/mysql/"
oldfile=$dir"web_$old.sql.gz"
newfile=$dir"web_$now.sql.gz"


if [ ! -d $dir ]; then
    mkdir -p $dir
fi

if [ -f $oldfile ];
then
    rm $oldfile
    echo "Deleted $oldfile"
fi


if [ -f $newfile ];
then
    echo "Last backup file already exists"
else
    docker exec docker_database sh -c 'exec mysqldump -uroot -p"$MYSQL_ROOT_PASSWORD" wp_database' | gzip -9 > $newfile
    echo "Created $newfile"
fi
