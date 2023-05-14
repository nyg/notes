---
title: JDBC connection
---

*Source repository: [git.sr.ht/~nyg/example-java-jdbc](https://git.sr.ht/~nyg/example-java-jdbc)*

There are different ways to obtain a connection to a database in a Java application. We will show some of them below, starting from the most low-level one, up to the most commonly used one.

In this demo application, we obtain a connection to a MariaDB database. We use the `mariadb-java-client` dependency, which contains the MariaDB JDBC driver.

## Java Service Provider Interface

Simply put, the Java SPI is a JDK API for discovering and loading implementations of a given interface. The interface is the _service_ and the implementation is the _service provider_.

In our case, the service is the `java.sql.Driver` interface and the provider is the `org.mariadb.jdbc.Driver ` class (which implements the Driver interface).

In order for a provider to be discovered, its JAR file must include a file named `META-INF/services/<fully-qualified-interface-name>` which contains the fully qualified classname of the provider class. For example, in the `mariadb-java-client.jar` we can find the file `META-INF/services/java.sql.Driver` which contains `org.mariadb.jdbc.Driver`.

We use the the `ServiceLoader` class to find and instantiate the MariaDB driver. Once we have the driver instance, we can obtain a `java.sql.Connection` object which allows us to communicate with the underlying database.

```java
ServiceLoader<Driver> serviceLoader = ServiceLoader.load(java.sql.Driver.class);
serviceLoader.iterator().forEachRemaining(driver -> {

    String jdbcUrl = "jdbc:mariadb://localhost/mydb";
    Properties properties = new Properties();
    properties.setProperty("user", "admin");
    properties.setProperty("password", "admin1234");

    Connection connection = driver.connect(jdbcUrl, properties);
    // query db, e.g. connection.prepareStatement(…)
});
```

### Before SPI

The Java SPI was introduced in Java SE 6 and, since JDBC 4.0, the `java.sql.DriverManager` uses it to find and load available drivers (see below). Before that, the drivers had to be loaded manually as follows:

```java
// load the driver class, which will call the driver's static initializer
Class.forName("org.mariadb.jdbc.Driver");

// obtain a driver instance either with Class.forName(…).newInstance()
// or by using the DriverManager class (see below)
```

The driver's static initializer registers the driver with the DriverManager, as explained in the JDBC specification:

>  JDBC drivers must implement the Driver interface, and the implementation must contain a static initializer that will be called when the driver is loaded. This initializer registers a new instance of itself with the DriverManager.

Resources:

* Javadoc: [ServiceLoader](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/ServiceLoader.html), [Driver](https://docs.oracle.com/en/java/javase/17/docs/api/java.sql/java/sql/Driver.html)
* [marcobehler.com: JDBC - a short guide](https://www.marcobehler.com/guides/jdbc)

## DriverManager

As explained above, the DriverManager uses SPI to discover and load drivers available on the classpath. We can query the DriverManager for registered drivers using the `getDrivers()` method, or directly call its `getConnection()` method.

```java
Connection connection = DriverManager.getConnection(jdbcUrl, properties);
// query db, e.g. connection.prepareStatement(…)
```

The `getConnection()` method will loop through the registered drivers and return a connection from the first one which accepts the provided JDBC URL.

Resources:

* Javadoc: [DriverManager](https://docs.oracle.com/en/java/javase/17/docs/api/java.sql/java/sql/DriverManager.html)

## DataSource

As mentioned in the Javadoc for the DriverManager class, “the use of a `DataSource` object is the preferred means of connecting to a data source”. There are, of course, multiple ways to obtain a DataSource object.

### Driver DataSource

If the driver provides a DataSource implementation, it could be used directly:

```java
MariaDbDataSource dataSource = new MariaDbDataSource(JDBC_URL);
dataSource.setUser("admin");
dataSource.setPassword("admin1234");

Connection connection = dataSource.getConnection();
// query db, e.g. connection.prepareStatement(…)
```

However, in a real-world app, using a connection pool is preferred for performance reasons. Obtaining a database connection is an expensive operation.

### JDBC Connection Pool

There are multiple JDBC connection pools out there, one of them is the Tomcat JDBC Connection Pool (dependency `tomcat-jdbc`). It can be used in the following way:

```java
PoolConfiguration poolConfig = new PoolProperties();
poolConfig.setUrl(jdbcUrl);
poolConfig.setDriverClassName("org.mariadb.jdbc.Driver");
poolConfig.setUsername("admin");
poolConfig.setPassword("admin1234");
// much more pool configuration properties available

DataSource = new org.apache.tomcat.jdbc.pool.DataSource(poolConfig);
```

Tomcat JDBC Connection Pool can be used in a standalone application, it does not require the Tomcat web server.

### Java Naming and Directory Interface

In a real-world application, if the application runs inside an application server (e.g. Tomcat), the DataSource is defined in the server configuration and is exposed in a JNDI context. This allows the application to retrieve the DataSource using the JNDI resource name:

```java
// either "manually"
DataSource jndiDataSource = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/my-datasource");

// or using the Jakarta EE @Resource annotation
@Resource(lookup = "java:comp/env/jdbc/my-datasource")
private DataSource jndiDataSource;
```

If JPA is also used in the application (e.g. with Spring and/or Hibernate), the DataSource instance will be given to an EntityManagerFactory (JPA) or SessionFactory (Hibernate). In this case, the connection is obtained behind the scene, when it is needed.

Resources:

* Stackoverflow
    * [Why do we use a DataSource instead of a DriverManager?](https://stackoverflow.com/a/73148345)
    * [Why use JNDI for data sources?](https://stackoverflow.com/a/7760768)
* [https://tomcat.apache.org/tomcat-10.1-doc/jdbc-pool.html](https://tomcat.apache.org/tomcat-10.1-doc/jdbc-pool.html)
* Javadoc: [@Resource](https://jakarta.ee/specifications/platform/10/apidocs/jakarta/annotation/resource)
