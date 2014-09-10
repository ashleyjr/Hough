#!/usr/bin/python

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
	imMat.setflags(write=True)

	print "imMat"
	print imMat
	newMat = imMat
	maxi = 0
	for i in range(1,(size-1)):
		for j in range(1,(size-1)):
			newMat[i][j] = abs(imMat[i][j] - imMat[i+1][j-1] - imMat[i+1][j] - imMat[i+1][j] - imMat[i+1][j+1] + imMat[i-1][j-1] - imMat[i-1][j] - imMat[i-1][j] - imMat[i-1][j+1])
	print newMat
	#print maxi

	#scale = float(255./maxi)

	#print scale
	#for i in range(1,(size-1)):
	#	for j in range(1,(size-1)):
	#		newMat[i][j] = int(newMat[i][j]*scale)

	# Set the border to black
	for i in range(0,size):
		newMat[i][0] = 0
		newMat[0][i] = 0
		newMat[i][size-1] = 0
		newMat[size-1][i] = 0


	print newMat

	# Save new image
	img = Image.fromarray(newMat, 'L')
	new = name + "New." + ext
	img.save(new)






