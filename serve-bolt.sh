#!/usr/bin/env bash

block="server {
    listen ${3:-80};
    listen ${4:-443} ssl http2;
    server_name $1;
    root \"$2\";

    index index.html index.htm index.php;

    charset utf-8;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~* /thumbs/(.*)$ {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    # this is for bolt betterthumbs https://github.com/cdowdy/boltbetterthumbs
    location ~* /img/(.*)$ {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

     location ~* /bolt/(.*)$ {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

   
    location ~* /async/(.*)$ {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

   location ~* \.(?:ico|css|js|gif|jpe?g|png|ttf|woff|woff2)$ {
        access_log off;
        expires 30d;
        add_header Pragma public;
        add_header Cache-Control \"public, mustrevalidate, proxy-revalidate\";
    }
  
    location = /(?:favicon.ico|robots.txt) {
        access_log off;
        log_not_found off;
    }

 
    location ~ /\. {
        deny all;
    }

   
    location ~ /\.(?:db)$ {
        deny all;
    }


    location ~ /(?:bower|composer|jsdoc|package)\.json$ {
        deny all;
    }

    
    location ~* /(.*)\.(?:dist|markdown|md|twig|yaml|yml)$ {
        deny all;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log off;
    error_log  /var/log/nginx/$1-ssl-error.log error;

    sendfile off;

    client_max_body_size 100m;

    # DEV
    location ~ ^/index\.php(/|\$) {
        fastcgi_split_path_info ^(.+\.php)(/.*)\$;
        fastcgi_pass unix:/var/run/php/php$5-fpm.sock;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;

        fastcgi_intercept_errors off;
        fastcgi_buffer_size 16k;
        fastcgi_buffers 4 16k;
    }

    location ~ /\.ht {
        deny all;
    }

    ssl_certificate     /etc/nginx/ssl/$1.crt;
    ssl_certificate_key /etc/nginx/ssl/$1.key;
}
"

echo "$block" > "/etc/nginx/sites-available/$1"
ln -fs "/etc/nginx/sites-available/$1" "/etc/nginx/sites-enabled/$1"
