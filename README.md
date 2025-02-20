# Inception

## Project Overview

Inception is a system administration project designed to deepen your knowledge of Docker and containerization. The objective is to set up a small infrastructure composed of various services running in separate Docker containers, orchestrated with `docker-compose` within a Virtual Machine.

## Key Objectives:
- Create Docker images for specific purposes within a personal virtual environment.
- Gain hands-on experience with containerization, deployment, and orchestration using Docker.

## Features
- **NGINX with TLSv1.2 or TLSv1.3**
- **WordPress with PHP-FPM**
- **MariaDB Database**
- **Docker volumes for database and website files**
- **Docker network for container communication**
- **Automatic container restart on failure**
- **Domain name setup (`login.42.fr`) pointing to local IP**
- **Environment variables stored securely in a `.env` file**

## Bonus Features
- **Redis cache for WordPress**
- **FTP server for file management**
- **Static website (non-PHP)**
- **Adminer for database management**
- **Portainer for docker management**

## Installation & Usage
1. Clone the repository:
   ```sh
   git clone https://github.com/Elmehdibennix/Inception_42.git
   cd Inception_42
   ```
2. Configure environment variables in `srcs/.env`
3. Run the project using Makefile:
   ```sh
   make
   ```
4. To stop the project:
   ```sh
   make down
   ```

## Notes
- All Docker images are built manually (no pre-built images allowed except Alpine/Debian base images).
- The `latest` tag is prohibited.
- Credentials must be stored securely in `.env` and ignored by Git.

Happy Dockerizing!



[Previous content remains the same...]

## Virtual Machines vs Containers: A Technical Deep Dive

Understanding the fundamental differences between virtual machines and containers requires examining their architectures, resource utilization patterns, and isolation mechanisms.

### Architectural Differences

Virtual machines and containers take fundamentally different approaches to providing isolated environments:

#### Virtual Machine Architecture
```plaintext
+----------------------------------+
|     Application & Libraries      |
+----------------------------------+
|         Guest OS Kernel          |
+----------------------------------+
|           Hypervisor             |
|  (Type 1: Bare Metal or Type 2)  |
+----------------------------------+
|         Host OS Kernel           |
+----------------------------------+
|          Hardware               |
+----------------------------------+
```

#### Container Architecture
```plaintext
+----------------------------------+
|     Application & Libraries      |
+----------------------------------+
|      Container Runtime (runc)    |
+----------------------------------+
|         Host OS Kernel          |
+----------------------------------+
|          Hardware               |
+----------------------------------+
```

### Resource Allocation and Management

The different architectures lead to distinct approaches in resource handling:

#### Virtual Machine Resource Management
Virtual machines implement complete hardware virtualization:

1. **Memory Management**:
   - Full memory allocation at startup
   - Memory ballooning for dynamic adjustment
   - Page table virtualization
   ```c
   struct kvm_memory_slot {
       gfn_t base_gfn;
       unsigned long npages;
       unsigned long *dirty_bitmap;
       struct kvm_arch_memory_slot arch;
   };
   ```

2. **CPU Virtualization**:
   - Hardware-assisted virtualization (Intel VT-x/AMD-V)
   - Instruction set emulation
   - Virtual CPU scheduling
   ```c
   struct kvm_vcpu {
       struct kvm *kvm;
       int cpu;
       struct mutex mutex;
       struct kvm_run *run;
   };
   ```

#### Container Resource Management
Containers share the host kernel and use lightweight isolation:

1. **Memory Management**:
   - Cgroups memory controller
   - No memory virtualization overhead
   - Direct memory access with limits
   ```c
   struct mem_cgroup {
       struct cgroup_subsys_state css;
       struct page_counter memory;
       struct page_counter swap;
   };
   ```

2. **CPU Management**:
   - CPU shares and quotas via cgroups
   - Native instruction execution
   - No instruction emulation needed

### Isolation Implementation

The isolation mechanisms differ significantly between VMs and containers:

#### Virtual Machine Isolation
VMs provide strong isolation through hardware virtualization:

1. **Hardware-level Isolation**:
```c
struct kvm {
    struct mm_struct *mm;
    struct kvm_memslots *memslots;
    struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
    atomic_t nr_vcpus;
};
```

2. **Memory Isolation**:
   - Extended Page Tables (EPT) or Nested Page Tables (NPT)
   - Complete memory space separation
   - No memory sharing unless explicitly configured

3. **Device Isolation**:
   - Device emulation or pass-through
   - Independent device drivers
   - Separate interrupt handling

#### Container Isolation
Containers use kernel features for lightweight isolation:

