# Vaadin

* npm is used to manage front-end dependencies
* dev: jetty is configured as a maven plugin, run with mvn jetty:run
* prod: app is package as a war
*   maven archetype:

    ```sh
    mvn archetype:generate -DarchetypeGroupId=com.vaadin -DarchetypeArtifactId=vaadin-archetype-application -DarchetypeVersion=LATEST
    ```
* LiveReload plugin for the browser
