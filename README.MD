This is a basic Docker/Wordpress setup. You can use this to spin up a quick environment to develop in.

It uses Docker as the environment, Mysql as the database and Apache as the web server. The settings can all be adjusted in the .yml file provided.

To start the process off, you need build the Docker image. You can do this by using the command `docker  build -t wordpress-image`. 

*note* that
'wordpress-image' is the name of the image you will be building off of in the .yml file. You can name your image whatever you want, you just have to make sure to change the name of the image in the .yml file in the section 'image: <image-name>'. 

Next, open the .yml file and change the settings to your liking. *NOTE* Make sure the name of your image is the same name of the image that you just built. Otherwise when you 'compose up' Docker won't know what image to build off of.

Once that's complete, in the same directory, enter the following command: `docker compose up`.

That will build your container and you are all set! You now have an environment to develop your WordPress sites in that you can spin up in minutes! 