1. **Namespace-based Isolation**:
```c
struct nsproxy {
    atomic_t count;
    struct uts_namespace *uts_ns;
    struct ipc_namespace *ipc_ns;
    struct mnt_namespace *mnt_ns;
    struct pid_namespace *pid_ns_for_children;
    struct net *net_ns;
};
```

2. **Resource Isolation**:
   - Cgroup-based resource controls
   - Shared kernel with isolation boundaries
   - Process-level isolation

### Performance Implications

The architectural differences lead to distinct performance characteristics:

#### Virtual Machine Performance
1. **Startup Time**:
   - Longer boot time (seconds to minutes)
   - Full OS initialization required
   - Device initialization overhead

2. **Resource Overhead**:
   - Higher memory usage (GBs)
   - CPU virtualization overhead
   - Storage overhead from full OS

3. **I/O Performance**:
   - Additional I/O virtualization layer
   - Device emulation overhead
   - Network virtualization impact

#### Container Performance
1. **Startup Time**:
   - Near-instant startup (milliseconds)
   - No OS boot required
   - Minimal initialization

2. **Resource Overhead**:
   - Minimal memory overhead (MBs)
   - Native CPU performance
   - Efficient storage layering

3. **I/O Performance**:
   - Near-native I/O performance
   - Direct device access
   - Efficient network namespace

### Security Considerations

Both approaches offer different security trade-offs:

#### Virtual Machine Security
1. **Isolation Strength**:
   - Complete hardware-level isolation
   - Independent security contexts
   - Separate kernel instances

2. **Attack Surface**:
   - Limited to hypervisor interface
   - Hardware virtualization vulnerabilities
   - Guest OS vulnerabilities

#### Container Security
1. **Isolation Strength**:
   - Kernel-level isolation
   - Shared kernel surface
   - Namespace and cgroup boundaries

2. **Attack Surface**:
   - Kernel vulnerability exposure
   - Container runtime vulnerabilities
   - Namespace escape risks

3. **Enhanced Security Features**:
```c
struct security_operations {
    int (*bprm_set_creds)(struct linux_binprm *bprm);
    int (*bprm_check_security)(struct linux_binprm *bprm);
    int (*bprm_secureexec)(struct linux_binprm *bprm);
};
```

This comparison demonstrates how VMs and containers serve different use cases through their distinct architectures. VMs provide stronger isolation at the cost of greater resource overhead, while containers offer efficient resource utilization with lightweight isolation mechanisms. Understanding these differences is crucial for choosing the right technology for specific deployment scenarios.

# Docker Architecture: A Deep Technical Dive

## Understanding Container Fundamentals

At its core, containers are not a distinct technology but rather a combination of several Linux kernel features working together to provide isolation and resource management. Let's explore these fundamental building blocks that make containerization possible.

### Linux Namespaces Deep Dive

Namespaces are a fundamental Linux kernel feature that provide process isolation by partitioning kernel resources. Each namespace creates an abstraction of a global system resource, making it appear as if the process has its own isolated instance of that resource. Here's how each namespace type functions:

#### PID Namespace
The PID namespace isolates process IDs. In a new PID namespace:
- Processes get a new PID, starting from 1
- Processes can't see or affect processes in other namespaces
- When the PID 1 process terminates, all other processes in that namespace are terminated
- Implementation: Uses the `CLONE_NEWPID` flag in the clone() system call

Example of PID namespace creation:
```c
clone(child_func, child_stack, CLONE_NEWPID | SIGCHLD, NULL);
```

#### Network Namespace (NET)
Creates an isolated network stack with:
- Private network interfaces
- IP routing tables
- Firewall rules
- Socket listings
- Connection tracking table
- UNIX domain socket namespace

Implementation details:
```c
struct net *net = new_net_ns(); // Create new network namespace
if (copy_net_ns(cloning_flags, task->nsproxy->net_ns, net)) {
    // Handle error
}
```

#### Mount Namespace (MNT)
Provides an isolated view of the filesystem hierarchy:
- Processes get their own mount points
- Changes to mount points are invisible to other namespaces
- Implements pivot_root() or chroot() functionality
- Crucial for container filesystem isolation

#### IPC Namespace
Isolates System V IPC objects and POSIX message queues:
- Separate shared memory segments
- Semaphore sets
- Message queues
- Prevents cross-container IPC unless explicitly allowed

#### UTS Namespace
Isolates hostname and NIS domain name:
- Allows each container to have its own hostname
- Important for network identity
- Prevents hostname changes from affecting other containers

#### User Namespace
Provides privilege isolation and user mapping:
- Maps container root to unprivileged host user
- Allows privileged operations within container
- Enhanced security through capability management

