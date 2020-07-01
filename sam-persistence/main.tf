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
 * For more information, check out the [MC-Terra deployment doc](https://docs.dsp-devops.broadinstitute.org/mc-terra/mcterra-deployment)
 * and our [Terraform best practices](https://docs.dsp-devops.broadinstitute.org/best-practices-guides/terraform).
 *
 * This documentation is generated with [terraform-docs](https://github.com/segmentio/terraform-docs)
 * `terraform-docs markdown --no-sort . > README.md`
 *
 * ## TODO
 * need to add Firestore manual steps, see terraform-terra.
 * Waiting on https://github.com/terraform-providers/terraform-provider-google/issues/3657
 * 
 */
