from flask import Flask, request
import RPi.GPIO as GPIO
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
import Adafruit_DHT
sensor = Adafruit_DHT.DHT11

from random import *
app = Flask(__name__)

@app.route("/")
def index():
    return '';
@app.route("/on")
def on():
    pin = int(request.args.get('pin'))
    GPIO.setup(pin,GPIO.OUT)
    GPIO.output(pin,GPIO.HIGH)
    return {pin: "on"}
 

@app.route("/off")
def off():
    pin = int(request.args.get('pin'))
    GPIO.setup(pin,GPIO.OUT)
    GPIO.output(pin,GPIO.LOW)
    return {pin: "off"}

@app.route("/status")
def status():
    pin = int(request.args.get('pin'))
    GPIO.setup(pin,GPIO.OUT)
    pin_status = GPIO.input(pin)
    return {pin:pin_status}

@app.route("/timp")
def timp():
    room_num = int(request.args.get('room_num'))
    humidity, temperature = Adafruit_DHT.read_retry(sensor, room_num)
    return {'Timp':temperature,'Humidity':humidity}

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0',port=8080)