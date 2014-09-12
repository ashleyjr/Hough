#!/usr/bin/python

import string
import sys
from PIL import Image
import numpy


if __name__ == "__main__":




	# Open file and write verilog
	raw = open("../OutIm.dat", "r")
	data = raw.read()
	raw.close()

	pixels = data.split("\n")
	length = len(pixels)

	i_max = 0
	j_max = 0
	for i in range(0,length):
		pixel = pixels[i].split(",")
		i = int(pixel[0])
		j = int(pixel[1])

		if(i > i_max):
			i_max = i
		if(j > j_max):
			j_max = j

	im = numpy.zeros((i_max+1,j_max+1))
	im.setflags(write=True)

	print im

	low = 255;
	high = 0;
	for i in range(0,length):
		pixel = pixels[i].split(",")
		num = int(pixel[2])
		im[int(pixel[0])][int(pixel[1])] = num
		if(num < low):
			low = num
		if(num > high):
			high = num


	print im
	print high
	print low

	img = Image.fromarray(im.astype(numpy.uint8), 'L')		# Cast to get rid of errors
	img.save("OutImRaw.png")

	for i in range(0,i_max+1):
		for j in range(0,j_max+1):
			im[i][j] = (im[i][j]-low)*(255/(high-low))

	print im
	img = Image.fromarray(im.astype(numpy.uint8), 'L')		# Cast to get rid of errors
	img.save("OutImNorm.png")








