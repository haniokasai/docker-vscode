# docker-vscode

���{���Visual Studio Code���g����C���[�W

## Running

### Linux

```
docker run -d --rm -e "DISPLAY=$DISPLAY" -v /tmp/.X11-unix:/tmp/.X11-unix -name vscode haniokasai/docker-vscode
```

### Windows
```
docker run -d --rm -name vscode haniokasai/docker-vscode
```
