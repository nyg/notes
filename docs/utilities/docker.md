# Docker

Docker is a tool, or sets of tools, that facilitate the packaging of an application into a so-called container. Whereas a VM runs on emulated hardware which contains an OS, a container runs on the host's kernel. Currently, when we talk about the kernel, we mean the the Linux kernel. When running on macOS or Windows, Docker will use a Linux VM to run the containers. This is because Docker uses Linux kernel functionalities such as cgroups and namespaces among others.
