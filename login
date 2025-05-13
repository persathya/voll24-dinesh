

const { chromium } = require('playwright');  // Use playwright for browser automation

(async () => {
  // Launch the browser and create a new page
  const browser = await chromium.launch({ headless: false }); // Set to true if you don't want to see the browser
  const page = await browser.newPage();

  // Step 1: Navigate to the login page
  await page.goto('https://dashboard.stage.sdloki.in/login'); // Replace with your login URL

  // Step 2: Enter Mobile Number
  const mobileNumber = '8888888888'; // Replace with the actual number for testing
  
  await page.fill('input[class="rs-input rs-input-md"]', mobileNumber); // Adjust selector if necessary
  await page.click(type = 'button');
   try {
    // Wait for an error message to appear (adjust the selector based on actual page)
    const errorMessage = await page.waitForSelector('div.error-message', { timeout: 5000 });

    // If the error message contains "Number not registered", throw an error
    const errorText = await errorMessage.innerText();
    if (errorText.includes('Number not registered')) {
      throw new Error('Number is not registered');
    }
  } catch (error) {
    // If no error message appears, it means OTP request was successful, continue with OTP submission
    console.log('No registration error. Proceeding with OTP...');
  }

  const otp = '0000'; // Replace this with dynamic OTP retrieval (e.g., from your email or API)

  // Step 5: Enter OTP and submit
  await page.fill('input[type="password"]', otp); // Adjust OTP input selector
  await page.click('button'); // Adjust button selector

  await page.waitForSelector('div.dashboard', { timeout: 10000 }); 

  await browser.close();
})();
