# User Documentation

Welcome to the Inception project user documentation. This guide explains in clear and simple terms how to understand, run, access, manage, and monitor the services provided by this stack.

## 1. Stack Services Overview

The infrastructure consists of three main containerized services orchestrated via Docker Compose within a Virtual Machine or host system:

* **NGINX (`nginx`)**: Acts as the sole entry point into the infrastructure. It handles secure HTTPS connections using TLSv1.2 or TLSv1.3 on port 443.
* **WordPress + PHP-FPM (`wordpress`)**: Manages the website content and executes PHP scripts. It runs independently without its own NGINX instance.
* **MariaDB (`mariadb`)**: A dedicated relational database container that securely stores all WordPress data and user tables.

All persistent data (database files and WordPress website files) are stored securely using Docker named volumes pointing to the host machine path (e.g., `/home/username/data`).

## 2. Starting and Stopping the Project

All management commands are executed from the root directory of the project using the Makefile.

* **Prerequisites**: Ensure your local domain is configured in `/etc/hosts` (e.g., `127.0.0.1 inception.local`).
* **Start the Project (Build & Run)**: Run `make` (alternatively, `make up` or `docker compose -f srcs/docker-compose.yml up --build -d` depending on your specific Makefile setup).
* **Stop the Project**: Run `make down`.
* **Clean Everything**: Stop and remove containers, networks, volumes, and images using `make clean`.

## 3. Accessing the Website and Administration Panel

Because NGINX is configured as the secure gateway, you must access the services via HTTPS through your designated domain name:

* **Public Website**: Open your web browser and navigate to `https://inception.local` (replace `inception.local` with your actual configured domain). Since self-signed SSL certificates are typically used, you may need to accept the browser's security warning/exception.
* **WordPress Administration Panel (`wp-admin`)**: Navigate to `https://inception.local/wp-admin`.

## 4. Locating and Managing Credentials

For security compliance, credentials, database passwords, and environment configurations are strictly isolated and excluded from version control:

* **Environment File (`.env`)**: Located at `srcs/.env`, this file holds non-sensitive and configuration variables such as the domain name, database name, and database user parameters.
* **Secrets / Credentials Files**: Database root passwords, MySQL user passwords, and WordPress administrator passwords are securely stored locally (e.g., inside the `srcs/` or local secret configuration) as required by project standards.
* **Management**: To update credentials, modify the `.env` or credential files locally, then rebuild the stack using `make clean` followed by `make`. Never commit plaintext passwords directly into your repository.

## 5. Checking That Services Are Running Correctly

To verify that all containers are active, healthy, and communicating properly:

1. **Check Docker Containers Status**: Run the container status command `docker ps` from your terminal to verify that you see three active containers (`nginx`, `wordpress`, and `mariadb`) with their restart policies and port mappings (`443`) properly displayed.
2. **Inspect Container Logs (for troubleshooting)**: If a service fails to start or behaves unexpectedly, you can view its logs via the `docker logs <container>` command.