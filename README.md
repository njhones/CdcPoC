# Debezium Tutorial

This POC for CDC on sql server using debezium connector and kafka. It is base on the [Debezium Tutorials](https://github.com/debezium/debezium-examples/tree/main/tutorial).

## Using SQL Server

From a linux shell/ubuntu distro WSL on Windows

```shell
export DEBEZIUM_VERSION=1.8
docker-compose -f docker-compose-sqlserver.yaml up

# Initialize database and insert test data
cat debezium-sqlserver-init/inventory.sql | docker-compose -f docker-compose-sqlserver.yaml exec -T sqlserver bash -c '/opt/mssql-tools/bin/sqlcmd -U sa -P $SA_PASSWORD'

# Start SQL Server connector
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @register-sqlserver.json
```

Verify the connector is created by going to http://localhost:8083/connectors/ and verify that it is also [running](http://localhost:8083/connectors/inventory-connector/status). 

Check [debezium-ui](http://localhost:8080/connectors/)

Check [kafdrop](http://localhost:9000/) for topics / messages / partitions. 

```shell

# Consume messages from a Debezium topic
docker-compose -f docker-compose-sqlserver.yaml exec kafka /kafka/bin/kafka-console-consumer.sh \
    --bootstrap-server kafka:9092 \
    --from-beginning \
    --property print.key=true \
    --topic server1.dbo.customers

# Modify records in the database via SQL Server client (do not forget to add `GO` command to execute the statement)
docker-compose -f docker-compose-sqlserver.yaml exec sqlserver bash -c '/opt/mssql-tools/bin/sqlcmd -U sa -P $SA_PASSWORD -d testDB'

# Shut down the cluster
docker-compose -f docker-compose-sqlserver.yaml down
```

# Useful links

[Debezium Tutorial](https://debezium.io/documentation/reference/stable/tutorial.html)

[Debezium connector for SQL Server](https://debezium.io/documentation/reference/1.8/connectors/sqlserver.html)

[Debezium images](https://github.com/debezium/docker-images)

[Debezium UI](https://debezium.io/blog/2021/08/12/introducing-debezium-ui/)

[Debezium Engine](https://debezium.io/documentation/reference/1.8/development/engine.html)

[Debezium Documentation](https://debezium.io/documentation/)