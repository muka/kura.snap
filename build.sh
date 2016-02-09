

echo "Fetch git"

git clone https://github.com/eclipse/kura.git
cd kura
git checkout KURA_1.3.0_RELEASE

echo "Install platform deps"
cd target-platform
mvn install -DskipTests

echo "Install kura deps"
cd ../kura

#Build with CAN support
mvn -Dmaven.test.skip=true -f manifest_pom.xml -Pcan clean install
# Build with web UI
mvn -Dmaven.test.skip=true -f pom_pom.xml -Pweb clean install

#Build without CAN support
#mvn -Dmaven.test.skip=true -f manifest_pom.xml clean install
# or build without web UI
#mvn -Dmaven.test.skip=true -f pom_pom.xml clean install

echo "package"
cd distrib
mvn package

cd ../../../
mkdir -p ./kura-dist
cp -r kura/kura/distrib/target/* ./kura-dist/
