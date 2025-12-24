#!/bin/bash
#
# WP-CLI Entrypoint Script
#
# Waits for WordPress to be ready, then installs and activates plugins.
#

# Function to wait for WordPress to be ready
wait_for_wordpress() {
    echo "Waiting for WordPress to be ready..."
    sleep 15  # Give services time to start
    
    # Try to check if WordPress is installed
    max_attempts=30
    attempt=0
    
    while [ $attempt -lt $max_attempts ]; do
        if wp core is-installed --path=/var/www/html 2>/dev/null; then
            echo "WordPress is ready!"
            return 0
        fi
        echo "WordPress not ready yet, attempt $((attempt+1))/$max_attempts..."
        sleep 5
        attempt=$((attempt+1))
    done
    
    echo "Warning: Timed out waiting for WordPress, proceeding anyway..."
}

# Function to install and activate plugins
install_plugins() {
    echo "Installing plugins..."
    
    # WordPress.org plugins
    wp plugin install prime-mover --activate --path=/var/www/html || echo "Warning: Failed to install prime-mover"
    wp plugin install create-block-theme --activate --path=/var/www/html || echo "Warning: Failed to install create-block-theme"
    wp plugin install query-monitor --activate --path=/var/www/html || echo "Warning: Failed to install query-monitor"
    wp plugin install google-site-kit --activate --path=/var/www/html || echo "Warning: Failed to install google-site-kit"
    
    # Custom plugins (bind mounted from ./custom-plugins/)
    wp plugin activate to-tha-top --path=/var/www/html || echo "Warning: Failed to activate to-tha-top"
    wp plugin activate rivedge-image-slider --path=/var/www/html || echo "Warning: Failed to activate rivedge-image-slider"
    
    echo "Plugin installation complete!"
}

# Main execution
wait_for_wordpress
install_plugins

# Keep the container running for interactive use
echo "WP-CLI container ready. Keeping container alive..."
exec /bin/sh
