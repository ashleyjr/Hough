#!/usr/bin/python

import string
import sys
import optparse
from PIL import Image
import numpy


if __name__ == "__main__":
	# Get image options
	parser = optparse.OptionParser()
	parser.add_option('-I', '--image',
		dest="image"
	)
	parser.add_option('-H', '--height',
		dest="height"
	)
	parser.add_option('-W', '--width',
		dest="width"
	)
	options, remainder = parser.parse_args()

	if(options.width == None):
		print("\nPlease specify image width (-w)")
		sys.exit(0)
	else:
		width = int(options.width)

	if(options.height == None):
		print("\nPlease specify image height (-h)")
		sys.exit(0)
	else:
		height = int(options.height)


	if(options.image == None):
		print("\nPlease specify image (-i)")
		sys.exit(0)
	else:
		image = options.image


	# Resize, B&W and save image
	im = Image.open(image)
	name,ext = image.split('.')
	im = im.convert('L')
	im = im.resize((width,height),Image.ANTIALIAS)
	sized = name + "Size." + ext
	im.save(sized)


	print ("\nResized image: %s" % str(sized))


	# Convert to mat and do stuff
	imMat = numpy.asarray(im)




	# Open file and write verilog
	verilog = open("../RTL/InHandleTemplate.v", "r")
	code = verilog.read()

	code = string.replace(code, '<COLS>', str(width))
	code = string.replace(code, '<ROWS>', str(height))

	total = 0
	code = code + "\n"
	for i in range(0,height):
		for j in range(0,width):
			code = code + "\t\t\t" + str(total) + ": Pixel = " + str(imMat[i][j]) + ";\n"
			total = total + 1
	code = code + "\t\tendcase\n\tend\nendmodule"
	new = open("../RTL/InHandle.v", "w")
	new.write(code)
	new.close()






