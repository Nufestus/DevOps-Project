# Developer Documentation

This document describes how a developer can set up, build, launch, manage, and inspect the Inception project infrastructure from scratch.

## 1. Environment Setup from Scratch

To set up the development environment, follow these steps:

* **Prerequisites**: 
  * A Linux Virtual Machine or a compatible Unix-like host system.
  * Docker and Docker Compose installed on the host/VM.
  * Local host resolution configured in `/etc/hosts` mapping `127.0.0.1 inception.local` (replace `inception.local` with your target domain name).
* **Configuration Files**:
  * All configuration files must be placed inside the `srcs/` directory.
  * Create and configure the environment variables file at `srcs/.env`. This file specifies non-sensitive parameters such as the domain name, database name, and database user parameters.
* **Secrets & Credentials**:
  * Secure credentials (such as database root passwords, MySQL user passwords, and WordPress administrator passwords) must be managed locally.
  * No plaintext passwords or sensitive keys are permitted inside `Dockerfile`s or tracked directly in version control. Use secure local credential files or environment variables as required by project standards.

## 2. Building and Launching the Project

All orchestration is handled via Docker Compose inside the `srcs/` directory, controlled through a root-level `Makefile`.

* **Build and Start (Default Makefile target)**: Run `make` from the root directory of the project (alternatively, `make up` or `docker compose -f srcs/docker-compose.yml up --build -d`).
* **Under the Hood**: The Makefile builds the container images from scratch (using custom Dockerfiles for NGINX, WordPress + PHP-FPM, and MariaDB), initializes the custom Docker network, creates the required persistent named volumes, and launches all services in detached mode.

## 3. Managing Containers and Volumes

Developers can manage the stack lifecycle and inspect resources using standard Makefile targets and Docker commands:

* **Stop the Project**: Run `make down`.
* **View Container Status**: Run `docker ps` or `docker compose -f srcs/docker-compose.yml ps`.
* **Inspect Container Logs (Debugging)**: Run `docker logs [container_name]`.
* **Clean and Reset**: Stop and remove containers, networks, and images using `make clean`.
* **Full Purge (Including Volumes)**: Run `make fclean` to completely wipe the environment including persistent volumes (use with caution).

## 4. Data Storage and Persistence

Data persistence is handled strictly via Docker named volumes to ensure isolation and performance:

* **Named Volumes**: The project utilizes two mandatory Docker named volumes: one for storing the WordPress database files (MariaDB) and one for storing the WordPress website source files.
* **Host Storage Location**: Both named volumes map and store their persistent data on the host machine at a designated data path (e.g., `/home/username/data` or `/data`).
* **Persistence Guarantee**: Stopping or restarting containers using `make down` preserves all data inside these volumes. Data is only destroyed when volumes are explicitly removed via `fclean` or manual volume deletion.