import os
import datetime

rootdir = '/addons/main'

hppFile = '/addons/main/script_mod.hpp'

SCRIPT_MOD = open(hppFile, 'w')

possible_BUILD = ["BUILD"]

for subdir, dirs, files in os.walk(rootdir):

  for file in files:

    if str(file).endswith(".hpp"):

      open_file = open(os.path.join(subdir, file), 'r')
      line_counter = 0
      for line in open_file:

        for item in possible_BUILD:

          if line.__contains__(item):

            line = line.strip()

            TODO_file.write("File Name: " + file + "\n")
            TODO_file.write("Line Number: " + str(line_counter) + "\n")
            TODO_file.write(line + "\n" + "\n")
            break
        line_counter += 1
      # Closes open_file       
      open_file.close()
            

# end of all for loops

# Prints the last date modified for convenience. 
TODO_file.write("Last modified: " + str(datetime.datetime.now()))
# Closes the TODO_file
TODO_file.close()
