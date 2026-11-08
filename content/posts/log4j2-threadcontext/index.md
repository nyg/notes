---
date: 2023-03-18
aliases:
  - /prog/java/log4j2/
title: Log4j2 ThreadContext
---

*Source repository: [github.com/nyg/example-log4j](https://github.com/nyg/example-log4j)*

This proof-of-concept shows how to use a Log4j `Routing` appender to route log events of a service to different files, based on who initially called the service methods, i.e. a JMX call or a Spring scheduler in our case.

The service `Service` has two methods: `doOne` and `doTwo`, which represent two distinct business actions in an application. Each method is called by a scheduler every 15 seconds in `SchedulerOne` and `SchedulerTwo`, respectively. Each method can also be executed via a JMX call through the `OperationOne` and `OperationTwo` managed resources (e.g. by using VisualVM).

As the methods could be executed asynchronously and/or may take considerable time to execute (in a real application), the logs produced by each method would overlap each other if logged into the same file. This makes it hard to distinguish the execution flow of each method invocation and debug any problems that might arise in a production environment.

## ThreadContext

By using the log4j `ThreadContext`, we can associate multiple key-value pairs to a thread in order to better identify each method invocation. For example:

```java
@ManagedOperation
public void executeOne(String data) {
    ThreadContext.put("caller", "jmx");
    ThreadContext.put("operation", "one");
    ThreadContext.put("uuid", UUID.randomUUID().toString().split("-")[0]);

    log.info("Starting Operation One with: {}", data);
    service.doOne(data);

    ThreadContext.clearMap();
}
```

```java
@Scheduled(fixedRate = 15_000)
public void schedulerOne() {
    ThreadContext.put("caller", "sched");
    ThreadContext.put("operation", "one");
    ThreadContext.put("uuid", UUID.randomUUID().toString().split("-")[0]);

    log.info("Executing Scheduler One");
    service.doOne("no-data");

    ThreadContext.clearMap();
}
```

## Dynamic filenames

The key-value pairs can be used in the used in the log4j configuration file in the following way:

```xml
<Routes pattern="$${ctx:caller}-$${ctx:operation}">
    <Route>
        <File name="File-${ctx:caller}-${ctx:operation}" fileName="logs/example-log4j-${ctx:caller}-${ctx:operation}.log">
            <PatternLayout pattern="${extendedPattern}"/>
        </File>
    </Route>
</Routes>
```

Using this configuration, when the `doOne` method is invoked via JMX, the logs are written to a file named `example-log4j-jmx-one.log`. When it is invoked by the scheduler, the filename is `example-log4j-sched-one.log`. The same is done for the `doTwo` method.

See below for the value of the `extendedPattern` property.

## Log format

The key-value pairs can also be used in the `PatternLayout`, so as to be able to distinguish each log event easily, even if they were written to a single log file:

```xml
<Property name="extendedPattern">
    %d{ISO8601} [%c{1.1.1.2.}] [%t] [%X{caller}-%X{operation}-%X{uuid}] [%p] %m%n
</Property>
```

Example of `example-log4j-jmx-one.log`:

```
2023-03-19T20:15:14,605 [e.s.n.ex.lo.ap.jm.OperationOne] [RMI TCP Connection(4)-192.168.1.213] [jmx-one-d5458d68] [INFO] Starting Operation One with: some data
2023-03-19T20:15:14,618 [e.s.n.ex.lo.ap.co.Service] [RMI TCP Connection(4)-192.168.1.213] [jmx-one-d5458d68] [INFO] Executed One with: some data
2023-03-19T20:15:18,618 [e.s.n.ex.lo.ap.co.Service] [Thread-26] [jmx-one-d5458d68] [INFO] This is logged from a separate thread but inherits from the ThreadContext map
2023-03-19T20:15:53,934 [e.s.n.ex.lo.ap.jm.OperationOne] [RMI TCP Connection(4)-192.168.1.213] [jmx-one-e6a8d238] [INFO] Starting Operation One with: some other data
2023-03-19T20:15:53,940 [e.s.n.ex.lo.ap.co.Service] [RMI TCP Connection(4)-192.168.1.213] [jmx-one-e6a8d238] [INFO] Executed One with: some other data
2023-03-19T20:15:57,941 [e.s.n.ex.lo.ap.co.Service] [Thread-31] [jmx-one-e6a8d238] [INFO] This is logged from a separate thread but inherits from the ThreadContext map
```

Example of `example-log4j-sched-two.log`:

```
2023-03-19T20:12:57,851 [e.s.n.ex.lo.ap.sc.SchedulerTwo] [sched-task-2] [sched-two-09f481d1] [INFO] Executing Scheduler Two
2023-03-19T20:12:57,852 [e.s.n.ex.lo.ap.co.Service] [sched-task-2] [sched-two-09f481d1] [INFO] Executed Two with: no-data
2023-03-19T20:13:01,858 [e.s.n.ex.lo.ap.co.Service] [Thread-6] [sched-two-09f481d1] [INFO] This is logged from a separate thread but inherits from the ThreadContext map
2023-03-19T20:13:12,850 [e.s.n.ex.lo.ap.sc.SchedulerTwo] [sched-task-7] [sched-two-bcbd80d6] [INFO] Executing Scheduler Two
2023-03-19T20:13:12,852 [e.s.n.ex.lo.ap.co.Service] [sched-task-7] [sched-two-bcbd80d6] [INFO] Executed Two with: no-data
2023-03-19T20:13:16,856 [e.s.n.ex.lo.ap.co.Service] [Thread-8] [sched-two-bcbd80d6] [INFO] This is logged from a separate thread but inherits from the ThreadContext map
```

As we can see, each log event contains a string of the following format: `[<caller>-<operation-name>-<operation-uuid>]`, e.g. `sched-two-00be3fa0`.
