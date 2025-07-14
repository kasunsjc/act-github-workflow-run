#!/usr/bin/env node

/**
 * Simple demo application for act (GitHub Actions local runner)
 */

function greet(name = 'World') {
    return `Hello, ${name}!`;
}

function add(a, b) {
    return a + b;
}

function multiply(a, b) {
    return a * b;
}

// Main execution
if (require.main === module) {
    console.log('🚀 Act Demo Application Started');
    console.log(greet('GitHub Actions'));
    console.log(`Environment: ${process.env.NODE_ENV || 'development'}`);
    console.log(`App Name: ${process.env.APP_NAME || 'act-demo'}`);
    
    // Simple calculations
    console.log(`2 + 3 = ${add(2, 3)}`);
    console.log(`4 * 5 = ${multiply(4, 5)}`);
    
    console.log('✅ Application completed successfully');
}

module.exports = {
    greet,
    add,
    multiply
};
