This is a basic Docker/Wordpress setup. You can use this to spin up a quick environment to develop in.

It uses Docker as the environment, Mysql as the database and Apache as the web server. The settings can all be adjusted in the .yml file provided.

1. If you want to make your own container: `docker  build -t insert-image-name-here . ` 
2. If you want to make your own container: you're free to add the values in a .env file and make it look something like this:

    `DB_PORT = 3000` <br />
    `WEB_PORT= 8003` <br />
    `MYSQL_ROOT_PASSWORD= "catsAreBros"` <br />
    `DB_NAME= "database-name"`<br />
    `DB_USER= "name"` <br />
    `DB_PASSWORD= "password"` <br />
   ` CLIENT_SOURCE= "/path/to/your/wordpress/installation"` <br />
   ` CONTAINER_TARGET= "/var/www/html" // Leave this as is. This will be where your files are located inside of your container.` <br />

3. Once that's complete, in the same directory, enter the following command: `docker compose up`.

That will build your container and you are all set! You now have an environment that you can spin up in minutes!

Docker Hub: https://hub.docker.com/r/liquidloose/wordpress-image

