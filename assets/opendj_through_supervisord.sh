#!/bin/bash
function shutdown() {
    /opt/opendj/bin/stop-ds
}

# Allow any signal which would kill a process to stop Tomcat
trap shutdown HUP INT QUIT ABRT KILL ALRM TERM TSTP

/opt/opendj/bin/start-ds --nodetach
