height="500"
width="500"
rm LennaIn.png
rm LennaOut.png
python Im2File.py -I Lenna.png -H ${height} -W ${width}	# Resize image and print to text file
gcc image.c -o image.o
./image.o
python File2Im.py -F LennaOut.dat -H ${height} -W ${width}
rm image.o

