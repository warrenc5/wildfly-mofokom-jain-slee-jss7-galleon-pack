pkill -ef -9 jboss.modules.system

JAVA_HOME=~/.sdkman/candidates/java/17.0.12-oracle/

BASE=provision/target/mobicents-slee-provision-9.0.0-SNAPSHOT
STANDALONE=$BASE/standalone

export JAVA_HOME

$BASE/bin/add-user.sh -u admin -p admin

#TODO move standalone.sh into feature pack content
cp -v ./standalone.sh $BASE/bin/standalone.sh

#$BASE/bin/standalone.sh --debug 
#$BASE/bin/standalone.sh --debug --suspend
$BASE/bin/standalone.sh
