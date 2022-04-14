sudo -v

echo "Docker login"
docker login

echo "Building image !"

docker build . -t local/easyappointments:local

echo "Saving image tar!"
docker save local/easyappointments:local > nebua-easyappointments.tar

# Import to microk8s
echo "Importing image to microk8s!"
sudo microk8s ctr image import nebua-easyappointments.tar

echo "Remove File tar!"
sudo rm -r nebua-easyappointments.tar
echo "Done!"

<<<<<<< HEAD
docker image push nebua/easyappointments:latest
=======
#docker image push nebua/easyappointments:latest
>>>>>>> f9e68cbd5898bc562544af87e9d5e9e0125f6d61
