This is a basic Docker/Wordpress setup. You can use this to quickly spin up a local dev site.

It uses Docker as the environment, Mysql as the database and Apache as the web server. The settings can all be adjusted in the .yml file provided, though it is recomended that you use an .env file(see number 2).

1. If you want to build off of my image and make your own, then in the same directory as the Dockerfile run: `docker  build -t insert-image-name-here . `. If you go this route, you will need to edit line 21 of the .yml file. You will have to enter your image name there instead of `liquidloose/wordpress-image`.

2. If you want to use the image that I have provided as-is,then you simply need to create an .env file and add your custom values. Here is an example of what that would look like:

    `DB_PORT = 3000` <br />
    `WEB_PORT= 8003` <br />
    `MYSQL_ROOT_PASSWORD= "catsAreBros"` <br />
    `DB_NAME= "database-name"`<br />
    `DB_USER= "name"` <br />
    `DB_PASSWORD= "password"` <br />
   ` CLIENT_SOURCE= "/path/to/your/wordpress/installation"` <br />
   ` CONTAINER_TARGET= "/var/www/html" // Leave this as is. This will be where your files are located inside of your container.` <br />

3. Once that's complete, in the same directory, enter the following command: `docker compose up`.

That will build your container and you are all set! You now have an environment that you can spin up in minutes! In your browser, simply type in your host ip address followed by the port. Here's an example: `192.168.1.26:8003`. If 192.168.1.26 is the ip address of your computer and you set the WEB_PORT to 8003 as shown above, you will now have access to your new dev environment! Have fun!

Docker Hub: https://hub.docker.com/r/liquidloose/wordpress-image

