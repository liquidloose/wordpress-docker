This is a basic Docker/Wordpress setup. You can use this to spin up a quick environment to develop in.

It uses Docker as the environment, Mysql as the database and Apache as the web server. The settings can all be adjusted in the .yml file provided.

1. `docker  build -t insert-image-name-here . ` 
2. Create a .env file and make it look something like this:

    `
    DB_PORT = 3000
    WEB_PORT= 8003
    MYSQL_ROOT_PASSWORD= "catsAreBros"
    DB_NAME= "database-name"
    DB_USER= "name"
    DB_PASSWORD= "password"
    CLIENT_SOURCE= "/path/to/your/wordpress/installation"
    CONTAINER_TARGET= "/var/www/html" // Leave this as is. This will be where your files are located inside of your container.
    `

3. Once that's complete, in the same directory, enter the following command: `docker compose up`.

That will build your container and you are all set! You now have an environment that you can spin up in minutes!

