#!/usr/bin/python

import string
import sys
import optparse
from PIL import Image
import numpy


if __name__ == "__main__":
	# Get image options
	parser = optparse.OptionParser()
	parser.add_option('-i', '--image',
		dest="image"
	)
	parser.add_option('-s', '--size',
		dest="size"
	)
	options, remainder = parser.parse_args()

	if(options.image == None):
		print("\nPlease specify image (-i)")
		sys.exit(0)
	else:
		image = options.image

	if(options.size == None):
		print("\nPlease specify size (-s)")
		sys.exit(0)
	else:
		size = int(options.size)


	# Resize, B&W and save image
	im = Image.open(image)
	name,ext = image.split('.')
	im = im.convert('L')
	im = im.resize((size,size),Image.ANTIALIAS)
	sized = name + "Size." + ext
	im.save(sized)
	print ("\nResized image: %s" % str(sized))


	# Convert to mat and do stuff
	imMat = numpy.asarray(im)




	# Open file and write verilog
	verilog = open("../RTL/InHandleTemplate.v", "r")
	code = verilog.read()

	code = string.replace(code, '<COLS>', str(size))
	code = string.replace(code, '<ROWS>', str(size))

	total = 0
	code = code + "\n"
	for i in range(0,size):
		for j in range(0,size):
			code = code + "\t\t\t" + str(total) + ": Pixel = " + str(imMat[i][j]) + ";\n"
			total = total + 1
	code = code + "\t\tendcase\n\tend\nendmodule"
	new = open("../RTL/InHandle.v", "w")
	new.write(code)
	new.close()






