import re
import time
#import difflib
#import os.path

start_date = time.strftime("%d%m%y")
start_time = time.strftime("%d.%m.%y-%H:%M")

counter = 0
test_string = ''
output_string = ''

input_file = open("/var/log/nginx/access.log")

for line in input_file:
	if re.match("(.*)HTTP/(\d[\.]\d)\" 50", line):
		output_string += line
		counter +=1

#if os.path.isfile("/var/log/analyzer-script-log/analyzer_script-" + start_date + ".log"):
	#read_file = open("/var/log/analyzer-script-log/analyzer_script-" + start_date + ".log", "r")

#	for line in read_file:
#		if not line.strip() or line.startswith("///---"): continue
#		test_string += line

#	diff=difflib.unified_diff(output_string.splitlines(), test_string.splitlines())

#	difference = "".join(diff)
#	differen = ''
#	for line in difference:
#			if line.startswith("+"): continue
#			differen += line

output_file = open("/var/log/analyzer-script-log/analyzer_script-" + start_date + ".log", "a")

if counter > 0:
	print ('///--- ' + str(start_time) + '   There are ' + str(counter) + ' "50x" error(s) in access.log. ---///\r\n\r\n' + output_string + '\r\n', end="", file=output_file)