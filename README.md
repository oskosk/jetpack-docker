## Jetpack-docker

A WordPress composer file for leveraging a WordPress, MariaDB and Jetpack installation with public URLs 

#### Instalation

```
$ git clone git@github.com:oskosk/jetpack-docker.git
$ ./jetpack-docker.sh
```

#### The following will be downloaded


* [Jetpack](https://jetpack.com) source code
* [ngrok](https://ngrok.com/) CLI binary
* A [docker-compose.yml](https://docs.docker.com/compose/) for bringing a container with WordPress installation and another one with a MariaDB instance.

#### Directory strutcture

* `./jetpack`. The Jetpack source code
* `./docker-compose.yml`. The Docker Composer file describing the multi container environment.
* `./opcache-recommended.ini`
* `./ngrok`. The ngrok command line interface which allows you to create a public URL and a tunnel for your local server.

## License

GPL v2
