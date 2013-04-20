cflint: Documentation
=====================

## About the Documentation

At this point, documentation does not reflect actual functionality. It is intended to be used as a reference for future development only. 

As lint rules are defined and agreed-upon via the project's [issues list](https://github.com/russplaysguitar/cflint/issues), they should be added to the documentation. 

## Linter Specifications

### Supported code

Linting is limited to cfscript only. Tag linting is not supported. 

### Supported versions

The linter is designed to work for both CF 10 and Railo 4. Older versions are not explicitly supported, but the linter may be used with older versions by modifying the directives.

## Lint Rules

Rules are intended to strongly suggest best practices for cfscript in most cases. The point is to increase code readability, consistency, and overall quality while reducing the likelihood of logical errors. Rules do not exist for code which throws errors. 

Rules are not intended to be used blindly. It is the responsibility of the developer to understand the rules and to determine when rules should or should not be applied. 

- `evaluate()` will fail lint. Suggested alternative: Don't use it.
- `incrementValue()` will fail lint. Suggested alternative: `++`
- `decrementValue()` will fail lint. Suggested alternative: `--`
- `setVariable()` will fail lint. Suggested alternative: `=`
- `isDefined()` will fail lint. Suggested alternative: `StructKeyExists()`. 
- Unnecessary use of \# signs
  - Wrapping a variable in pound signs (hash marks) will fail lint. Example: `var x = #y#;`
  - Wrapping a variable in quotations and pound signs will warn if no other characters are included. Example: `var x = "#y#";`
- Use of reserved words will fail lint. 
- Calling `rand()` without first calling `randomize()` will warn. 

## Directives (settings)

All rules can be set to one of `fail`, `warn`, or `off`. Most rules default to `fail`. 
