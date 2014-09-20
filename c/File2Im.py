#!/usr/bin/python

import string
import sys
import optparse
from PIL import Image
import numpy


if __name__ == "__main__":
	# Get image options
	parser = optparse.OptionParser()
	parser.add_option('-F', '--file',
		dest="file"
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
	if(options.file == None):
		print("\nPlease specify file (-f)")
		sys.exit(0)
	else:
		file = options.file


	f = open(file,"r")
	data = f.read()
	f.close()


	im = numpy.zeros((height,width))
	im.setflags(write=True)

	line = 0
	lines = data.split("\n")
	for i  in range(0,width):
		for j in range(0,height):
			im[i][j] = int(lines[line])
			line = line + 1
	print im

	img = Image.fromarray(im.astype(numpy.uint8),'L')
	img.save("LennOut.png")





