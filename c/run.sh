x="100"
y="90"
rm LennaIn.png
rm LennaOut.png
python Im2File.py -I Lenna.png -H ${x} -W ${y}	# Resize image and print to text file
gcc image.c -o image.o
./image.o
python File2Im.py -F Lenna.dat -H ${x} -W ${y}
rm image.o
rm Lenna.dat
