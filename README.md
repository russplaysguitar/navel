# cflint
===

You can contribute to this project by voicing your opinion about what rules a cfscript linter should have. (For the sake of sanity, this project is for cfscript only.)

See the issues list and wiki.

I'm currently working on getting a basic cfscript parser working in [JISON](http://zaach.github.io/jison/) before implementing the lint rules. Feel free to contribute to that as well: [cflint.jison](https://github.com/russplaysguitar/cflint/blob/master/cflint.jison)

## Tests
===

The tests use Node.js.

Install test dependencies:

	npm install

Run tests:

	npm test
