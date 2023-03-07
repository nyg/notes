---
title: Maven
---

*Notes from Maven: The Definitive Guide*

Maven is known as a "build tool" but it can do more than just building and packaging a project:

* manage dependencies and plugins (they are downloaded directly from a central repository, custom repositories can also be specified),
* publish artifacts on a repository,
* run reports (e.g. JavaDoc) & generate web sites,
* surely other stuff.

For these reasons, Maven is officially known as a "project management tool".

## 1. Core concepts

### Convention over configuration

Convention over configuration is a concept often cited when describing Maven. Simply put, it is the concept of providing sensible default behaviors for the tasks that Maven can perform. It basically makes it "opinionated".

Examples include:

* default directories for source code, resources and tests (e.g. `src/main/java`),
* default packaging type (i.e. jar),
* default steps for compiling source code, packaging resources.

As will be seen later on, these defaults are provided my Maven's core plugins.

### Plugins & plugin goals

Maven delegates most responsibilities to plugins. A plugin defines a set of goals, a goal is a unit of work. In order for a plugin to do something, one of its goal must be executed (either by invoking it directly from the command line or by binding it to a lifecycle phase, see below).

```sh
# using the plugin id
mvn <plugin-id>:<plugin-goal> -Dproperty1=value1 […]
mvn help:describe -Dplugin=help -Ddetail

# using the plugin coordinates, useful to specify the latest version
mvn <group-id>:<artifact-id>:<version>:<goal> -Dproperty1=value1 […]
mvn org.apache.maven.plugins:maven-dependency-plugin:3.4.0:list
```

Examples of plugins include: maven-help-plugin, maven-compiler-plugin, maven-jar-plugin, maven-archetype-plugin, and plenty of third-party plugins. As for dependencies, plugins can be retrieved from the Maven repository.

Delegating work to plugins, allows adding support for new frameworks without needing to update the Maven installation, but only the plugin itself. For example, adding support for running unit test with TestNG instead of JUnit will be done in the maven-surefire-plugin, and not in the Maven installation.

Therefore, plugins provide blocks of cross-cuting logic that can be reused accross multiple projects.

More info: [maven.apache.org/plugins/index.html](https://maven.apache.org/plugins/index.html)

### Lifecycle & lifecycle phases


A build lifecycle is an ordered sequence of phases. Maven defines three lifecycles: `default`, `clean` and `site`. The phases of each lifecycle is defined in `maven-core/META-INF/plexus/components.xml` (see [maven.apache.org/ref/3.8.4/maven-core/lifecycles.html](https://maven.apache.org/ref/3.8.4/maven-core/lifecycles.html)).

```sh
mvn <lifecycle phase>

mvn clean install site
# will execute:
# 1. all phases up to the clean phase (clean lifecycle)
# 2. all phases up to the install phase (default lifecycle)
# 3. all phases up to the site phase (site lifecycle)
```

For a phase to do something, it must have one or more plugin goals bound to it. If no goals are bound to a phase, it does not do anything.

### Default bindings

Maven defines default bindings for each lifecycle, e.g. the clean goal of the maven-clean-plugin is bound to the clean phase of the clean lifecycle (see `components.xml`).

For the default lifecycle, bindings are defined on a per-packaging basis (e.g. `jar`, `war`, `pom`) in `maven-core/META-INF/plexus/default-bindings.xml`:

| Lifecycle phase        | Plugin goal                              |
| ---------------------- | ---------------------------------------- |
| process-resources      | maven-resources-plugin:2.6:resources     |
| compile                | maven-compiler-plugin:3.1:compile        |
| process-test-resources | maven-resources-plugin:2.6:testResources |
| test-compile           | maven-compiler-plugin:3.1:testCompile    |
| test                   | maven-surefire-plugin:2.12.4:test        |
| package                | maven-jar-plugin:2.4:jar                 |
| install                | maven-install-plugin:2.4:install         |
| deploy                 | maven-deploy-plugin:2.7:deploy           |

## 2. Common plugins

### Help plugin

Use the Maven Help plugin to get information about of plugin.

```sh
# general syntax
mvn <plugin-id>:<goal-id> -Dparameter=value

# uses the describe goal of the help plugin to
# get information about the help plugin itself
mvn help:describe -Dplugin=help -Ddetail

# specify a specific goal
mvn help:describe -Dplugin=help -Dgoal=describe -Ddetail

# show help for the help goal, using the help goal of the help plugin
mvn help:help -Dgoal=help -Ddetail

# other goals
mvn help:effective-pom -Dverbose -Doutput=effective-pom.xml
mvn help:effective-settings
mvn help:active-profiles
mvn help:system
```

### Archetype plugin

[maven.apache.org/archetype/index.html](https://maven.apache.org/archetype/index.html)

Use the Maven Archetype plugin to create a project structure from a given archetype.

#### Location of archetypes

Knowledge about archetypes is stored in catalogs (XML files). The plugin comes with an internal catalog which is used by default (`archetype-common/src/main/resources/archetype-catalog.xml` ?). It also knows about the local (`~/.m2/archetype-catalog.xml`) and remote catalogs ([repo.maven.apache.org/maven2/archetype-catalog.xml](https://repo.maven.apache.org/maven2/archetype-catalog.xml)).

In a catalog, an archetype is represented by its `groupId`, `artifactId` and `version`. An optional `repository` property can be specified to indicate where to find the archetype. When omitted, the archetype is searched for in the repository where the catalog comes from.

#### maven-archetype-quickstart

The default archetype used when generating a project is `maven-archetype-quickstart`. This is hardcoded in the `DefaultArchetypeSelector` class (`org.apache.maven.archetypes:maven-archetype-quickstart:1.0`).

The source for this archetype can be found here: [repo.maven.apache.org/maven2/org/apache/maven/archetypes/maven-archetype-quickstart/](https://repo.maven.apache.org/maven2/org/apache/maven/archetypes/maven-archetype-quickstart/)

#### Generating a project

```sh
# man page for the archetype plugin
mvn help:describe -Dplugin=archetype -Ddetail

# help for the generate goal
mvn help:describe -Dplugin=archetype -Dgoal=generate -Ddetail
mvn archetype:help -Dgoal=generate -Ddetail

# create a project
mvn archetype:generate                               \
    `# goal parameters`                              \
    -DinteractiveMode=false                          \
    -DarchetypeGroupId=org.apache.maven.archetypes   \
    -DarchetypeArtifactId=maven-archetype-quickstart \
    -DarchetypeVersion=1.4                           \
    `# archetype properties`                         \
    -DgroupId=edu.self.java                          \
    -DartifactId=helloworld                          \
    -Dpackage=edu.self.java.helloworld               \
    -Dversion=1.0.0-SNAPSHOT
```

It's important to distinguish between parameters of the `generate` goal and properties of the archetype which are used to generate (and will appear in) the project. Required properties can be found by looking at the archetype's source code, or by running the generate goal without any archetype properties.
