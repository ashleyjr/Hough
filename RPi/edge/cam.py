#!/usr/bin/python
import time
import picamera

with picamera.PiCamera() as camera:
   camera.vflip = True
   camera.capture('Cam.jpg')
