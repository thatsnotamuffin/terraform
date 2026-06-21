# Release Process

## Semantic Versioning

This repository follows semantic versioning using the format:

`vMAJOR.MINOR.PATCH`

**Example:**

`v1.2.3`

Version changes are based on the impact to existing consumers of the modules.

⸻

### Major Release

**Example:**

`v2.0.0`

Major releases include breaking changes that may require consumers to update configuration, review Terraform plans carefully, or perform manual migration steps.

Examples of major release changes include:

* Removing or renaming variables, outputs, modules, or resources
* Changing default behavior in a way that alters existing infrastructure
* Adding resources to an existing module in a way that affects existing consumers by default
* Removing resources from an existing module
* Changing resource names, addresses, or module structure in a way that affects Terraform state
* Changes that may cause resource replacement
* Required Terraform or provider version updates that force consumer changes
* Changes requiring state migration, imports, moved blocks, or manual intervention

Major releases must include migration notes.

⸻

### Minor Release

**Example:**

`v1.1.0`

Minor releases include backward-compatible changes that add functionality without requiring existing consumers to make changes.

Examples of minor release changes include:

* Adding new modules
* Adding new optional variables
* Adding new outputs
* Adding new optional resources that are disabled by default
* Adding support for additional use cases without changing existing behavior
* Enhancing module functionality in a backward-compatible way
* Adding validation rules that do not affect existing valid configurations
* Expanding examples or usage patterns

⸻

### Patch Release

**Example:**

`v1.1.1`

Patch releases include backward-compatible fixes, documentation updates, and small improvements that do not change expected infrastructure behavior.

Examples of patch release changes include:

* Bug fixes that do not change expected behavior
* Documentation updates
* Example updates
* Typo fixes
* Formatting or linting changes
* Security updates that do not require consumer action
* Internal refactoring that does not affect module inputs, outputs, resources, or behavior

⸻

## **Release Template**

```txt
# <Release Title>
## Description
Provide a brief description of the changes made in this release.
## What's Changed
- <insert changes here in a bulleted format>
## Breaking Changes
Major releases only.
- List any breaking changes
- Include required consumer action
- Include migration instructions
- Note expected Terraform plan impact
## Migration Notes
Major releases only.
- Required variable changes:
- Required provider or Terraform version changes:
- State moves/imports:
- Manual steps:
- Rollback considerations:
## Full Changelog
https://github.com/thatsnotamuffin/terraform/compare/v<previous release>...v<new release>
```

⸻

### **Example Release**

```txt
# v0.2.0 - IAM Module Additions
## Description
Added reusable IAM modules for provisioning common AWS roles, policies, policy attachments, and OIDC trust relationships.
## What's Changed
- Added IAM modules:
  - OIDC provider
  - IAM policy
  - IAM policy attachment
  - IAM role
- Added module examples for GitHub Actions OIDC authentication
- Added documentation for IAM module inputs and outputs
## Full Changelog
https://github.com/thatsnotamuffin/terraform/compare/v0.1.0...v0.2.0
```
