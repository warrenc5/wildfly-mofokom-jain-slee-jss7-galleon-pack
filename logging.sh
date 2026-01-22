./provision/target/mobicents-slee-provision-9.0.0-SNAPSHOT/bin/jboss-cli.sh -c "/subsystem=logging/logger=org.wildfly.security:add(level=TRACE),/subsystem=logging/console-handler=CONSOLE:write-attribute(name=level,value=TRACE)"

