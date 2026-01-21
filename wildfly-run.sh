JAVA_HOME=~/.sdkman/candidates/java/17.0.12-oracle/
export JAVA_HOME
cp -v ./standalone.sh ./provision/target/mobicents-slee-provision-9.0.0-SNAPSHOT/bin/standalone.sh
./provision/target/mobicents-slee-provision-9.0.0-SNAPSHOT/bin/standalone.sh --debug --suspend
