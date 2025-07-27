flutter build ios --flavor dev
cd ./build/ios/iphoneos || exit
mkdir -p Payload
mv Runner.app Payload
zip -r -y Payload.zip Payload/Runner.app
mv Payload.zip app-release.ipa
rm -Rf Payload
open .