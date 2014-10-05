height="240"
width="320"
gcc image.c -o image.o
rm Cam.jpg
rm Cam.jpg
python cam.py
python Im2File.py -I Cam.jpg -H ${height} -W ${width}	# Resize image and print to text file
./image.o
python File2Im.py -F CamOut.dat -H ${height} -W ${width}
rm image.o
eog CamOut.png

