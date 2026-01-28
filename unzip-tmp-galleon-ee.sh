#!/bin/bash

# Function to decompose Maven GAV coordinates
# Usage: gav "groupId:artifactId:version" or "groupId:artifactId:packaging:version"
# Returns: array with group (dots to slashes), artifactId, and version
gav() {
    local gav_input="$1"
    local IFS=':'
    local parts=($gav_input)
    local group artifact version packaging

    # Handle both GAV (3 parts) and GAVP (4 parts) formats
    if [ ${#parts[@]} -eq 3 ]; then
        group="${parts[0]}"
        artifact="${parts[1]}"
        version="${parts[2]}"
    elif [ ${#parts[@]} -eq 4 ]; then
        group="${parts[0]}"
        artifact="${parts[1]}"
        packaging="${parts[2]}"
        version="${parts[3]}"
    else
        echo "Error: Invalid GAV format. Expected groupId:artifactId:version or groupId:artifactId:packaging:version" >&2
        return 1
    fi

    # Convert dots to slashes in group
    local group_path="${group//.//}"

    # Return array elements
    echo "-ipath"
    echo "*$group_path*"
    echo "-a -ipath"
    echo "*$artifact*"

    # Add packaging if present
    if [ -n "$packaging" ]; then
        echo "-a -ipath"
        echo "*.$packaging"
    fi

    echo "-a -ipath"
    echo "*$version*"
}
ALL=(
   org.mobicents.servers.jainslee.core:wildfly-mobicents-slee-galleon-pack:zip:9.0.0-SNAPSHOT
   org.wildfly:wildfly-galleon-pack:zip:21.0.1.Final
   org.wildfly:wildfly-servlet-galleon-pack:zip:21.0.1.Final
   org.wildfly.core:wildfly-core-galleon-pack:zip:13.0.3.Final
   org.wildfly:wildfly-ee-galleon-pack:zip:21.0.1.Final
   org.wildfly:wildfly-datasources-galleon-pack:zip:11.2.0.Final
)
VERSION_CORE=17.0.3.Final
VERSION_WILDFLY=26.1.3.Final
VERSION_DATASOURCES=2.2.6.Final
VERSION_MOBICENTS=9.0.0-SNAPSHOT
ALL=(
   org.mobicents.servers.jainslee.core:wildfly-mobicents-slee-galleon-pack:zip:$VERSION_MOBICENTS
   org.wildfly:wildfly-galleon-pack:zip:$VERSION_WILDFLY
   org.wildfly:wildfly-servlet-galleon-pack:zip:$VERSION_WILDFLY
   org.wildfly.core:wildfly-core-galleon-pack:zip:$VERSION_CORE
   org.wildfly:wildfly-ee-galleon-pack:zip:$VERSION_WILDFLY
   org.wildfly:wildfly-datasources-galleon-pack:zip:$VERSION_DATASOURCES
)

#ALL=(
#   org.wildfly:wildfly-datasources-galleon-pack:zip:11.2.0.Final
#)

# Loop through all coordinates and find/unzip them
for COORD in "${ALL[@]}"; do
    echo "Processing: $COORD"
    ARGS=$(gav "$COORD")
    find /media/work/.m2/repository $ARGS -print -exec unzip -o {} -d tmp \;
done
