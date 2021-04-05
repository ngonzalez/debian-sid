# docker
export IMAGE_TAG='debian-sid'
export USER='debian'
export HOST_KEY=$(cat ~/.ssh/id_rsa.pub)

# gcp
export PROJECT_NAME='project'
export NAMESPACE='namespace'
export SERVICE_ACCOUNT='service-account@project.iam.gserviceaccount.com'
export KEY_FILE="$HOME/.project_key.json"
export REGION='europe-north1' # gcloud compute regions list
export ZONE='europe-north1-c' # gcloud compute zones list
export MACHINE_TYPE='n1-standard-8' # gcloud compute machine-types list --zones=$ZONE
export CLUSTER_NAME='app'
