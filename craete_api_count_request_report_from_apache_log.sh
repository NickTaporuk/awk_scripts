#!/usr/bin/env bash

LOGS_PATH="/var/www/tc-wl/test_bsro.log"
AWK_APACHE_LOG_PARSER='/var/www/bsro_tce_api/count_api_requests_report.awk'

DATE=`date +%Y_%m_%d`
SAVE_FILE_PATH="/tmp/bsro_request_counts_report_${DATE}.txt"
SEARCH_BY_DAYS='7'
START_DATE=`date -d "-${SEARCH_BY_DAYS} days" +%s`
## Variable is intended for the recipient array of the report
MAILS_ARRAY=()
#MAILS_ARRAY[0]='james.mcgoodwin@gmail.com'
MAILS_ARRAY[0]='nictaporuk@yandex.ru'
MAILS_ARRAY[1]='nictaporuk@gmail.com'
MAIL_FROM="api_stats@$(hostname -a)"

remove_tmpfile_if_exist()
{
log $FUNCNAME "$@"
  if [ -f "${SAVE_FILE_PATH}" ];
    then rm -rf "${SAVE_FILE_PATH}"
  fi
}

get_mimetype(){
log $FUNCNAME "$@"
  # warning: assumes that the passed file exists
  file --mime-type "$1"
}

log()
{
## use log $FUNCNAME "$@"
  echo -e 'Program in function name: ' $1
  echo -e 'Function parameters: ' $2
}
send_reports_to_emails(){
to=$1
log $FUNCNAME "$@"
subject="API Stats for $(hostname -a) From `date -d @${START_DATE} +%m/%d/%Y` to `date -d'now' +%m/%d/%Y`)"
boundary="ZZ_/afg6432dfgkl.94531q"
body="
Stats on API Requests to $(hostname -a)
$(echo -e "From `date -d @${START_DATE} +%m/%d/%Y` to `date -d'now' +%m/%d/%Y`")
"
#
declare -a attachments
attachments=( "${SAVE_FILE_PATH}" )

# Build headers
{
printf '%s\n' "From: $MAIL_FROM
To: $to
Subject: $subject
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=\"$boundary\"

--${boundary}
Content-Type: text/plain; charset=\"US-ASCII\"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

$body
"

# now loop over the attachments, guess the type
# and produce the corresponding part, encoded base64
for file in "${attachments[@]}"; do

  [ ! -f "$file" ] && echo "Warning: attachment $file not found, skipping" >&2 && continue

  mimetype=$(get_mimetype "$SAVE_FILE_PATH").

  printf '%s\n' "--${boundary}
Content-Type: $mimetype
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=\"report_$(hostname -a).txt\"
"

  base64 "$file"
  echo
done

# print last boundary with closing --
printf '%s\n' "--${boundary}--"

  } | sendmail -t -oi   # one may also use -f here to set the envelope-MAIL_FROM
}

## if exist tmp file to remove this file
remove_tmpfile_if_exist
## parse apache log and count requests bsro
log 'count_api_requests_report.awk' ${START_DATE}
awk -v lowerDateRange=${START_DATE} -f ${AWK_APACHE_LOG_PARSER} ${LOGS_PATH} > ${SAVE_FILE_PATH}
## send report to array emails

if [ -f "${SAVE_FILE_PATH}" ]
then
  for i in ${MAILS_ARRAY[*]}
  do
    send_reports_to_emails $i
  done
fi