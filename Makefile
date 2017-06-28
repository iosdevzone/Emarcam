# Make the documents for Xcode 9 + Swift 4. Make sure xcode-select is pointing
# to the correct version!
doc4:
	jazzy -x -project,Emarcam_Swift_4.xcodeproj
doc3:
	jazzy -x -project,Emarcam_Swift_3.xcodeproj

codecov:
	swift package generate-xcodeproj --enable-code-coverage
	xcodebuild -project Emarcam_Swift_3.xcodeproj -scheme Emarcam -enableCodeCoverage YES test

spec_lint:
	pod spec lint

trunk_push:
	pod trunk push Emarcam.podspec

test_swift_4:
	sudo xcode-select -s /Applications/Xcode-beta.app
	xcrun swift --version
	xcodebuild -project Emarcam_Swift_4.xcodeproj -scheme Emarcam test | xcpretty

test_swift_3:
	sudo xcode-select -s /Applications/Xcode.app
	xcrun swift --version
	xcodebuild -project Emarcam_Swift_3.xcodeproj -scheme Emarcam -destination 'platform=OS X,arch=x86_64' test | xcpretty

# Convenience target to generate list of all tests for Linux
tests_list:
	grep 'func test' Tests/EmarcamTests/EmarcamTests.swift | awk '{ print $$2; }' | sed 's/()//' | awk '{ print "(\""$$1"\", "$$1"), "}'
