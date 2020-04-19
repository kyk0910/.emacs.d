#!/bin/sh
apt install -y graphviz default-jre
mkdir -p /opt/plantuml
cd /opt/plantuml
curl -JLO http://sourceforge.net/projects/plantuml/files/plantuml.jar/download
cat <<EOF | sudo tee /usr/local/bin/plantuml
#!/bin/sh
java -jar /opt/plantuml/plantuml.jar "\$@"
EOF
chmod a+x /usr/local/bin/plantuml
