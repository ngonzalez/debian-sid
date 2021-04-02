export NAMESPACE='ns'
export PROJECT_NAME='project'
export SERVICE_ACCOUNT='service-account@project.iam.gserviceaccount.com'
export KEY_FILE="$HOME/Sites/ansible/project.json"
export IMAGE_TAG='debian-sid'
export USER='debian'
export HOST_KEY=$(cat ~/.ssh/id_rsa.pub)
export REGION='europe-north1' # gcloud compute regions list
export ZONE='europe-north1-c' # gcloud compute zones list
export MACHINE_TYPE='n1-standard-8' # gcloud compute machine-types list --zones=$ZONE
export CLUSTER_NAME='kibana'
