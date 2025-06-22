if ! docker network inspect red-ftp >/dev/null 2>&1; then
  echo "Creando red Docker red-ftp..."
sudo docker network create --subnet=172.19.0.0/16 red-ftp
else
  echo "Red Docker 'red-ftp' ya existe."
fi

echo "Construyendo imagen del servidor FTP..."
sudo docker build -t ftp-server-img -f docker/Dockerfile_ftp_server ./docker

echo "Construyendo imagen del cliente FTP..."
sudo docker build -t ftp-client-img -f docker/Dockerfile_ftp_client ./docker

echo "Iniciando contenedor del servidor FTP..."
sudo docker run -d \
  --rm \
  --name ftp-server \
  --network red-ftp \
  --ip 172.19.0.2 \
  -p 21:21 -p 30000-30009:30000-30009 \
  -e FTP_USER_NAME=hernan \
  -e FTP_USER_PASS=taller2 \
  -e FTP_USER_HOME=/home/ftpuser \
  ftp-server-img

echo "Iniciando cliente FTP..."
sudo docker run -it --rm \
  --name ftp-client \
  --network red-ftp \
  --ip 172.19.0.3 \
  ftp-client-img
