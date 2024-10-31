#!/usr/bin/env sh

#!/usr/bin/env sh

set -x
docker run -d -p 80:80 --name my-apache-php-app -v c:/var/jenkins_home/workspace/lab-7-b-pipeline/src:/var/www/html php:7.2-apache
sleep 1

# Add Apache configuration changes to allow access to all
docker exec my-apache-php-app sh -c "echo '<Directory /var/www/html>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>' > /etc/apache2/conf-available/custom-access.conf"
docker exec my-apache-php-app a2enconf custom-access
docker exec my-apache-php-app service apache2 reload

set +x

echo 'Now...'
echo 'Visit http://localhost to see your PHP application in action.'
