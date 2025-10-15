keytool -genkey -v -keystore ./chuyentoadokey.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
Enter keystore password: `123456`
Keystore password is too short - must be at least 6 characters
Enter keystore password:  
Re-enter new password:
Enter the distinguished name. Provide a single dot (.) to leave a sub-component empty or press ENTER to use the default value in braces.
What is your first and last name?
[Unknown]: Spoon
What is the name of your organizational unit?
[Unknown]: DUT
What is the name of your organization?
[Unknown]: DUT
What is the name of your City or Locality?
[Unknown]: DN
What is the name of your State or Province?
[Unknown]: DN
What is the two-letter country code for this unit?
[Unknown]: VN
Is CN=Spoon, OU=DUT, O=DUT, L=DN, ST=DN, C=VN correct?
[no]: yes

Generating 2,048 bit RSA key pair and self-signed certificate (SHA384withRSA) with a validity of 10,000 days
for: CN=Spoon, OU=DUT, O=DUT, L=DN, ST=DN, C=VN
[Storing ./chuyentoadokey.jks]
