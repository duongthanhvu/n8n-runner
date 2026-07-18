const fs = require('fs');

// Read the existing package.json
const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));

// Safely ensure the pnpm object exists, then add the whitelist
pkg.pnpm = pkg.pnpm || {};
pkg.pnpm.onlyBuiltDependencies = ['better-sqlite3'];

// Write the changes back to the file cleanly formatted
fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2));
