# glowing-palm-tree
Demo Terraform for Hashicorp meetup


TODO:
* Jenkins instance
* Provision docker build agent
* Create docker image with terraform and specified providers (Tagged with a different verion for different providers)
* Create terraform code to do something in AWS 
* Run the Jeknins pipeline to deploy the infrastructure
* 


# environment variable needed for terraform to use AWS provider
* $ export AWS_ACCESS_KEY_ID="anaccesskey"
* $ export AWS_SECRET_ACCESS_KEY="asecretkey"
* $ export AWS_REGION="us-west-2"