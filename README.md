#  [![Issues](https://img.shields.io/badge/Issues-JIRA-ff69b4.svg?style=flat)](https://jira.mesosphere.com/projects/MARATHON/issues/)

Marathon is a production-proven [Apache Mesos][Mesos] framework for container orchestration. [DC/OS](https://dcos.io/get-started/#marathon) is the easiest way to start using Marathon.

Marathon provides a
[REST API](https://mesosphere.github.io/marathon/docs/rest-api.html) for
starting, stopping, and scaling applications. Marathon is written in Scala and
can run in highly-available mode by running multiple copies. The
state of running tasks gets stored in the Mesos state abstraction.

Marathon is a *meta framework*: you can start other Mesos frameworks such as
Chronos or [Storm][Storm] with it to ensure they survive machine failures.
It can launch anything that can be launched in a standard shell. In fact, you
can even start other Marathon instances via Marathon.

Since Marathon version 0.7.0 and Mesos 0.20.0, you can [deploy, run and scale Docker containers](https://mesosphere.github.io/marathon/docs/native-docker.html) easily with native support.

## Features

* *HA* -- run any number of Marathon schedulers, but only one gets elected as
    leader; if you access a non-leader, your request gets proxied to the
    current leader
* *[Constraints](https://mesosphere.github.io/marathon/docs/constraints.html)* - e.g., only one instance of an application per rack, node, etc.
* *[Service Discovery &amp; Load Balancing](https://mesosphere.github.io/marathon/docs/service-discovery-load-balancing.html)* via HAProxy or the events API (see below).
* *[Health Checks](https://mesosphere.github.io/marathon/docs/health-checks.html)*: check your application's health via HTTP or TCP checks.
* *[Event Subscription](https://mesosphere.github.io/marathon/docs/rest-api.html#event-subscriptions)* lets you supply an HTTP endpoint to receive notifications, for example to integrate with an external load balancer.
* *[Marathon UI](https://mesosphere.github.io/marathon/docs/marathon-ui.html)*
* *[JSON/REST API](https://mesosphere.github.io/marathon/docs/rest-api.html)* for easy integration and scriptability
* *Basic Auth* and *SSL*
* *[Metrics](https://mesosphere.github.io/marathon/docs/metrics.html)*:
  query them at `/metrics` in JSON format or push them to graphite/statsd/datadog.
* *[Container Storage Interface(CSI)](http://mesos.apache.org/documentation/latest/csi/).

## Documentation

Marathon documentation is available on the [Marathon GitHub pages site](http://mesosphere.github.io/marathon/).

Documentation for installing and configuring the full Mesosphere stack including Mesos and Marathon is available on the [Mesosphere website](http://docs.mesosphere.com).

### Contributing

We heartily welcome external contributions to Marathon's documentation. Documentation should be committed to the `master` branch and published to our GitHub pages site using the instructions in [docs/README.md](https://github.com/mesosphere/marathon/tree/master/docs).

## Setting Up And Running Marathon

### Dependencies
Marathon has the following compile-time dependencies:
* sbt - A build tool for scala. You can find the instructions for installing sbt for Mac OS X and Linux over [here](http://www.scala-sbt.org/0.13/tutorial/Setup.html).
* JDK 1.8+

For run-time, Marathon has the following dependencies:
* libmesos - JNI bindings for talking to Apache Mesos master. Look at the *Install Mesos* section for instructions to get libmesos.
* Apache Zookeeper - You can have a spearate Zookeeper installation specifically for Marathon, or you can use the same Zookeeper used by Mesos.

### Installation

#### Getting started with [DC/OS](https://dcos.io/get-started/#marathon)
The by far easiest way to get Marathon running is to use [DC/OS](https://dcos.io/get-started/#marathon). Marathon is pre-bundled into [DC/OS](https://dcos.io/get-started/#marathon).

#### Install Mesos
Marathon requires libmesos, a shared object library, that contains JNI bindings for Marathon to talk to the Mesos master. *libmesos* comes as part of the Apache Mesos installation. There are two options for installing Apache Mesos.

##### Installing Mesos from prepackaged releases
Instructions on how to install prepackaged releases of Mesos are available [in the Marathon docs](https://mesosphere.github.io/marathon/docs/).

##### Building Mesos from source
**NOTE:** *Choose this option only if building Marathon from source, else there might be version incompatibility between pre-packaged releases of Marathon and Mesos built from source.*

You can find the instructions for compiling Mesos from source in the [Apache Mesos getting started docs](http://mesos.apache.org/gettingstarted/). If you want Mesos to install libraries and executables in a non-default location use the --prefix option during configuration as follows:

```console
./configure --prefix=<path to Mesos installation>
```

The `make install` will install libmesos (libmesos.so on Linux and libmesos.dylib on Mac OS X) in the install directory.

#### Install Marathon

Instructions on how to install prepackaged releases are available [in the Marathon docs](https://mesosphere.github.io/marathon/docs/). Alternatively, you can build Marathon from source.

##### Building from Source

1.  To build Marathon from source, check out this repo and use sbt to build a JAR:

        git clone https://github.com/mesosphere/marathon.git
        cd marathon
        sbt assembly

1.  Run `./bin/build-distribution` to package Marathon as an
    [executable JAR](https://mesosphere.com/blog/2013/12/07/executable-jars/)
    (optional).

### Running in Development Mode

Mesos local mode allows you to run Marathon without launching a full Mesos
cluster. It is meant for experimentation and not recommended for production
use. Note that you still need to run ZooKeeper for storing state. The following
command launches Marathon on Mesos in *local mode*. Point your web browser to
`http://localhost:8080` to see the Marathon UI.

    ./bin/start --master local --zk zk://localhost:2181/marathon

For more information on how to run Marathon in production and configuration
options, see [the Marathon docs](https://mesosphere.github.io/marathon/docs/).

## Developing Marathon

See [the documentation](https://mesosphere.github.io/marathon/docs/developing-vm.html) on how to run Marathon locally inside a virtual machine.

### Running in Development Mode on Docker

* Note: Currently the Docker container fails due to strange behavior from the latest Mesos version.  There will be an error about `work_dir` that is still unresolved, much like this:

        Failed to start a local cluster while loading agent flags from the environment: Flag 'work_dir' is required, but it was not provided

Build it:

    docker build -t marathon-head .

A running zookeeper instance is required, if there isn't one already available, there is a docker image available for this:

    docker run --name some-zookeeper --restart always -d zookeeper

Run it with zookeeper container:

    docker run --link some-zookeeper:zookeeper marathon-head --master local --zk zk://zookeeper:2181/marathon

Or run it without zookeeper container:

    docker run marathon-head --master local --zk zk://localhost:2181/marathon

If you want to inspect the contents of the Docker container:

    docker run -it --entrypoint=/bin/bash marathon-head -s


## Resource

    * Tools
       * Setting Emacs with [ensime-sbt](https://www.47deg.com/blog/scala-development-with-emacs/)
    * Concept
       * Container Storage Interface(CSI)(http://mesos.apache.org/documentation/latest/csi/)

## Acknowledgements

**YourKit, LLC**

![YourKit, LLC](https://www.yourkit.com/images/yklogo.png)

YourKit supports open source projects with its full-featured Java
Profiler.
YourKit, LLC is the creator of <a
href="https://www.yourkit.com/java/profiler/index.jsp">YourKit Java
Profiler</a>
and <a href="https://www.yourkit.com/.net/profiler/index.jsp">YourKit
.NET Profiler</a>,
innovative and intelligent tools for profiling Java and .NET
applications.
