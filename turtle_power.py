import sys
from pubnub import Pubnub
from subprocess import call
import thread
import time
import random
import RPi.GPIO as GPIO

publish_key = len(sys.argv) > 1 and sys.argv[1] or 'demo-36'
subscribe_key = len(sys.argv) > 2 and sys.argv[2] or 'demo-36'
secret_key = len(sys.argv) > 3 and sys.argv[3] or 'demo-36'
cipher_key = len(sys.argv) > 4 and sys.argv[4] or ''
ssl_on = len(sys.argv) > 5 and bool(sys.argv[5]) or False

opID = ""
channelID = ""

pubnub = Pubnub(publish_key=publish_key, subscribe_key=subscribe_key,
                secret_key=secret_key, cipher_key=cipher_key, ssl_on=ssl_on)


channel = 'battroborg'

def pubMessage(message):
    print(message)

def getLEDStatus():
    pubnub.publish(channel, leds, callback=pubMessage, error=pubMessage)

def callback(message, channel):

    if 'channelID' in message:
        channelID = message['channelID']

	if 'opID' in message:
		opID = message['opID']

		
		if opID == "up":
			if channelID == "a":
				rtn = thread.start_new_thread(a_up, ())
			elif channelID == "b":
				rtn = thread.start_new_thread(b_up, ())

                if opID == "down":
                        if channelID == "a":
                                rtn = thread.start_new_thread(a_down, ())
                        elif channelID == "b":
                                rtn = thread.start_new_thread(b_down, ())


        	print "message received for turtlepower: " + str(rtn) + " " + message['channelID'] + ":" + message["opID"]

def a_up():
    call(["irsend", "SEND_ONCE", "/home/pi/lircd.conf", "KEY_C"])

def b_up():
    call(["irsend", "SEND_ONCE", "/home/pi/lircd.conf", "KEY_Y"])    

def a_down():
    call(["irsend", "SEND_ONCE", "/home/pi/lircd.conf", "KEY_B"])

def b_down():
    call(["irsend", "SEND_ONCE", "/home/pi/lircd.conf", "KEY_Z"])    


def error(message):
    print("ERROR : " + (message))


def connect(message):
    print("CONNECTED")
    #startCycling()


def reconnect(message):
    print("RECONNECTED")


def disconnect(message):
    print("DISCONNECTED")

def pnSubscribe():
    pubnub.subscribe(channel, callback=callback, error=callback,
                     connect=connect, reconnect=reconnect, disconnect=disconnect)

# try:
#     thread.start_new_thread( pnSubscribe, () )
# except:
#     print "Error: unable to start Subscribe thread"

pnSubscribe()
