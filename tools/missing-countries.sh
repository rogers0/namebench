#!/bin/sh
# Display a list of countries that have no coverage
cut -d, -f6 ../config/servers.csv | sed s/\"//g | cut -d/ -f1 | sort -u > /tmp/iso.has
echo "Countries listed: `wc -l /tmp/iso.has`"
cat ../data/ISO_31661-1.codes| perl -ne 'if (/ +(\w\w)$/) { print "$1\n"; }' > /tmp/iso.codes
echo "Countries total: `wc -l /tmp/iso.codes`"
cat /tmp/iso.has /tmp/iso.has /tmp/iso.codes | sort | uniq -u > /tmp/iso.missing
cat /tmp/iso.missing | xargs -I{} -n1 grep " {}$" ../data/ISO_31661-1.codes
echo "Countries missing: `wc -l /tmp/iso.missing`"