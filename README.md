# WordPress Docker Development Environment

A complete local WordPress development setup using Docker, with automated plugin installation and custom plugin management via Git submodules.

## Features

- WordPress with Apache web server
- MySQL database
- phpMyAdmin for database management
- WP-CLI for command-line WordPress management
- Automated plugin installation on startup
- Custom plugin development with Git submodules
- Bind-mounted wp-content for persistent local development

## Prerequisites

- Docker and Docker Compose
- Git

## Quick Start

### 1. Clone the Repository

```bash
git clone --recurse-submodules https://github.com/your-username/wordpress-docker.git
cd wordpress-docker
```

If you already cloned without submodules:
```bash
git submodule update --init --recursive
```

### 2. Create Environment File

Create a `.env` file in the project root:

```env
# Database
MYSQL_ROOT_PASSWORD=your_root_password
DB_NAME=wordpress
DB_USER=wordpress
DB_PASSWORD=your_db_password

# Ports
WEB_PORT=8012
PHP_MYADMIN_PORT=8081
```

### 3. Start the Environment

```bash
docker compose up -d
```

### 4. Access Your Sites

- **WordPress**: `http://localhost:8012` (or your WEB_PORT)
- **phpMyAdmin**: `http://localhost:8081` (or your PHP_MYADMIN_PORT)

## Services

| Service | Description | Image |
|---------|-------------|-------|
| `wordpress` | WordPress with Apache | Custom build from `Dockerfile` |
| `db` | MySQL database | `mysql:latest` |
| `my-wpcli` | WP-CLI for command-line management | Custom build from `Dockerfile.wpcli` |
| `phpmyadmin` | Database admin interface | `phpmyadmin/phpmyadmin` |

## Project Structure

```
wordpress-docker/
├── custom-plugins/          # Git submodules for custom plugins
│   ├── to-tha-top/
│   └── rivedge-image-slider/
├── WordPress/
│   └── wp-content/          # Bind-mounted WordPress content
├── docker-compose.yml       # Docker services configuration
├── Dockerfile               # WordPress image with extensions
├── Dockerfile.wpcli         # WP-CLI image with git
├── wpcli-entrypoint.sh      # Plugin installation script
├── wp-config.php            # WordPress configuration
├── wordpress.ini            # PHP configuration
└── .env                     # Environment variables (create this)
```

## Automated Plugin Installation

The following plugins are automatically installed and activated on container startup:

**From WordPress.org:**
- Prime Mover (backup/migration)
- Create Block Theme (theme development)
- Query Monitor (debugging)
- Google Site Kit (analytics)

**Custom Plugins (via submodules):**
- to-tha-top
- rivedge-image-slider

To modify which plugins are installed, edit `wpcli-entrypoint.sh`.

## Custom Plugin Development

Custom plugins are managed as Git submodules in the `custom-plugins/` directory and bind-mounted into WordPress.

### Adding a New Custom Plugin

1. Add the submodule:
```bash
git submodule add https://github.com/username/plugin-name.git custom-plugins/plugin-name
```

2. Add bind mount to `docker-compose.yml` under wordpress volumes:
```yaml
- type: bind
  source: "./custom-plugins/plugin-name"
  target: "/var/www/html/wp-content/plugins/plugin-name"
```

3. Add activation to `wpcli-entrypoint.sh`:
```bash
wp plugin activate plugin-name --path=/var/www/html || echo "Warning: Failed to activate plugin-name"
```

4. Restart containers:
```bash
docker compose up -d --force-recreate
```

### Updating Custom Plugins

Pull latest changes for all submodules:
```bash
git submodule update --remote
```

Or update a specific plugin:
```bash
cd custom-plugins/plugin-name
git pull origin main
```

## WP-CLI Usage

Access WP-CLI commands:

```bash
# Interactive shell
docker compose exec my-wpcli sh

# Run single command
docker compose exec my-wpcli wp plugin list --path=/var/www/html
docker compose exec my-wpcli wp user list --path=/var/www/html
docker compose exec my-wpcli wp option get siteurl --path=/var/www/html
```

## Common Commands

```bash
# Start containers
docker compose up -d

# Stop containers
docker compose down

# Rebuild after Dockerfile changes
docker compose build
docker compose up -d

# View logs
docker compose logs -f              # All services
docker compose logs -f wordpress    # WordPress only
docker compose logs -f my-wpcli     # WP-CLI only

# Restart a specific service
docker compose restart my-wpcli

# Force recreate containers
docker compose up -d --force-recreate

# Remove everything including volumes (WARNING: deletes database)
docker compose down -v
```

## Troubleshooting

### Plugins not installing
Check WP-CLI logs:
```bash
docker compose logs my-wpcli
```

### Permission issues
The containers run as user 1000:1000 to match typical host user permissions. If you have issues, check your host user ID with `id -u`.

### Port conflicts
Change `WEB_PORT` or `PHP_MYADMIN_PORT` in your `.env` file if ports are already in use.

### Database connection issues
Ensure the database container is fully started before WordPress:
```bash
docker compose logs db
```

### Clear browser cache
If WordPress redirects to wrong port, clear browser cache or use incognito mode.

## Building Custom Images

The WordPress image is built locally and tagged as `rivedge/wordpress-image:latest`. To rebuild:

```bash
docker compose build wordpress
```

The WP-CLI image is built as `rivedge-wpcli:latest`:

```bash
docker compose build my-wpcli
```

## License

GPL-2.0-or-later
