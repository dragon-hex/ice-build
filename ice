#!/usr/bin/python3 -d
# 2020 Ice Build System by Dragon Hex.

import sys, os
import time

try: import icebuild
except:
	print("icebuild library not found.")
	sys.exit(-1)
	
# class: app
class app:
	def crash (self, reason):
		# Return the length of the reason.
		print("!! " + reason)
		sys.exit(len(reason))
		
	def __init__ (self):
		# Check for 'icefile' on the main dir
		# also, if is a directory, then crash!
		if not os.path.exists ('./icefile'):
			if os.path.isdir('./iceberg'): self.crash("icefile is a dir.")
		
		# Now, init the main 'icefile'
		self.icefile_thread = icebuild.thread()
		self.icefile_thread.load('./icefile', report_error=True)
		
		# Case any problem, run the scriptlet
		
		# Ice will store the 'bytecode' on the main buffer
		# after that, it will run commands.
		# That allow comparations and label system.
		
		# Get the time taken.
		t0 = time.time()
		
		while self.icefile_thread.state == icebuild.STATE_RUNNING:
			self.icefile_thread.run()
		
		# Report to user.
		print(">> Job Finished, at " + str(time.time() - t0) + "ms")

# Run the App class at here.
app()
