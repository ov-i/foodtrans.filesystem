# Getting php8.1 fpm package
FROM php:8.1-fpm

# Setting working directory to /var/www
WORKDIR /var/www

# Copy composer.json to working directory
COPY composer.json .

# Updating system, and upgrading packages
RUN apt-get update && apt-get upgrade -y

# Installing required packages
RUN apt-get install -y build-essential \
  vim \
  curl \
  zip \
  unzip \
  htop \
  wget \
  postgresql \
  postgresql-contrib \
  postgresql-client \
  git \
  locales \
  libfreetype6-dev \
  libjpeg-dev \
  libpng-dev \
  libxml2-dev \
  libjpeg62-turbo-dev \
  libpq-dev \
  libzip-dev \
  zsh \
  gnupg1

# Install redis, xdebug an sodium php extension
RUN pecl install redis
RUN pecl install xdebug

RUN docker-php-ext-install intl

# Enable php extensions
RUN docker-php-ext-enable intl
RUN docker-php-ext-enable xdebug
RUN docker-php-ext-enable redis

# Clear cahce
RUN apt clean && rm -rf /var/cache/apt/archives/*
RUN apt clean && rm -rf /var/lib/apt/lists/*

# install pdo_postgresql extension bcmath exif and pcntl
RUN docker-php-ext-install pdo_pgsql bcmath exif pcntl
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j "$(nproc)" gd

# Install composerq 
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install symfony cli
RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | bash
RUN apt install symfony-cli

# create group for /var/www
RUN groupadd -g 1000 www

# create user for application
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy docker/php to app
COPY docker/php /var/www

# Grant chown permissions for www user in /var/www dir
RUN chown -R www:www /var/www

# Change user
USER www

# check if vendor directory exists, if not run composer install
RUN if [ ! -d /var/www/vendor ]; then \
  composer install; \
fi

# Run composer dump-autoload
RUN composer dump-autoload

# install oh my zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Add plugins for oh-my-zsh
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# replace and add plugins to plugins list
RUN sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc

# Setup aliases for git
RUN echo "alias gs='git status'" >> ~/.zshrc
RUN echo "alias gd='git diff'" >> ~/.zshrc
RUN echo "alias gc='git commit'" >> ~/.zshrc
RUN echo "alias gca='git commit -a'" >> ~/.zshrc
RUN echo "alias gco='git checkout'" >> ~/.zshrc

# expose to 9000 
EXPOSE 9000

# run application
CMD ["php-fpm"]