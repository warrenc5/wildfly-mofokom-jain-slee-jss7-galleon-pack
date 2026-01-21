cd `dirname $0`

xsltproc --stringparam subsystem ss7 specify.xslt standalone.xml | tee feature_groups-ss7.xml
xsltproc --stringparam subsystem slee specify.xslt standalone.xml | tee feature_groups-slee.xml
