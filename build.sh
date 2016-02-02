

echo "Fetch git"

git clone https://github.com/eclipse/kura.git
cd kura
git checkout KURA_1.3.0_RELEASE

echo "Install platform deps"
cd target-platform
mvn install -DskipTests

echo "Install kura deps"
cd ../kura
ln -s ./manifest_pom.xml pom.xml
mvn install -DskipTests

echo "package"
cd distrib
mvn package

cd ../../../
mkdir -p ./kura-dist
cp -r kura/kura/distrib/target/* ./kura-dist/
