SET DIR=%~dp0%

::SET DOCKER_PROXY=-e http_proxy=http://proxy:8080 -e https_proxy=http://proxy:8080

docker run -it --rm=true %DOCKER_PROXY% -v "%DIR%config:/config" -v "%DIR%music:/music" putty182/spotify-ripper

@pause