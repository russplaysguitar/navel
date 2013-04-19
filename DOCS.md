cflint: Documentation
=====================

## About the Documentation

At this point, documentation does not reflect actual functionality. It is intended to be used as a reference for future development only. 

As lint rules are defined and agreed-upon via the project's [issues list](https://github.com/russplaysguitar/cflint/issues), they should be added to the documentation. 

## Lint Rules

### isDefined()

Any use of `isDefined()` will fail. Suggested alternative: `StructKeyExists()`. 

## Directives (settings)

All rules can be set to one of `fail`, `warn`, or `off`. Most rules default to `fail`. 