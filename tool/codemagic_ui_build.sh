#!/usr/bin/env bash
# Cole ESTE script no Codemagic (workflow visual Step ~6 Build) SE continuar Step 9 errado.
# Ou use codemagic.yaml do repo (7 passos, nao 9).
set -euo pipefail
echo "=== IC24 UI BUILD SCRIPT — alvo CFBundleVersion 58 ==="
git rev-parse HEAD
git log -1 --oneline
test -f ios/IC24_IOS_BUILD.txt && cat ios/IC24_IOS_BUILD.txt
grep CFBundleVersion ios/Runner/Info.plist
rm -rf build/ios build/ios/ipa build/ios/archive .dart_tool
flutter clean
flutter pub get
cd ios && pod install && cd ..
flutter build ipa --release --build-name=2.0.0 --build-number=58 \
  --export-options-plist=ios/codemagic_signing/ExportOptions.plist
IPA=$(find build/ios/ipa -name '*.ipa' | head -1)
BUILD_NUM=$(unzip -p "$IPA" 'Payload/Runner.app/Info.plist' | plutil -extract CFBundleVersion raw)
echo "IPA CFBundleVersion=$BUILD_NUM"
if [ "$BUILD_NUM" -le 53 ]; then
  echo "ERRO: IPA ainda build $BUILD_NUM — pare, nao faca upload"
  exit 1
fi
echo "OK build $BUILD_NUM — pode subir TestFlight"
