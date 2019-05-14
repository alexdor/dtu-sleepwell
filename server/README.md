# Serverside Code

This project is written in Golang and it uses InfluxDB (a timeseries database) to store the data.

The easies way to run the server is with the usage of [Docker](https://docs.docker.com/install/) and [Docker compose](https://docs.docker.com/compose/install/). Once you've installed the above, you can follow these steps:

* Open a terminal and navigate to the folder that contains this file.
* Run `docker-compose up --build` (this command will build the source code, download the InfluxDB and run both of them).
* After a few minutes (depending on your machine and your internet connection) the server should be listening on [http://localhost:8000/data](http://localhost:8000/data)
* When you want to quite just press `Ctr-c`.

> Note: this is an API only server, there is no graphical interface it only responds with JSON responses.
