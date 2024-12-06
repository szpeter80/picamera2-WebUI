#!/bin/bash

if [ ! -f "./app.py" ] ;
then
    echo "ERROR: application not found in the cwd, exiting..."
    exit 1
fi;


if [ -d "./.venv" ] ;
then
    echo "Virtual environment found, activating it..."
    # shellcheck disable=SC1091
    . ./.venv/bin/activate
fi;

python ./app.py

deactivate