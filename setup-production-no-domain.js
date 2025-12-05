#!/usr/bin/env node

/**
 * pewa.mkopaje.com Production Setup (NO DOMAIN REQUIRED)
 * Use pewa.mkopaje.com for callback testing
 */

console.log('🚀 pewa.mkopaje.com - Production Setup (No Domain Required)');
console.log('====================================================\n');

console.log('📋 PRODUCTION SETUP FOR pewa.mkopaje.com:');
console.log('=====================================\n');

console.log('1. 🔑 GET PRODUCTION CREDENTIALS:');
console.log('   - Visit: https://developer.safaricom.co.ke/');
console.log('   - Create PRODUCTION app (not sandbox)');
console.log('   - Get: Consumer Key, Secret, Business Code, Passkey\n');

console.log('2. 🌐 SETUP CALLBACK URLs:');
console.log('   - Use: https://pewa.mkopaje.com/api/mpesa-callback for all M-Pesa callbacks\n');

console.log('3. ⚙️ CONFIGURE ENVIRONMENT:');
console.log('   - Copy .env.production.no-domain to .env');
console.log('   - Replace placeholder values with your real credentials');
console.log('   - Update callback URLs with https://pewa.mkopaje.com/api/mpesa-callback\n');

console.log('4. 🧪 TEST PRODUCTION:');
console.log('   - Start with KES 1-10 amounts');
console.log('   - Watch pewa.mkopaje.com for M-Pesa callbacks');
console.log('   - Verify payments work correctly\n');

console.log('📝 CONFIGURATION TEMPLATE:');
console.log('==========================');
console.log(`
# Production M-Pesa Configuration (No Domain)
MPESA_CONSUMER_KEY=your_production_consumer_key
MPESA_CONSUMER_SECRET=your_production_consumer_secret
MPESA_BUSINESS_SHORTCODE=your_till_number
MPESA_PASSKEY=your_production_passkey

# Webhook.site URLs (replace with your unique URL)
MPESA_CALLBACK_URL=https://webhook.site/your-unique-id
MPESA_TIMEOUT_URL=https://webhook.site/your-unique-id
MPESA_RESULT_URL=https://webhook.site/your-unique-id

MPESA_ENVIRONMENT=production
`);

console.log('🔧 QUICK COMMANDS:');
console.log('==================');
console.log('# Copy template:');
console.log('cp .env.production.no-domain .env');
console.log('');
console.log('# Edit configuration:');
console.log('notepad .env');
console.log('');
console.log('# Start server:');
console.log('node backend/server.js');
console.log('');

console.log('💡 CALLBACK URL:');
console.log('========================');
console.log('- https://pewa.mkopaje.com/api/mpesa-callback (Production)');
console.log('');

console.log('⚠️ IMPORTANT NOTES:');
console.log('===================');
console.log('- Use pewa.mkopaje.com for production deployment');
console.log('- Start with small amounts (KES 1-10)');
console.log('- Monitor all transactions carefully');
console.log('');

console.log('📞 SAFARICOM SUPPORT:');
console.log('=====================');
console.log('- Technical: +254 722 000 000');
console.log('- Portal: https://developer.safaricom.co.ke/');
console.log('');

console.log('✅ Ready to test production M-Pesa without a domain!');
console.log('🔗 Start at: https://webhook.site/');