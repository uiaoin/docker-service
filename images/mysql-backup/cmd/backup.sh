#!/usr/bin/env sh
if [ -z "$DB_CONNECT" ]; then
    echo '[ERROR] DB_CONNECT is not defined.'
    exit 0
fi
if [ -z "$DB_PORT" ]; then
    echo '[ERROR] DB_PORT is not defined.'
    exit 0
fi
if [ -z "$DB_USERNAME" ]; then
    echo '[ERROR] DB_USERNAME is not defined.'
    exit 0
fi
if [ -z "$DB_PASSWORD" ]; then
    echo '[ERROR] DB_PASSWORD is not defined.'
    exit 0
fi
if [ -z "$DB_DATABASES" ]; then
    echo '[ERROR] DB_DATABASES is not defined.'
    exit 0
fi
if [ -z "$BACK_DIR" ]; then
    echo '[ERROR] BACK_DIR is not defined.'
    exit 0
fi

# shellcheck disable=SC2039
DB_DATABASE_ARR=(${DB_DATABASES//,/ })
DIR=/var/backup/
DATE=$(date +%Y_%m_%d_%H%M%S)

# shellcheck disable=SC2039
for item in ${DB_DATABASE_ARR[*]}
do
echo '###### backing up database: ' "$item" ' ######'
filename="$item"'_'"$DATE".sql
file_full_name=$DIR"$item"'_'"$DATE".sql
echo "$DB_CONNECT" -P"$DB_PORT"-u"$DB_USERNAME"-p"$DB_PASSWORD""$item""$file_full_name"
mysqldump -h"$DB_CONNECT" -P"$DB_PORT" -u"$DB_USERNAME" -p"$DB_PASSWORD" "$item" > "$file_full_name" 2>/dev/null
echo '###### uploading to QiNiu Cloud ... ######'
qshell rput uiaoin-backup "$BACK_DIR"/"$item"/"$filename" "$file_full_name" --overwrite
echo '###### backed up database: ' "$item" ' ######'
done

rm -f "$DIR"/*

sleep 5

# shellcheck disable=SC2046
echo '###### backup completed!' $(date "+%Y-%m-%d %H:%M:%S") '######'
exit 0
