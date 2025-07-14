#!/usr/bin/env node

/**
 * Simple test file for the act demo application
 */

const { greet, add, multiply } = require('./index.js');

function runTests() {
    let passed = 0;
    let failed = 0;
    
    console.log('🧪 Running tests...\n');
    
    // Test greet function
    try {
        const result = greet('Test');
        if (result === 'Hello, Test!') {
            console.log('✅ greet() test passed');
            passed++;
        } else {
            console.log(`❌ greet() test failed: expected "Hello, Test!", got "${result}"`);
            failed++;
        }
    } catch (error) {
        console.log(`❌ greet() test failed with error: ${error.message}`);
        failed++;
    }
    
    // Test add function
    try {
        const result = add(2, 3);
        if (result === 5) {
            console.log('✅ add() test passed');
            passed++;
        } else {
            console.log(`❌ add() test failed: expected 5, got ${result}`);
            failed++;
        }
    } catch (error) {
        console.log(`❌ add() test failed with error: ${error.message}`);
        failed++;
    }
    
    // Test multiply function
    try {
        const result = multiply(4, 5);
        if (result === 20) {
            console.log('✅ multiply() test passed');
            passed++;
        } else {
            console.log(`❌ multiply() test failed: expected 20, got ${result}`);
            failed++;
        }
    } catch (error) {
        console.log(`❌ multiply() test failed with error: ${error.message}`);
        failed++;
    }
    
    // Test summary
    console.log(`\n📊 Test Results:`);
    console.log(`   Passed: ${passed}`);
    console.log(`   Failed: ${failed}`);
    console.log(`   Total:  ${passed + failed}`);
    
    if (failed > 0) {
        console.log('\n❌ Tests failed!');
        process.exit(1);
    } else {
        console.log('\n✅ All tests passed!');
        process.exit(0);
    }
}

if (require.main === module) {
    runTests();
}
