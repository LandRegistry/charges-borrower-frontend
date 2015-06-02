#! /usr/bin/bash

virtualenv ./.service_env

source ./.service_env/bin/activate

pip3 install -r requirements.txt

port="${B_GUNICORN_PORT:-8000}"
host="${B_GUNICORN_HOST:-0.0.0.0}"


gunicorn -b $host:$port --pid /var/run/borrower_frontend/borrower_frontend.pid "app:create_manager().app"
