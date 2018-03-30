import re
import time

timestr = time.strftime("%Y%m%d-%H%M%S")

counter = 0

input_file = open("/var/log/nginx/access.log")
output_file = open("/xchng/" + timestr + " - errors.txt", "w")
output_file2 = open("/xchng/" + timestr + " - report.txt", "w")

for line in input_file:
	if re.search("GET (.*) HTTP/1.1\" 50", line):
		print(line + '\r\n', end="", file=output_file)
		counter +=1
		
print('There are ' + str(counter) + ' "50x" errors in access.log', end="", file=output_file2)