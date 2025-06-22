# Modificación e Inyección de Tráfico FTP con Scapy

## Descripción

El presente repositorio contiene los archivos y scripts usados para analizar y modificar el tráfico del protocolo FTP entre un cliente y un servidor implementados en contenedores Docker. Se emplea la herramienta Scapy para interceptar, modificar e inyectar paquetes en tiempo real, y Wireshark para la captura y análisis del tráfico.

---

## Arquitectura

- Red Docker personalizada `red-ftp` con los contenedores:
  - `ftp-server` (Servidor FTP)
  - `ftp-client` (Cliente FTP)
  - `scapy-tool` (Herramienta para manipulación de tráfico con Scapy)

---

## Requisitos

- Docker y Docker Compose instalados.
- Python 3.13+ (en contenedor o local).
- Scapy y dependencias instaladas.

---

## Instalación y Ejecución

1. Crear y arrancar la red Docker:
   ```bash
   docker network create red-ftp

2. Iniciar contenedores cliente y servidor en la red:
   ```bash
   docker run -dit --name ftp-server --network red-ftp stilliard/pure-ftpd
   docker run -dit --name ftp-client --network red-ftp appropriate/ftp
   
3. Iniciar contenedor para Scapy con acceso a la red:
   ```bash
   docker run -it --rm --name scapy-tool --network red-ftp python:3.13 bash

4. Instalar dependencias en el contenedor Scapy:
   ```bash
   apt-get update && apt-get install -y tcpdump iproute2 iputils-ping libpcap-dev gcc python3-dev
   pip install scapy

5. Ejecutar los scripts de fuzzing y modificación:
   ```bash
   python3 fuzzing_random_user.py
   python3 fuzzing_random_payload.py
   python3 mod_del.py
   python3 mod_fake.py
   python3 mod_ttl.py

---

## Funcionamiento de cada script

fuzzing_random_user.py: Simular un ataque de fuerza bruta mediante la inyección repetida de comandos USER con nombres aleatorios, con el fin de observar cómo reacciona el servidor a intentos masivos de autenticación inválida.

fuzzing_random_payload.py: Inyectar comandos aleatorios para observar si el servidor interpreta erróneamente comandos malformados o inesperados, simulando un ataque de protocol confusion o command injection.

mod_del.py: Modificar el comando FTP que indica subir un archivo (STOR) para que el servidor reciba un comando de borrado (DELE), evaluando si el servidor borra el archivo en lugar de subirlo.

mod_fake.py: Modificar el nombre del archivo a subir para ver si el servidor guarda el archivo con el nombre modificado o genera error.

mod_ttl.py: Modificar la bandera TCP en los paquetes para provocar interrupciones o resets en la conexión.

---

## Resultados

Los scripts permiten observar cómo el servidor responde a tráfico inesperado o malformado, demostrando potenciales vulnerabilidades o robustez del sistema, mayores analisis se encuentran en el informe. 

---

## Autores

Hernán Acosta y Mateo Solari.
