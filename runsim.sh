cd Scripts
python Im2InHandle.py -I Lenna.png -W 150 -H 150
cd ..
iverilog -o design.dat -c filelist.txt
vvp design.dat -vcd
cd Scripts
python Raw2Im.py 
cd ..
