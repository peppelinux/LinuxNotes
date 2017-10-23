# get the 10 greatest file/directory over there
du -a /var | sort -n -r | head -n 10
# or
du -hsx /var | sort -rh | head -10

# using GNU find
find /var -printf '%s %p\n'| sort -nr | head -10
find . -printf '%s %p\n'| sort -nr | head -10

# get the processes that are writing to the disk
apt get install iotop
iotop
