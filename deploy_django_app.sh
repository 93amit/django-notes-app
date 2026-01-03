#!/bin/bash

# task >> deploy the Django app and handle the code for errors task


code_clone() {
        echo " Clonning the Django app..."
        git clone https://github.com/93amit/django-notes-app.git
}

install_requirements() {
        echo " installing dependencies"
        sudo apt-get install docker.io  nginx -y
}



required_restarts() {
        sudo chown $USER /var/run/docker.sock
        sudo systemctl enable docker
        sudo systemctl enable nginx
        sudo systemctl restart docker
}

deploy() {
        docker build -t notes-app .
        docker run -d -p 8000:8000 notes-app:latest
}

echo "******* Deployment Started *******"

if ! code_clone; then
        echo " the code directory already exist"
        cd django-notes-app
fi

if ! install_requirements; then
        echo " Installation Failled"
        exit 1
fi

if ! required_restarts; then
        echo " system fault identified "
        exit 1
fi

if ! deploy; then
        echo " Deployement failed, mailling the admin"
        # sendmail
fi
echo "******* Deployment Done *******"
