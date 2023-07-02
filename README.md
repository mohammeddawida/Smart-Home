# Smart Home

<img src="https://mohammed-dev.com/cv/wp-content/uploads/2023/07/smart_home.png" width="500" />

The application is a home device control system such as air conditioning, lighting, radio, or any other electronic device.

They can be controlled through a mobile phone connected to the Wi-Fi network, and the temperature inside the room can be monitored.
## Code Python in Raspberry PI
```python
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
```
<img src="https://github.com/mohammeddawida/Smart-Home/blob/main/ScreenShots/smarthome_bb.png" width="500" />
## Page App
<img src="https://github.com/mohammeddawida/Smart-Home/blob/main/ScreenShots/Screenshot_1.png" width="250" />
<img src="https://github.com/mohammeddawida/Smart-Home/blob/main/ScreenShots/Screenshot_2.png" width="250" />
<img src="https://github.com/mohammeddawida/Smart-Home/blob/main/ScreenShots/Screenshot_3.png" width="250" />
