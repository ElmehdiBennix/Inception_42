# Inception - Docker Infrastructure Project

A comprehensive Docker-based web infrastructure implementing WordPress, NGINX, MariaDB, and additional services with a focus on security, modularity, and best practices.

## Project Architecture

```ascii
                                +-----------------------+
                                |        Docker         |
                                |     Infrastructure    |
                                +-----------------------+
                                            |
                              +-------------+-------------+
                              |             |             |
                       +------v------+ +----v-------+ +---v------+
                       |   NGINX     | | WordPress  | | MariaDB  |
                       | Container   | | Container  | |Container |
                       +------+------+ +---+--------+ +---+------+
                              |            |              |
                              |            |              |
                    +---------v------------v--------------v-------+
                    |              Docker Network                 |
                    +---------------------------------------------+
                                           |
                     +-----------+---------+----------+-----------+
                     |           |         |          |           |
               +-----v---+ +-----v---+ +---v-----+ +--v------+ +--v-----+
               |  Redis  | |   FTP   | | Adminer | | Static  | |Custom  |
               |  Cache  | |  Server | |         | | Website | |Service |
               +---------+ +---------+ +---------+ +---------+ +--------+


               Volumes +------+----------------+
                              |                |
                        +-----v-----+    +-----v----+
                        | WordPress |    | Database |
                        |   Files   |    |   Data   |
                        +-----------+    +----------+
```

## Security Measures

1. Environment Variables
   - Stored in .env file
   - No hardcoded credentials
   - Secure variable passing

2. Network Isolation
   - Custom Docker network
   - Internal service communication
   - Limited external access

3. TLS Implementation
   - TLSv1.2/1.3 only
   - Strong cipher suites
   - Proper certificate management

## Setup Instructions

1. Clone the repository:

   ```bash
   git clone https://github.com/ElmehdiBennix/Inception_42.git
   cd Inception_42
   ```

2. Create .env file:

   ```bash
   # Edit srcs/.env with your configurations
   cp srcs/.env.example srcs/.env
   ```

3. Build and start services:

   ```bash
   # Start the project
   make
   # down the project
   make down
   # remove the project from docker
   make fclean
   ```

## Understanding Docker and Container Architecture

### What is Docker?

Docker is a platform for developing, shipping, and running applications in isolated environments called containers. Unlike traditional virtual machines that emulate entire operating systems, Docker containers share the host system's kernel and isolate only the application layer. This makes them lightweight, fast to start, and efficient with system resources.

### Key Docker Concepts

1. **Containers**
   - Lightweight, standalone executable packages
   - Contains everything needed to run an application:
     - Code
     - Runtime
     - System tools
     - Libraries
     - Settings

2. **Images**
   - Read-only templates used to create containers
   - Built using layers
   - Each instruction in a Dockerfile creates a new layer
   - Layers are cached and reused for efficient builds

3. **Docker Engine**
   - Client-server application
   - Server runs as a daemon process (dockerd)
   - REST API defines interfaces for client interaction
   - CLI client (docker) provides user interface

## Best Practices

1. **In Docker**
   - Use multi-stage builds where appropriate
   - Minimize layer count
   - Implement proper caching
   - Clean up unnecessary files

2. **In Container Design**
   - Single responsibility principle
   - No unnecessary processes
   - Proper PID 1 handling
   - Clean shutdown handling

3. **In Security**
   - Minimal base images
   - Regular security updates
   - Proper permission management
   - Network isolation

4. **In Resource Management**
   - Volume mapping
   - Container restart policies
   - Resource limits
   - Health checks

5. **In Code Organization**
   - Modular Dockerfile structure
   - Clear documentation
   - Consistent naming conventions
   - Version control best practices
