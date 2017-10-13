# mariadb suggested: 
sudo mysql_secure_installation

mysql --version
systemctl stop mysql
mysqld_safe --skip-grant-tables --skip-networking
mysql -u root

FLUSH PRIVILEGES;

# MySQL 5.7.6 and newer as well as MariaDB 10.1.20 and newer
ALTER USER 'root'@'localhost' IDENTIFIED BY 'new_password';

# MySQL 5.7.5 and older as well as MariaDB 10.1.20 and older, use:
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('new_password');

# IF "ERROR 1131 (42000): You are using MariaDB as an anonymous user and anonymous users are not allowed to modify user settings"
UPDATE mysql.user SET authentication_string = PASSWORD('new_password') WHERE User = 'root' AND Host = 'localhost';

FLUSH PRIVILEGES;
