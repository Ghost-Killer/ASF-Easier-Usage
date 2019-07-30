#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
LANG=en_US.UTF-8

is64bit=`getconf LONG_BIT`
if [ "$is64bit" != '64' ];then
    echo -e "===================================================="
    echo -e "抱歉, 不支持32位系统, 请使用64位系统!";
    exit 0;
fi

my_system="CentOS 7"
if [ -f "/usr/bin/apt-get" ];then
    isDebian=`cat /etc/issue|grep Debian`
    if [ "$isDebian" != "" ];then
        my_system="Debian"
    else
        my_system="Ubuntu"
    fi
fi
py26=$(python -V 2>&1|grep '2.6.')
if [ "$py26" != "" ];then
    my_system="CentOS 6"
fi
if [ ${my_system:0:6} != 'CentOS' ];then
    echo -e "===================================================="
    echo -e "暂未测试Debian与Ubuntu是否兼容, 可能会发生预料之外的错误!";
fi

Get_Dependency(){
    for i in unzip zip icu screen;do
        echo -e "----------------------------------------------------"
        echo -e "以 yum install -y 方式安装/更新依赖包 $i ..."
        yum install -y $i&>/dev/null
        [ $? -eq 0 ] || rpm -qa | grep ${i%%.*}
        [ $? -ne 0 ] && echo -e "你的yum无法安装"$i && yum_right=3
    done
    [ $yum_right ] && exit 3
    echo -e "----------------------------------------------------"
    echo -e "所有依赖包更新完成!"
}

echo -e "===================================================="
echo -e "开始安装/更新需要的依赖包...";
Get_Dependency

#尝试从ntp服务器同步国际时间
ntpdate 0.asia.pool.ntp.org &>/dev/null
startTime=`date +"%s"`

Get_ASF_Release(){
    wget -q -O ASF_releases_temp.zip "https://github.com/JustArchiNET/ArchiSteamFarm/releases/latest/download/ASF-linux-x64.zip"
    if [ $? -eq 0 ];then
        echo -e "下载ArchiSteamFarm主程序成功!";
        echo -e "----------------------------------------------------"
        echo -e "开始解压ArchiSteamFarm主程序..."
        if [ -d "ArchiSteamFarm" ];then
            echo -e "检测到当前目录已存在名为ArchiSteamFarm的文件夹, 正在备份..."
            if [ ! -d "ArchiSteamFarm_backup" ];then mkdir ArchiSteamFarm_backup;fi
            backup_name=ArchiSteamFarm_backup/ASF_`TZ=Asia/Shanghai date +"%y%m%d_%H%M%S"`.zip
            zip -q -r $backup_name ArchiSteamFarm
            rm -rf ArchiSteamFarm
            echo -e "已将其备份为$backup_name!"
        else
            mkdir ArchiSteamFarm
        fi
        unzip -q -o ASF_releases_temp.zip -d ArchiSteamFarm
        if [ $? -eq 0 ];then
            echo -e "解压ArchiSteamFarm主程序成功!";
            rm ASF_releases_temp.zip
        else
            echo -e "===================================================="
            echo -e "抱歉, ArchiSteamFarm主程序解压失败!";
            exit 0;
            # TODO 输入回车重新解压
        fi
    else
        echo -e "===================================================="
        echo -e "抱歉, 从Github获取最新的ASF主程序时下载失败, 请检查网络!";
        exit 0;
    fi
    chmod +x ./ArchiSteamFarm/ArchiSteamFarm
    return 0;
}

Install_Failed_Confirm(){
    while [ "$confirm" != 'yes' ] && [ "$confirm" != 'no' ];do
        echo -e "----------------------------------------------------"
        echo -e "获取最新的ASF主程序失败, 是否重新开始?"
        echo -e "Got ASF release failed!"
        echo -e "----------------------------------------------------"
        read -p "输入yes再次尝试/Try again? (yes/no): " confirm;
    done
    if [ "$confirm" == 'no' ];then
        exit;
    fi
}

