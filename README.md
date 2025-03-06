# Basic Docker/WordPress Setup

## Use this setup to quickly spin up a local development site with Docker as the environment, MySQL as the database, and Apache as the web server. Adjust settings in the .yml file, although using an .env file is recommended (see step 2).

# Steps
Build Your Own Image:

In the same directory as the Dockerfile, run:

```bash
docker build -t insert-image-name-here .
```

Edit line 21 of the .yml file to:

```yaml
docker.io/library/<your-container-name>
```
instead of liquidloose/wordpress-image.

# Use Provided Image:

Create an .env file and add your custom values:

```env
DB_PORT=3000
WEB_PORT=8003
MYSQL_ROOT_PASSWORD="catsAreBros"
DB_NAME="database-name"
DB_USER="name"
DB_PASSWORD="password"
CLIENT_SOURCE="/path/to/your/wordpress/installation"
CONTAINER_TARGET="/var/www/html" # Leave this as is. This will be where your files are located inside of your container.
```

## Start Docker:

In the same directory, enter the command:

```bash
docker compose up
```

This will build your container, and you'll have an environment ready to use in minutes!

## Access Your Dev Environment:

In your browser, type in your host IP address followed by the port. For example:

192.168.1.26:8003
If 192.168.1.26 is the IP address of your computer and you set the WEB_PORT to 8003, you will now have access to your new development environment.