### Control Groups (cgroups) v2

Cgroups provide resource control and accounting. Version 2 brings significant improvements:

#### Resource Controllers
1. **CPU Controller**:
   ```plaintext
   cpu.weight: 100
   cpu.max: max 100000
   cpu.pressure
   ```
   Implements complete CPU bandwidth control and scheduling

2. **Memory Controller**:
   ```plaintext
   memory.max: max memory limit
   memory.high: soft limit
   memory.swap.max: swap limit
   memory.events: memory events
   ```
   Manages memory allocation and limits

3. **IO Controller**:
   ```plaintext
   io.max: device limits
   io.weight: relative weights
   io.pressure
   ```
   Controls block device I/O

#### Cgroup Implementation
```c
struct cgroup {
    struct cgroup_subsys_state *subsys[CGROUP_SUBSYS_COUNT];
    struct cgroup_root *root;
    struct list_head sibling;
    struct list_head children;
    struct cgroup *parent;
    struct dentry *dentry;
    atomic_t count;
};
```

## Docker Engine Architecture

The Docker Engine is a complex system with multiple components working together:

### Docker Daemon (dockerd)

The daemon implements the Docker Engine API and manages Docker objects. Key components:

1. **Container Management**:
```go
type Container struct {
    ID string
    Name string
    State *State
    Config *Config
    HostConfig *HostConfig
    NetworkSettings *NetworkSettings
}
```

2. **Image Management**:
```go
type Image struct {
    ID string
    RepoTags []string
    RepoDigests []string
    Parent string
    Comment string
    Created time.Time
    Size int64
}
```

### containerd Deep Dive

containerd is an industry-standard container runtime that manages the complete container lifecycle:

#### Container Lifecycle Management
```go
type Container interface {
    ID() string
    Info() ContainerInfo
    Delete(context.Context) error
    NewTask(context.Context, IOCreation) (Task, error)
    Spec() (*specs.Spec, error)
}
```

#### Image Management
```go
type Image interface {
    Name() string
    Target() ocispec.Descriptor
    Labels() map[string]string
    Unpack(context.Context, string) error
}
```

### runc Internals

runc is a low-level container runtime that implements the OCI specification:

#### Container Creation Process
1. **Spec Loading**:
```go
type Spec struct {
    Version string
    Process *Process
    Root *Root
    Hostname string
    Mounts []Mount
    Linux *Linux
}
```

2. **Container Initialization**:
```go
func (r *Runc) Create(context context.Context, id, bundle string, opts *CreateOpts) error {
    return r.command(context, "create", id, bundle).Run()
}
```

## Storage Drivers Architecture

Docker's storage drivers implement a union filesystem approach:

### overlay2 Driver

The most efficient and recommended storage driver:

```plaintext
/var/lib/docker/overlay2/
├── l/              # Contains shortened layer identifiers
├── [layer-id]/     # Layer directory
│   ├── diff/       # Layer contents
│   ├── work/       # Overlay work directory
│   ├── merged/     # Mount point for container
│   └── lower       # Lower layer identifiers
```

Implementation details:
```c
struct ovl_fs {
    struct super_block *sb;
    struct dentry *upper_mnt_root;
    struct dentry *workdir;
    struct dentry *index;
    atomic_t active;
};
```

### Copy-on-Write (CoW)

The CoW mechanism optimizes storage and memory usage:

1. **Read Operations**:
   - Check upper layer first
   - Fall through to lower layers if not found

2. **Write Operations**:
   - Copy file from lower layer to upper
   - Modify copy in upper layer
   - Subsequent reads see modified version

### Layer Management

Docker manages image layers through a content-addressable storage system:

```plaintext
/var/lib/docker/
├── image/
│   ├── overlay2/
│   │   ├── imagedb/
│   │   ├── layerdb/
│   │   └── repositories.json
├── containers/
│   ├── [container-id]/
│   │   ├── config.v2.json
│   │   ├── hostconfig.json
│   │   └── [container-id]-json.log
└── overlay2/
    ├── [layer-id]/
    └── l/
```

## Network Implementation

Docker networking uses network namespaces and virtual Ethernet devices:

### Bridge Network Driver
```plaintext
host
├── eth0 (physical network interface)
├── docker0 (bridge interface)
│   ├── veth1 <--> eth0 (container1)
│   └── veth2 <--> eth0 (container2)
```

Implementation:
```c
struct bridge_info {
    struct net_bridge *br;
    struct net_device *dev;
    struct net *net;
};
```

This deep dive into Docker's architecture reveals how it leverages Linux kernel features to provide containerization. Understanding these components helps in better container deployment and troubleshooting.
