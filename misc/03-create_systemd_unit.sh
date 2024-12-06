#!/bin/bash
PROJECT_NAME="Picamera2 WebUI Server"
PYTHON_EXECUTABLE="$(which python)"
PATH_TO_APP="$1"
PATH_TO_UNITFILE='/etc/systemd/system/picamera2-webui.service'

if false \
    || [ -z "$PATH_TO_APP" ] \
    || [ ! -f "$PATH_TO_APP/app.py" ] ;
then
    echo "This script should be started, by passing the full absolute path to the directory containing app.py, as the first parameter."
    echo "Example: sudo $0 /home/pi/picamera2-WebUI"
    exit 1
fi;

echo -e "This script will create now a Systemd system unit for ${PROJECT_NAME} and enable the service to start at boot. Please run it with root privileges otherwise you will get permission errors. \n\nPress enter to proceed or CTRL+C to abort."
# shellcheck disable=SC2034
read -r dummy

touch ${PATH_TO_UNITFILE}

# shellcheck disable=SC2181
if [ $? -ne 0 ];
then
    echo "ERROR: You do not have permission to create the unit file, exiting..."
    exit 1
fi

cat << EOF > ${PATH_TO_UNITFILE}

[Unit]
Description=${PROJECT_NAME}
After=network.target

[Service]
Type=simple
WorkingDirectory=${PATH_TO_APP}
#ExecStart=${PYTHON_EXECUTABLE} ${PATH_TO_APP}/app.py
ExecStart=${PATH_TO_APP}/start-picamera2-webui-app.sh
Restart=always

[Install]
WantedBy=multi-user.target

EOF

systemctl enable --now picamera2-webui.service
systemctl status picamera2-webui.service