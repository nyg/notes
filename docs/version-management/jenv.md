# jEnv

jEnv is a version manager for Java. It has, however, some limitations:

1. It does not provide the ability to install Java versions, this must be done using `brew`.
2. It will not update the `JAVA_HOME`. The `export` plugin must be enabled, but even then the `JAVA_HOME` will only be updated when the shell \(re\)starts.

## Install jEnv

```bash
# install jenv
brew install jenv

# enable the export plugin
jenv enable-plugin export

# add these two lines in .zshrc
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
```

## Install Java versions

```bash
# for the latest java version
brew cask install adoptopenjdk

# for a specific version
# see https://github.com/AdoptOpenJDK/homebrew-openjdk
brew tap adoptopenjdk/openjdk
brew cask install adoptopenjdk8
```

## Configure jEnv

```bash
# inform jenv of the installed java versions
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-16.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

jenv rehash

# verify
jenv versions
```

## Change the Java version

```bash
# set the global version
jenv global 13.0

# set a local per-directory version
jenv local 1.8

# or a per-shell version
jenv shell 1.8
```

## UI Applications

JAVA\_HOME issue with UI apps: [https://www.ibm.com/support/knowledgecenter/en/SSPJLC\_7.6.2/com.ibm.si.mpl.doc/tshoot/ts\_java\_home.html](https://www.ibm.com/support/knowledgecenter/en/SSPJLC_7.6.2/com.ibm.si.mpl.doc/tshoot/ts_java_home.html)

## Misc

```bash
# to see if everything is ok, or not
jenv doctor

# list all commands
jenv commands

# help for a specific command
jenv help <command>

# to get a list of installed JVM
/usr/libexec/java_home -V
```

