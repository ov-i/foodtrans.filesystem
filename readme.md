# FoodTrans.FileSystem
Simple web API for allowing end users to download, upload and manage files.
It's going to be mostly usable by administrators and collaborators.

## Table of Contents
- General info
- Technologies
- Setup
- Usage

### General info
This repository is a part of the FoodTrans project. Module presented here is responsible for everything related to FileSystem methodologies. Morover, this microservice, uses some parts
of **FoodTrans.Auth** module, to make sure, that users can access only if they are logged in and authorized.

### Technologies
Project is built upon:
- PHP 8.1 - Is an interpreted, scripting programming language designed to generate web pages and build real-time web applications. While writing your new application, you can use 
almost every modern editor, libraries that are dedicated to PHP
- Symfony 6.x - The leading PHP framework to create websites and web applications. Built on top of the Symfony Components.
- PostgreSQL - PostgreSQL is a powerful, open source object-relational database system with over 30 years of active development that has earned it a strong reputation for reliability, feature robustness, and performance.

## Setup
There are two ways to run this project. You can run it in dockerized conatiner or localy with .NET runtime. After cloning the repository you can:

### Run in docker
First, make sure you have docker installed. If yes, then open your terminal and go to root folder of this repository. Then you can build the docker compose using command:

```bash
docker compose up -d --build
```
If build succedded, you can start using this project

**WARNING**
You cannot use for example this command

```bash
docker run -d -p <port>:80
```

Since this image has been build with php-fpm package. It does some nginx / apache magic,
but is not fully configured to use it, as seperate image.

**How to open it?**
By default, application listen on port 8001. But you can change it, by replacing on **<root-dir>.env** file
the **APP_DEV_PORT** variable for your own

Open your browser and go under the address http://localhost:<YOUR_PORT> to communicate with the API.

### Run locally
If you would like to run this project locally, first of:
- make sure, you have php8.1 version installed on your machine
- make sure, you have symfony-cli installed on your machine if not, you can install as [Follows](https://symfony.com/download)
- make sure, you configured postgresql on your machine

If you already done, just run this command
```bash
symfony server:start
```

## Usage
- Manage files
- Allowing users to upload / download / preview files
- Allowing to authorize with JWT Token

## Have you found a bug?
If you found a bug, go ahead and open issue by providing detailed description, so we could reproduce the bug and fix it.