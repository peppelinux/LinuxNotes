# linux command
# stty -F /dev/ttyACM0 9600

import re
import time
import os

def ReadSensor():
    """
    read until regex works or max_cnt is reached
    
    example:
    'Current humdity = 35.0%  temperature = 22.0C  \n'
    
    return one json object like:
    {'hum': 35.0, 'temp': 22.0, 'temp_unit': 'C', 'hum_unit': '%'}
    """
    
    regex = 'Current humdity = (?P<hum>[0-9\.]+)(?P<hum_unit>%)  temperature = (?P<temp>[0-9\.]+)(?P<temp_unit>C)'
    cnt = 0
    max_cnt = 33
    
    f = open('/dev/ttyACM0')
    result = ''
    
    while cnt < max_cnt:
        res = re.search(regex, f.readline())
        if res:
            r = dict(res.groupdict())
            r['temp'] = float(r['temp']) 
            r['hum'] = float(r['hum'])
            print(r)
            break
        time.sleep(0.5)
        cnt += 1

os.system('stty -F /dev/ttyACM0 9600')
ReadSensor()
