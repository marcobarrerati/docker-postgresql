
* Volumen de persistencia: Usamos el volumen postgres_data para asegurarnos de que los datos de la base de datos se conserven entre reinicios de los contenedores.
* Red de contenedores: El contenedor se conecta a una red postgres_network, lo que permite la conexión entre varios servicios en el futuro si fuera necesario.
* Puerto expuesto: El puerto 5432 está expuesto, lo que te permite conectar a la base de datos desde tu máquina host o cualquier otra aplicación en la misma red de Docker.


```bash
docker-compose -f docker-compose-postgres.yml up
```


## instalar pgadmin

```bash
brew install --cask pgadmin4
```

### verificar

```bash
pgadmin4
```

### desintalar pgadmin
```bash
brew uninstall --cask pgadmin4
```