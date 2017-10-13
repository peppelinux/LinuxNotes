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

# localhost keyword is reserved for connection using the MySQL socket and you should use the ip-address 127.0.0.1 for TCP connections to the MySQL network port on 127.0.0.1. This means that both the server must grant privileges to users from specifically 127.0.0.1, and the client must use -h 127.0.0.1 to go through the tunnel instead of connecting to a local socket.
GRANT ALL PRIVILEGES on *.* to 'root'@'127.0.0.1' IDENTIFIED BY 'new_password';

# keep in mind to not use 'localhost' but 127.0.0.1 in client connection
ssh server.hostname.com -L 1234:127.0.0.1:3306
mysql -h 127.0.0.1 -P1234 -u root -p

FLUSH PRIVILEGES;
FLUSH QUERY CACHE;
