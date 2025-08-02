FROM php:8.2-apache

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y \
    git unzip zip curl libonig-dev libzip-dev libpng-dev libxml2-dev \
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath gd

# Habilita mod_rewrite de Apache
RUN a2enmod rewrite

# Define la carpeta public como raíz del sitio
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

# Cambia configuración de Apache para servir desde /public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/000-default.conf \
    && echo "<Directory /var/www/html/public>\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>" > /etc/apache2/conf-available/laravel.conf \
    && a2enconf laravel

# Copia Composer desde la imagen oficial
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copia todos los archivos del proyecto
COPY . /var/www/html

# Copia script de inicio y da permisos automáticamente
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Establece directorio de trabajo
WORKDIR /var/www/html

# Asigna permisos a Laravel
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 storage bootstrap/cache

# Usa el entrypoint personalizado
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]