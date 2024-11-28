# terraform-ap-modules
DSP Analysis Platform Terraform Modules. This public repository contains Terraform modules that are meant to be Broad-agnostic and can potentially be deployed by outside parties. The general pattern for their deployment inside the Broad is for them to be referenced from a deployment in the private [terraform-ap-deployments repository](https://github.com/broadinstitute/terraform-ap-deployments), along with any Broad-specific infrastructure.

## Workflow for Atlantis-managed deployments
When making changes to modules deployed with Atlantis in the [terraform-ap-deployments repository](https://github.com/broadinstitute/terraform-ap-deployments), the following workflow must be followed:
1. Create a PR in this repo with changes to the module(s). If changing a module that is a sub-module of another module (such as `terra-env`), remember to point the module reference to the PR branch.
2. Create a PR in terraform-ap-deployments with the module reference of the changing module pointing to the modules repo PR branch.
3. [Run a plan](https://github.com/broadinstitute/terraform-ap-deployments#3-iterate-using-atlantis) in the ap-deployments PR. If changing multiple environments/projects it is recommended to initially reach a green plan/apply for one of them before changing the others (`atlantis plan -p [project name]`).
4. When the plan above succeeds, obtain reviews for both PRs.
5. Apply your changes. Sometimes errors will appear during the apply that TF did not catch in the plan. After adressing any such errors, repeat 3 and 4.
6. Once the apply is successful, update any sub-module references in the ap-modules PR branch to a version tag one minor version higher than the previous version of that module, then merge the ap-modules PR.
7. Tag the merge commit in master with any new versions from the last step, and new versions for any modules pointing to those new versions, usually `terra-env`. For example, if the PR involves changes to two submodules of `terra-env`, there should be 3 tags on the merge commit, one for each of the two changed submodules and a new terra-env version.
8. Update the ap-deployments PR to point to the new version(s) instead of the PR branch, and run one more round of plan/review to sanity check the version locks. This should come back with no changes if the versioning/tagging workflow was followed.
9. When the plan with the versions locked is successful and reports no changes, and the version-locking commit is approved, the deployment PR may be merged.

## Formatting
Before committing changes to a module, please run the following linting operations in the module directory:
- `terraform fmt` - Will fix any formatting/indentation syntax.
- `terraform-docs markdown . > README.md` - If adding/modifying vars/outputs/README header, this [terraform-docs](https://github.com/segmentio/terraform-docs) command will update the README.

### Pre-commit hook
To do the above linting automatically on each commit, you can add the following git commit hook in `.git/hooks/pre-commit`:
(If you have global hooks already you may need to add [this tweak](https://stackoverflow.com/a/49912720/2014408) to run local ones as well)
```
#!/bin/sh

# Formats any *.tf files according to the hashicorp convention
files=$(git diff --diff-filter=d --cached --name-only)
for f in $files
do
  if [ -e "$f" ] && [[ $f == *.tf ]]; then
    terraform fmt -check=true $f
  fi
done

# Keep module docs up to date
for d in $(ls -d */)
do
  terraform-docs md --no-sort $d > $d/README.md
  if [ $? -eq 0 ] ; then
    git add "./$d/README.md"
  fi
done
```
