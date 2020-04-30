# Sam

This module enables the APIs and creates the service accounts needed to run the
[Sam service](https://github.com/broadinstitute/sam/).

It does not create the persistent storage resources that Sam relies on. We plan on sharing the persistent storage from the "classic" Terra deployment, so we need to distinguish between
resources to be shared with the classic deployment and resources that are independent to new deployments.

Resources in this folder are created by the classic deployment today in dev/staging/production "shared" environments.
To create the same resources for not-shared environments exclusive to this deployment, we need to be create the same
resources. This module handles those resources.


## TODO
Need to add manual steps for GSuite service accounts. See terraform-terra repo.

Need to add Oauth Client secrets. See terraform-terra repo.
Maybe possible in terraform now with https://github.com/terraform-providers/terraform-provider-google/issues/1287.
