# Sensor Code

This project contains the source code fot the esp8266 device. It assumes that there is a DHT22 device connected on the 5th data pin. An example of how to wire together the esp8266 and the DHT22 can be found [here](https://www.losant.com/blog/getting-started-with-the-esp8266-and-dht22-sensor)

> Note: Don't forget to setup your environment using [this](https://docs.losant.com/getting-started/losant-iot-dev-kits/environment-setup/) guide.

Once both of the above steps have been completed, change the Wifi SSID and the Wifi Password inside the sleep_well_tracker.ino and burn it to esp8266, after a few seconds the esp will start sending data to the online server.
