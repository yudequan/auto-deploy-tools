#!/bin/sh

CODE_HOME=/opt/git/BossReward
DEPLOY_HOME=/opt/deploy

echo '[INFO] ** 开始获取最新代码 **'
cd $CODE_HOME
git pull
echo '[INFO] ** 获取最新代码完成 **'
echo '[INFO] ** 开始打包 **'
mvn clean package -Dmaven.test.skip=true > $DEPLOY_HOME/maven.log 2>&1
echo '[INFO] ** 打包完成 **'
echo '[INFO] ** 开始关闭服务器 **'
sh $CATALINA_HOME/bin/shutdown.sh > $DEPLOY_HOME/tomcat.log 2>&1
echo '[INFO] ** 关闭服务器完成 **'
echo '[INFO] ** 开始部署新的应用 **'
rm -rf $CATALINA_HOME/webapps/BossReward*
cp $CODE_HOME/target/BossReward.war $CATALINA_HOME/webapps
echo '[INFO] ** 部署新的应用完成 **'
echo '[INFO] ** 开始启动服务器 **'
sh $CATALINA_HOME/bin/startup.sh > null
echo '[INFO] ** 启动服务器完成 **'
echo '[INFO] ** 请访问:http://test.bossshangba.com **'