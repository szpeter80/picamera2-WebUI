#!/bin/bash
VENVDIR='.venv'

if [ -d "../${VENVDIR}" ] ;
then
    echo "ERROR: ../${VENVDIR} already exists, refusing to run."
    exit 1
fi;

if [ ! -f "../app.py" ] ;
then
    echo "ERROR:  application (../app.py) not found, refusing to run."
    exit 1
fi;

python -m venv "../${VENVDIR}" --system-site-packages