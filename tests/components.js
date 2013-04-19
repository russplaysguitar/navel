var assert = require('assert');
var parser;

function parse(input){
	return parser.parse(input);
}

describe("cflint", function(){

	before(function(){
		var fs = require('fs');
		var ebnf = require('ebnf-parser');
		var jison = require('jison').Parser;
		var grammar = fs.readFileSync('cflint.jison').toString('utf-8');
		parser = new jison( ebnf.parse(grammar) );
	});

	describe("components", function(){

		it("should allow empty component{}", function(){

			var result;

			try {
				result = parse("component {}");
			} catch(e) {
				result = result || false;
			}

			assert.equal(true, result);

		});

		it("should allow component-global variables", function(){

			var result;

			try {
				result = parse("component { variables.x = 1; }");
			} catch(e) {
				result = result || false;
			}

			assert.equal(true, result);

		});

		it("should allow component-functions", function(){

			var result;

			try {
				result = parse("component { function foo(){} }");
			} catch(e) {
				result = result || false;
			}

			assert.equal(true, result);

		});

		it("should allow component-metadata", function(){

			var result;

			try {
				result = parse("component foo='bar' {}");
			} catch(e) {
				result = result || false;
			}

			assert.equal(true, result);

		});

		it("should not allow component-metadata with colons", function(){

			var result;

			try {
				result = parse("component foo:baz='bar' {}");
			} catch(e) {
				result = result || true;
			}

			assert.equal(result, false);

		});

	});

});
