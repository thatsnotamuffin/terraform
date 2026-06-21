## Type of Change
- [ ] Bug fix - non-breaking change that fixes an issue
- [ ] New feature - non-breaking change that adds functionality
- [ ] Breaking change - change that requires consumer action or may alter existing infrastructure
- [ ] Documentation update
- [ ] Refactor - internal change with no expected behavior change
- [ ] Security update
- [ ] Module addition

## Description
Provide a summary of the change, the motivation for it, and any relevant context.

Related issue (if applicable):

`Closes # `

## Modules Affected
List the modules changed by this PR.

* modules/<module-name>
* examples/<example-name>
* Documentation only

## Consumer Impact
- [ ] No consumer-facing changes
- [ ] Adds optional functionality only
- [ ] Changes defaults or behavior
- [ ] Requires configuration updates
- [ ] May cause resource replacement
- [ ] Requires state migration/import/moved blocks
- [ ] Requires provider or Terraform version changes

## Terraform Plan Impact
Describe the expected Terraform plan impact for existing consumers.

Expected plan impact:
- [ ] No changes expected
- [ ] New resources created only when enabled
- [ ] Existing resources updated
- [ ] Resources replaced
- [ ] Resources destroyed

## Details:
<describe expected plan impact here>

### Breaking Changes
Does this PR introduce breaking changes?

- [ ] No
- [ ] Yes

If yes, describe the breaking change and required migration steps.

<breaking change / migration notes>

### Testing
- [ ] terraform fmt passed
- [ ] terraform validate passed
- [ ] terraform plan reviewed for relevant examples
- [ ] Module examples updated or tested
- [ ] Documentation updated
- [ ] Not applicable

### Testing notes:
<testing notes>

### Documentation
- [ ] README updated
- [ ] Inputs/outputs updated
- [ ] Examples updated
- [ ] Release notes/changelog impact noted
- [ ] Not applicable

### Checklist
- [ ] I have reviewed the expected impact to existing consumers
- [ ] I have avoided changing defaults unless intentionally breaking
- [ ] I have added or updated examples where appropriate
- [ ] I have documented any required migration steps
- [ ] I have confirmed this change aligns with the release process
