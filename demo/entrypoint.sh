#!/bin/bash

# Start SSH server as the root user
/usr/sbin/sshd -D &

# Wait for SSH server to start (you can customize the sleep duration as needed)
sleep 5

# Run commands as the non-root user
su - youruser -c 'wget https://nexus.opendaylight.org/content/repositories/opendaylight.release/org/opendaylight/integration/karaf/0.18.1/karaf-0.18.1.zip \
    && unzip /home/youruser/karaf-0.18.1.zip \
    && chmod +x /home/youruser/karaf-0.18.1/bin/karaf \
    && ssh-keygen -b 2048 -t rsa -f /tmp/sshkey -q -N "" '

# Set environment variables as the non-root user
su - youruser -c "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64"
su - youruser -c "export PATH=$PATH:/home/youruser/karaf-0.18.1/bin"
su - youruser -c "export KARAF_HOME=/home/youruser/karaf-0.18.1"

# Check if the FEATURES environment variable is set
if [ -n "$FEATURES" ]; then
    # Update the featuresBoot line in org.apache.karaf.features.cfg
    su - youruser -c "sed -i \"s/\(featuresBoot= \|featuresBoot = \)/featuresBoot = $FEATURES,/g\" /home/youruser/karaf-0.18.1/etc/org.apache.karaf.features.cfg"
fi

# Run Karaf as the non-root user
su - youruser -c "/home/youruser/karaf-0.18.1/bin/karaf run"

# Keep the container running
tail -f /dev/null
