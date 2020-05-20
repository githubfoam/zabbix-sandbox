# -*- mode: ruby -*-
# vi: set ft=ruby :

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = "512"
      vb.cpus = 2
    end

  config.vm.define "master01" do |hpcluster|
    hpcluster.vm.box = "bento/ubuntu-18.04"
    hpcluster.vm.hostname = "master01"
    hpcluster.vm.network "private_network", ip: "192.168.1.254"
    hpcluster.vm.network "forwarded_port", guest: 80, host: 8080
    hpcluster.vm.provider "virtualbox" do |vb|
        vb.name = "master01"
        vb.memory = "4096"
    end
    hpcluster.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "deploy.yml"
    ansible.become = true
    ansible.compatibility_mode = "2.0"
    ansible.version = "2.9.7"
    end
    hpcluster.vm.provision "shell", inline: <<-SHELL
    # packages
    wget https://repo.zabbix.com/zabbix/4.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.0-3+bionic_all.deb
    sudo dpkg -i zabbix-release_4.0-3+bionic_all.deb
    sudo apt-get update
    sudo apt-get install apache2 libapache2-mod-php
    sudo apt-get install mysql-server
    sudo apt-get install php php-mbstring php-gd php-xml php-bcmath php-ldap php-mysql
    sudo apt-get install -y zabbix-server-mysql zabbix-frontend-php zabbix-agent
    # configure MYSQL
    sudo mysql -uroot -proot -e "CREATE DATABASE zabbixdb character set utf8 collate utf8_bin;"
    sudo mysql -uroot -proot zabbixdb -e "CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'zabbix';"
    sudo mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON zabbixdb.* TO 'zabbix'@'localhost' WITH GRANT OPTION;"
    sudo mysql -uroot -proot -e "FLUSH PRIVILEGES;"
    zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz | sudo mysql zabbixdb
    # configure Zabbix
    sudo sed -i "s|^DBName=zabbix|DBName=zabbixdb|; /^# DBPassword=/a \\\\DBPassword=zabbix" /etc/zabbix/zabbix_server.conf
    sudo sed -i "s|# php_value date.timezone Europe/Riga|php_value date.timezone Europe/Berlin|" /etc/apache2/conf-enabled/zabbix.conf
    sudo cat > /usr/share/zabbix/conf/zabbix.conf.php << "EOF"
<?php
// Zabbix GUI configuration file.
global $DB;
$DB['TYPE']     = 'MYSQL';
$DB['SERVER']   = 'localhost';
$DB['PORT']     = '0';
$DB['DATABASE'] = 'zabbixdb';
$DB['USER']     = 'zabbix';
$DB['PASSWORD'] = 'zabbix';
// Schema name. Used for IBM DB2 and PostgreSQL.
$DB['SCHEMA'] = '';
$ZBX_SERVER      = 'localhost';
$ZBX_SERVER_PORT = '10051';
$ZBX_SERVER_NAME = '';
$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
EOF
    # enable and start services
    sudo update-rc.d zabbix-server enable
    sudo service zabbix-server start
    sudo update-rc.d zabbix-agent enable
    sudo service zabbix-agent start
    sudo service apache2 restart
    SHELL
  end

#   config.vm.box = "bento/ubuntu-18.04"
#   config.vm.network "forwarded_port", guest: 80, host: 8080
#   config.vm.provision "shell", inline: <<-SHELL
#     # packages
#     wget https://repo.zabbix.com/zabbix/4.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.0-3+bionic_all.deb
#     sudo dpkg -i zabbix-release_4.0-3+bionic_all.deb
#     sudo apt-get update
#     sudo apt-get install apache2 libapache2-mod-php
#     sudo apt-get install mysql-server
#     sudo apt-get install php php-mbstring php-gd php-xml php-bcmath php-ldap php-mysql
#     sudo apt-get install -y zabbix-server-mysql zabbix-frontend-php zabbix-agent
#     # configure MYSQL
#     sudo mysql -uroot -proot -e "CREATE DATABASE zabbixdb character set utf8 collate utf8_bin;"
#     sudo mysql -uroot -proot zabbixdb -e "CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'zabbix';"
#     sudo mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON zabbixdb.* TO 'zabbix'@'localhost' WITH GRANT OPTION;"
#     sudo mysql -uroot -proot -e "FLUSH PRIVILEGES;"
#     zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz | sudo mysql zabbixdb
#     # configure Zabbix
#     sudo sed -i "s|^DBName=zabbix|DBName=zabbixdb|; /^# DBPassword=/a \\\\DBPassword=zabbix" /etc/zabbix/zabbix_server.conf
#     sudo sed -i "s|# php_value date.timezone Europe/Riga|php_value date.timezone Europe/Berlin|" /etc/apache2/conf-enabled/zabbix.conf
#     sudo cat > /usr/share/zabbix/conf/zabbix.conf.php << "EOF"
# <?php
# // Zabbix GUI configuration file.
# global $DB;
# $DB['TYPE']     = 'MYSQL';
# $DB['SERVER']   = 'localhost';
# $DB['PORT']     = '0';
# $DB['DATABASE'] = 'zabbixdb';
# $DB['USER']     = 'zabbix';
# $DB['PASSWORD'] = 'zabbix';
# // Schema name. Used for IBM DB2 and PostgreSQL.
# $DB['SCHEMA'] = '';
# $ZBX_SERVER      = 'localhost';
# $ZBX_SERVER_PORT = '10051';
# $ZBX_SERVER_NAME = '';
# $IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
# EOF
#     # enable and start services
#     sudo update-rc.d zabbix-server enable
#     sudo service zabbix-server start
#     sudo update-rc.d zabbix-agent enable
#     sudo service zabbix-agent start
#     sudo service apache2 restart
#   SHELL

end
