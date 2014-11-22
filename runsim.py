#!/usr/bin/python

import string
import sys
import optparse
import os
from PIL import Image
import numpy


if __name__ == "__main__":
   # Get image options
   parser = optparse.OptionParser()
   parser.add_option('-I', '--image',dest="image")
   parser.add_option('-S', '--size',dest="size")

   options, remainder = parser.parse_args()

   if(options.size == None):
      print("\nPlease specify image size (-S)")
      sys.exit(0)
   else:
      size = options.size

   if(options.image == None):
      print("\nPlease specify image (-I)")
      sys.exit(0)
   else:
      image = options.image


   os.chdir("Scripts")
   os.system("python Im2InHandle.py -I " + image + " -W " + size + " -H " + size)
   os.chdir("..")
   os.system("iverilog -o design.dat -c filelist.txt")
   os.system("vvp design.dat -vcd")
   os.chdir("Scripts")
   os.system("python Raw2Im.py")
   os.chdir("..")
