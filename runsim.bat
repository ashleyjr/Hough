cd Scripts
c:\Python27\python.exe Im2InHandle.py -I Lenna.png -W 50 -H 50
cd ..
c:\iverilog\bin\iverilog.exe -o design.dat -c filelist.txt
c:\iverilog\bin\vvp.exe design.dat -vcd
cd Scripts
c:\Python27\python.exe Raw2Im.py 
cd ..
pause
