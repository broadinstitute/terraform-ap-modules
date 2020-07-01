/**
 * # Sam Persistence module
 * 
 * We plan on sharing the persistent storage from the "classic" Terra deployment, so we need to distinguish between
 * resources to be shared with the classic deployment and resources that are independent to new deployments.
 * 
 * Resources in this folder are created by the classic deployment today in dev/staging/production "shared" environments.
 * To create the same resources for not-shared environments exclusive to this deployment, we need to be create the same
 * resources. This module handles those resources.
 * 
 * ## TODO
 * need to add Firestore manual steps, see terraform-terra.
 * Waiting on https://github.com/terraform-providers/terraform-provider-google/issues/3657
 * 
 */
