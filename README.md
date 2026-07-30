*This project has been created as part of the 42 curriculum by aammisse.*

# Inception

## Description
Inception is a system administration project focused on building a secure, containerized web infrastructure using [Docker Compose](./srcs/docker-compose.yml) within a Virtual Machine.

### Stack Overview
- **NGINX**: Functions as the sole entry point using HTTPS with TLSv1.2 or TLSv1.3 on port 443.
- **WordPress + PHP-FPM**: Web application container running without an embedded NGINX service.
- **MariaDB**: Database container serving the WordPress site.

### Technical Comparisons
- **Virtual Machines vs. Docker**: Virtual Machines virtualize physical hardware with a full guest OS, making them resource-intensive. Docker shares the host OS kernel via containerization, yielding faster startup times and lower overhead.
- **Secrets vs. Environment Variables**: Environment variables store plain text configurations. Docker Secrets securely deliver sensitive data (like database credentials) to containers without exposing them in plaintext.
- **Docker Network vs. Host Network**: Custom Docker networks isolate container traffic and provide internal DNS resolution. Host networking removes network boundaries by attaching containers directly to the host's network interface.
- **Docker Volumes vs. Bind Mounts**: Docker volumes are managed by Docker and stored in `/home/aammisse/data` on the host for persistence and performance. Bind mounts depend directly on specific host directory paths and permissions.

## Instructions

### Prerequisites
- Docker and Docker Compose installed.
- Domain configuration in `/etc/hosts`:
  ```bash
  127.0.0.1 aammisse.42.fr

### Execution
Run commands using the [Makefile](./Makefile):
- Build and start the services: make
- Stop Services: make down
- Clean everything: make clean

## Resources & AI Usage

### Resources
- [Docker Documentation](https://docs.docker.com/ "Official Docker Documentation")
- [Nginx Admin Guide](https://docs.nginx.com/ "Official Nginx Documentation")
- [MariaDB Documentation](https://mariadb.com/docs "Official MariaDB Documentation")

### AI Usage
#### AI tools were used to assist in the project's development:

- Docker Dependencies: Clarifying service startup order, volume mounts, and container communication.

- Docker Compose: Learning multi-container orchestration, syntax, and stack management.

- Configuration: Assisting with syntax troubleshooting and documentation structure.