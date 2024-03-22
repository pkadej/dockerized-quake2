# Quake 2 pro dedicated server with opentdm mod
Goals:
- one container contain one dedicated server for specified port
- you can run as many docker containers as you want
- configs, paks, maps, mods are kept outside the container

### Clone this repo
```bash
git clone https://github.com/pkadej/dockerized-quake2.git
```

### Copy PAKs
Copy PAK, maps and texture files into dist/baseq2.

### Build
```bash
chmod u+x make.sh
./make.sh
```

### Run
```bash
chmod u+x install.sh
./install.sh
```
You need to specify port and directory where baseq2 and configuration files will be stored.


