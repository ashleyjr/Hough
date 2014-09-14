cd Scripts
python -I Lenna.png -W 50 -H 50
cd ..
iverilog -o design.dat -c filelist.txt
vvp design.dat -vcd
cd Scripts
python Raw2Im.py 
cd ..
