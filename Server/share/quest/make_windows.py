#!/usr/local/bin/python
import pre_qc_windows
import os
import shutil

if os.path.exists('object'):
	shutil.rmtree('object')
os.makedirs('object')

if os.path.exists('pre_qc'):
	shutil.rmtree('pre_qc')
os.makedirs('pre_qc')

for line in file('quest_list'):
	line = line.rstrip()
	
	if line[0] == '#':
		continue
	
	r = pre_qc_windows.run(line)
	if r == True:
		filename = 'pre_qc/'+line
	else:
		filename = line

	if os.system('qc '+filename):
		print 'Error occured on compile ' + line
		import sys
		sys.exit(-1)

