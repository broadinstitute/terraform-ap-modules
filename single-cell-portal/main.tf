/**
 * # Terra POC Service module
 *
 * This module creates the infrastructure necessary for running the 
 * [Single Cell Portal](https://singlecell.broadinstitute.org/single_cell).
 * 
 * For more information, check out the [MC-Terra deployment doc](https://docs.dsp-devops.broadinstitute.org/mc-terra/mcterra-deployment)
 * and our [Terraform best practices](https://docs.dsp-devops.broadinstitute.org/best-practices-guides/terraform).
 *
 * ## VM provisioning flow with Ansible
 * This module currently provisions its VMs using Ansible roles defined or referenced in the [dsp-ansible-configs repo](https://github.com/broadinstitute/ * dsp-ansible-configs). Below is an outline of this process:
 * 1. This Terraform module in turn uses the [docker-instance-data-disk module](https://github.com/broadinstitute/terraform-shared/tree/master/ * terraform-modules/docker-instance-data-disk), which initializes the VMs it creates with a [shell script](https://github.com/broadinstitute/ * terraform-shared/blob/master/terraform-modules/docker-instance-data-disk/centos-ansible.sh) that:
 * 	- installs Ansible
 * 	- pulls down dsp-ansible-configs, parameterized by ANSIBLE_BRANCH
 * 	- runs ansible-pull with provisioner.yml one time
 * 		- The logs from this run are located at `/root/ansible-provisioner-firstrun.log`
 * 2. The above initial Ansible run:
 * 	- applies local ansible-role-clone-repos ansible role
 * 	- pulls the default 2 roles, ansible-role-configure and ansible-role-yum-cron
 * 	- pulls and applies ansible-role-configure ansible role
 * 		- parameterized by ANSIBLE_BRANCH
 * 3. The ansible-role-configure role creates a cron job to run a bash script, [`/usr/local/bin/dsp-absible.sh`](https://github.com/broadinstitute/ * ansible-role-configure/blob/master/templates/usr_local_bin_dsp-ansible.j2), which, on a schedule:
 * 	- exposes instance labels as env variables
 * 		- like `ANSIBLE_PROJECT` and `ANSIBLE_BRANCH`
 * 	- configures inventory to point to the appropriate [group configured in dsp-ansible-configs](https://github.com/broadinstitute/dsp-ansible-configs/ * tree/master/inventories)
 * 		- based on the `ANSIBLE_PROJECT` VM label and env variable
 * 		- for example [here is the one for SCP](https://github.com/broadinstitute/dsp-ansible-configs/tree/master/inventories/singlecell)
 * 	- pulls the latest from dsp-ansible-configs and runs Ansible with [`ANSIBLE_PROJECT`].yml
 * 		- so `singlecell.yml` in this case
 * 	- logs to `/var/log/ansible-pull.log`
 * 4. `singlecell.yaml`, in combination with the [`singlecell` inventory](https://github.com/broadinstitute/dsp-ansible-configs/tree/master/inventories/ * singlecell), instructs Ansible which roles to apply to which hosts
 * 	- in this case, there are two types of hosts:
 * 		- the app server, identified with `singlecell-[00:99]`
 * 		- the mongo VM, identified with `singlecell-mongo-[00:99]`
 * 	- there are a bunch of roles that get applied to both of them (like `docker-ol2` to set up docker), and specific roles for application-specific  * configuration
 * 5. For the app server, this is it, the actual SCP application is deployed onto it by the SCP Jenkins. For the Mongo instance, Ansible installs a role, [ * ansible-role-docker-service](https://github.com/broadinstitute/ansible-role-docker-service), that:
 * 	- pulls down configuration from a Google bucket (that in this case was [put there by Terraform](https://github.com/broadinstitute/terraform-shared/ * blob/master/terraform-modules/mongodb/config.tf)), including a docker-compose file
 * 	- Installs a cron job that monitors the bucket for changes and when it finds them:
 * 		- syncs the bucket with the local config
 * 		- performs a docker-compose down/up
 * 		- runs a simple health check
 * 		- logs to `/var/log/messages`, prefixed with the host name and suffixed with `_config`
 * 			- `sudo cat /var/log/messages | grep "singlecell-mongo_config"`
 *
 * This documentation is generated with [terraform-docs](https://github.com/segmentio/terraform-docs)
 * `terraform-docs markdown --no-sort . > README.md`
 */
