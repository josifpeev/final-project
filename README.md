Hosting Project
------------------------------
This is a project that creates and manages a group of hosting servers based on Ubuntu Linux 20.04. The project is created for usage in AWS.
In our case, we used Plesk as a hosting panel.
We create our image with a Packer, which we upload to AMIs Amazon. After that, we use terraform to create EC2 instance of the image. All initial settings are handled by Аnsible.
Everything is optimized and there is almost no manual intervention, but there will be details about this below.

We use Cloud9 instance on which we are installed: packer, terraform and ansible

The steps we go through.

1. Create the image with a packer, update, install the latest version of Plesk and upload it as an image to amazon. Аll this is described in the file packer/plesk.pkr.hcl
   The steps we apply are:
   - On this line we can set how big we want be our volume size "volume_size = 12" Int this case it is 12GB
   - packer validate .
   - packer build plesk.pkr.hcl
2. We see what the name of the finished image is and we need to fill it manually in the file terraform/variables.tf 
   example: default = "ami-0756cdb1e6c096e6d"
3. In terraform/main.tf file we need to describe some things that are important.
   - We need to create key pair in AWS
   - Is need to change key_name with your: key_name = "plesk_key_pair"
   - Replace all places that contain "ples01" with one of your choice.
   - Create your ssh pub key and replace it at ssh_authorized_keys: your-ssh-pub-key
4. Go to terraform folder and execute commands:
    - terraform init
    - terraform plan
    - terraform apply
5. Congratulations, you now have a virtual machine running with a Plesk host panel
6. Before we log in through the web, we need to log in with ssh in the virtual machine and change the root password to one of our choice.
7. Voila, you can use to log in: https://ip-in-your-vm

NOTE: If this instance is already full, we can easily make another one by copying the same things from our first virtual machine once more and changing "ples01" to another name