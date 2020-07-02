# terraform-ap-modules
DSP Analysis Platform Terraform Modules. This public repository contains Terraform modules that are meant to be Broad-agnostic and can potentially be deployed by outside parties. The general pattern for their deployment inside the Broad is for them to be referenced from a deployment in the private [terraform-ap-deployments repository](https://github.com/broadinstitute/terraform-ap-deployments), along with any Broad-specific infrastructure.

## Formatting
Before committing changes to a module, please run the following linting operations in the module directory:
- `terraform fmt` - Will fix any formatting/indentation syntax.
- `terraform-docs markdown --no-sort . > README.md` - If adding/modifying vars/outputs/README header, this [terraform-docs](https://github.com/segmentio/terraform-docs) command will update the README.

### Pre-commit hook
To do the above linting automatically on each commit, you can add the following git commit hook in `.git/hooks/pre-commit`:
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
for d in $(ls -1)
do
  terraform-docs md --no-sort $d > $d/README.md
  if [ $? -eq 0 ] ; then
    git add "./$d/README.md"
  fi
done
```
