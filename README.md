<img width="1156" alt="1" src="https://github.com/KarimMakki/shoppingapp/assets/91680756/c1d59e78-569e-4620-a2eb-1870371c4562">
<img width="1156" alt="2" src="https://github.com/KarimMakki/shoppingapp/assets/91680756/cf8a3151-229b-4982-bfce-7e6a5b0d027a">
<img width="1156" alt="3" src="https://github.com/KarimMakki/shoppingapp/assets/91680756/b33fa3ea-8183-4845-96f5-ae38ec50feb2">

# **Shopping App**

# **Overview**

The shopping app is a flutter mobile application that presents a user-friendly interface where customers can browse through a variety of products effortlessly. Products are fetched from your WooCommerce backend API and Firestore database serves as the backbone for storing and managing user-specific data such as wishlist items and items added to the shopping cart, the app utilizes the Provider package for efficient state management across various components and uses Hive for saving the current user model in local data

## **Features**

1. Browse through the different categories and add your favourite products to cart.

2. Add any product to your wishlist and check them at your wishlist page.

3. Login or register by Google, Phone OTP or email to save all your user data (cart,wishlist,addresses) to your account.

4. Ability to add multiple addresses to use for checkout.

5. Check for all the available Coupons and claim them for discounts.



# **Getting Started**

### **1. Setup the Firebase App**
1. You’ll need to create a Firebase instance. Follow the instructions at https://console.firebase.google.com.
2. Once your Firebase instance is created, you’ll need to enable all the authentication methods.
3. Go to the Firebase Console for your new instance.
4. Click “Authentication” in the left-hand menu
5. Click the “sign-in method” tab
6. Click “Google” and enable it
7. Click "Phone" and enable it
8. Click "Email" and enable it

### **2. Enable the Firestore Database**
1. Navigate to the [Firebase Console](https://console.firebase.google.com/).
2. Select your Firebase project.
3. Go to the "Database" section.
4. Choose Firestore as your database.
5.  Setting Up Security Rules (Optional): You can set up security rules to control access to your Firestore database. Learn more about Firestore security rules [here](https://firebase.google.com/docs/firestore/security/get-started).

### **3. (skip if not running on Android)**
1. Create an app within your Firebase instance for Android, with package name com.yourcompany.news
2. Run the following command to get your SHA-1 key:  keytool -exportcert -list -v \-alias androiddebugkey -keystore ~/.android/debug.keystore
3. In the Firebase console, in the settings of your Android app, add your SHA-1 key by clicking “Add Fingerprint”.
4. Download  google-services.json and place it into /android/app/.

   
### **4. (skip if not running on iOS)**
1. Create an app within your Firebase instance for iOS, with your app package name
2. Download GoogleService-Info.plist
3. Open XCode, right click the Runner folder, select the “Add Files to ‘Runner'” menu, and select the GoogleService-Info.plist file to add it to /ios/Runner in XCode
4. Open /ios/Runner/Info.plist in a text editor. Locate the CFBundleURLSchemes key. The second item in the array value of this key is specific to the Firebase instance. Replace it with the value for REVERSED_CLIENT_ID from GoogleService-Info.plist


### **5. Setting up Environment Variables**
1. Rename .env.example file to .env.
2. Add your firebase project apiKey and appId
