#!/usr/bin/python

import string
import sys
from PIL import Image
import numpy


if __name__ == "__main__":




	# Open file and write verilog
	raw = open("../Verification/OutIm.dat", "r")
	data = raw.read()
	raw.close()

	pixels = data.split("\n")
	length = len(pixels)

	i_max = 0
	j_max = 0
	for i in range(0,length):
		pixel = pixels[i].split(",")
		print pixel
		i = int(pixel[0])
		j = int(pixel[1])
		if(i > i_max):
			i_max = i
		if(j > j_max):
			j_max = j

	im = numpy.zeros((i_max+1,j_max+1))
	im.setflags(write=True)

	print im

	for i in range(0,length):
		pixel = pixels[i].split(",")
		im[int(pixel[0])][int(pixel[1])] = int(pixel[2])

	print im
	img = Image.fromarray(im.astype(numpy.uint8), 'L')		# Cast to get rid of errors
	img.save("OutIm.png")





