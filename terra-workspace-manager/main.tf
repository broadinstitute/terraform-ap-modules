/**
 * # Terra Workspace Manager module
 * 
 * This module creates the service account and CloudSQL databases necessary for 
 * running the [Workspace Manager](http://github.com/databiosphere/terra-workspace-manager).
 * This currently requires two postgres databases: one for the workspace manager 
 * itself, and one for the Stairway library used for managing sagas.
 * 
 * For more information, check out the [MC-Terra deployment doc](https://docs.dsp-devops.broadinstitute.org/mc-terra/mcterra-deployment)
 * and our [Terraform best practices](https://docs.dsp-devops.broadinstitute.org/best-practices-guides/terraform).
 *
 * This documentation is generated with [terraform-docs](https://github.com/segmentio/terraform-docs)
 * `terraform-docs markdown --no-sort . > README.md`
 */
