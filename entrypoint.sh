#!/bin/bash

cd /var/www/html

# Copia .env si no existe
if [ ! -f .env ]; then
    cp .env.example .env
    echo "Archivo .env creado desde .env.example"
fi

# Instala dependencias si no existe /vendor
if [ ! -d vendor ]; then
    echo "Instalando dependencias con Composer..."
    composer install
fi

# Genera la clave de la app si no está definida
if ! grep -q "APP_KEY=base64" .env; then
    echo "Generando APP_KEY..."
    php artisan key:generate
fi

# Ejecuta migraciones si la base de datos está accesible
echo "Ejecutando migraciones..."
php artisan migrate --force

# Asigna permisos otra vez por seguridad
chown -R www-data:www-data /var/www/html
chmod -R 775 storage bootstrap/cache

# Inicia Apache en primer plano
apache2-foreground