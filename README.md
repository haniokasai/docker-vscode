# docker-vscode

日本語でVisual Studio Codeを使えるイメージ

## Running

### Linux

```
docker run -d --rm -e "DISPLAY=$DISPLAY" -v /tmp/.X11-unix:/tmp/.X11-unix --name vscode haniokasai/docker-vscode
```

### Windows
```
docker run -d --rm --name vscode haniokasai/docker-vscode
```



## Build

```
git clone https://github.com/haniokasai/docker-vscode
cd docker-vscode
git pull 
docker build . -t haniokasai/docker-vscode
```

