#!/bin/sh

set -e

HTML=/pod-data/index.html_tmp
HTML_TARG=/pod-data/index.html

while true
do
    echo "<html><head>" > $HTML
    echo "<title>ECIP-1017 Fork Status</title>" >> $HTML
    echo "<link href=\"https://fonts.googleapis.com/css?family=Inconsolata\" rel=\"stylesheet\">" >> $HTML
    echo "<style> body { color: #fff; background-color: #111; font-family: 'Inconsolata', monospace;} </style>" >> $HTML
    echo "<meta http-equiv=\"refresh\" content=\"5\" >" >> $HTML
    echo "</head><body><pre>" >> $HTML
    /status.py >> $HTML 2>/dev/null
    echo "</pre></body></html>" >> $HTML
    mv $HTML $HTML_TARG
    sleep 5
done