echo -e "===================================================="
echo -e "开始从Github获取最新的ArchiSteamFarm主程序...";
while true;do
    Get_ASF_Release
    #test -e ./ArchiSteamFarm/ArchiSteamFarm
    if [ $? -eq 0 ];then
        echo -e "----------------------------------------------------"
        echo -e "获取最新的ArchiSteamFarm主程序成功!";
        break;
    else
        Install_Failed_Confirm
    fi
done

Do_Create_Config_Files(){
    echo -e "===================================================="
    echo -e "开始生成需要的配置文件..."
    echo -e "----------------------------------------------------"
    read -p "输入你的steam账号登录使用的用户名: " username;
    echo -e "----------------------------------------------------"
    read -p "输入你的steam账号登录使用的密码: " password;
    cat>ArchiSteamFarm/config/bot.json<<EOF
{
  "SteamLogin": "$username",
  "SteamPassword": "$password",
  "Enabled": true,
}
EOF
    echo -e "----------------------------------------------------"
    echo -e "此步可直接按回车跳过..."
    echo -e "注意: 若跳过此步则暂时无法使用 ASF的[交互式控制台] 功能!"
    read -p "输入你的steam账号64位id: " steam64id;
    if [ ${#steam64id} == 17 ];then
        cat>ArchiSteamFarm/config/ASF.json<<EOF
{
  "SteamOwnerID": $steam64id
}
EOF
    fi
}

Create_Config_Confirm(){
    confirm=0
    while [ "$confirm" != 'yes' ] && [ "$confirm" != 'no' ];do
        echo -e "----------------------------------------------------"
        echo -e "是否直接创建配置文件?"
        echo -e "Generate config immediately?"
        echo -e "----------------------------------------------------"
        read -p "是否现在创建? (yes/no): " confirm;
    done
    if [ "$confirm" == 'yes' ];then
        Do_Create_Config_Files
    fi
}

echo -e "===================================================="
echo -e "开始配置相关选项"
Create_Config_Confirm
if [ -f "asf" ];then rm -f asf;fi
ln -s ArchiSteamFarm/ArchiSteamFarm asf
echo -e "===================================================="
echo -e `TZ=Asia/Shanghai date +"%F %T"`
echo -e "ASF部署完成! 输入指令[./asf]来运行. Enjoy it! "
endTime=`date +"%s"`
((outTimeMinute=($endTime-$startTime)/60))
((outTimeSecond=($endTime-$startTime)%60))
echo -e "总共用时: \033[32m$outTimeMinute\033[0m Minute \033[32m$outTimeSecond\033[0m Second!"

Run_On_Srceen(){
    echo -e "===================================================="
    echo -e "在新窗口启动ASF程序..."
    screen -dmS asf
    screen -x -S asf -p 0 -X stuff "./asf"
    screen -x -S asf -p 0 -X stuff $'\n'
    echo -e "----------------------------------------------------"
    echo -e "现在可直接关闭当前ssh会话, ASF依然会在后台运行"
    echo -e "输入[screen -r asf]命令并回车 以进入运行中的ASF窗口"
    echo -e "在ASF窗口中 按下[Ctrl+A+D]组合键 以退回到当前窗口"
}

Screen_Confirm(){
    confirm=0
    while [ "$confirm" != 'yes' ] && [ "$confirm" != 'no' ];do
        echo -e "----------------------------------------------------"
        echo -e "是否使用screen将其在后台挂起?"
        echo -e "----------------------------------------------------"
        read -p "是否立刻在后台运行ASF? (yes/no): " confirm;
    done
    if [ "$confirm" == 'yes' ];then
        Run_On_Srceen
    fi
}

#ps -ef | grep "dmS asf" | grep -v grep | awk '{print $2}'
pkill -f "dmS asf"
#screen -wipe
Screen_Confirm

rm -f ez_start_asf.sh
