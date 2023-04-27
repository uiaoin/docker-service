#!/usr/bin/env sh
qshell account -w "${AK}" "${SK}" uiaoin
systemctl start cron
