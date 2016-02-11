
INSTALL_DIR=/opt/eclipse

echo "* Fetch kura"
if [ ! -f "/tmp/kura.zip" ]; then
  wget https://github.com/eclipse/kura/archive/KURA_1.3.0_RELEASE.zip -O /tmp/kura.zip
fi

unzip /tmp/kura.zip -d ./ > /dev/null
mv kura-* kura

cd kura
REPO=`pwd`

echo "* Install platform deps"
cd target-platform
mvn clean package -DskipTests

echo "* Install kura deps"
cd ../kura

ln -s ../target-platform/ ./

#Build with CAN support
mvn -Dmaven.test.skip=true -f manifest_pom.xml -Pcan clean package
# Build with web UI
mvn -Dmaven.test.skip=true -f pom_pom.xml -Pweb clean package

#Build without CAN support
#mvn -Dmaven.test.skip=true -f manifest_pom.xml clean install
# or build without web UI
#mvn -Dmaven.test.skip=true -f pom_pom.xml clean install

echo "* package distrib"
cd distrib
cp $REPO/kura/distrib/src/main/resources/raspberry-pi-2/kura.properties ./build.properties
mvn clean package -Dmaven.test.skip=true

# cd ../../../
# mkdir -p ./kura-dist
# cp -r kura/kura/distrib/target/* ./kura-dist/
