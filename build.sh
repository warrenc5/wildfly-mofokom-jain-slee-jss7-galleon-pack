SS7=:wildfly-restcomm-ss7-galleon-pack
SLEE=:wildfly-mobicents-slee-galleon-pack
ANN=:wildfly-jain-slee-annotations-galleon-pack
PROV=:mobicents-slee-provision
WF=WF26

mvn "-D${WF}" -pl $SLEE,$SS7,$ANN,$PROV clean install
#mvnDebug "-D${WF}" -X -pl $SLEE,$SS7,$ANN,$PROV clean install

[ $? -ne 0 ] && exit 1
find provision/target/mobicents-slee-provision-9.0.0-SNAPSHOT/modules/system/layers/base/org/telestax/slee/container/ | grep \.jar | wc -l
grep mbean provision/target/mobicents-slee-provision-9.0.0-SNAPSHOT/standalone/configuration/standalone.xml
grep local-cache standalone.xml
find provision/target/mobicents-slee-provision-9.0.0-SNAPSHOT/ | grep shell
exit 0
