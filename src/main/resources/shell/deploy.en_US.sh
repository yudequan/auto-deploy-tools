#!/bin/sh

CODE_HOME=/opt/git/BossReward
DEPLOY_HOME=/opt/deploy

echo '[INFO] ** Start getting the latest code... **'
cd $CODE_HOME
git pull
echo '[INFO] ** Get the latest code done. **'
echo '[INFO] ** Start package... **'
mvn clean package -Dmaven.test.skip=true > $DEPLOY_HOME/maven.log 2>&1
echo '[INFO] ** Package completed. **'
echo '[INFO] ** Start shutting down the server... **'
sh $CATALINA_HOME/bin/shutdown.sh > $DEPLOY_HOME/tomcat.log 2>&1
echo '[INFO] ** Shut down the server done. **'
echo '[INFO] ** Start deploying new applications... **'
rm -rf $CATALINA_HOME/webapps/BossReward*
cp $CODE_HOME/target/BossReward.war $CATALINA_HOME/webapps
echo '[INFO] ** Deploy new applications complete. **'
echo '[INFO] ** Starting the server... **'
sh $CATALINA_HOME/bin/startup.sh > null
echo '[INFO] ** Start the server done. **'
echo '[INFO] ** Please visit: http://test.bossshangba.com **'