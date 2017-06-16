# Make the documents for Xcode 9 + Swift 4. Make sure xcode-select is pointing
# to the correct version!
doc4:
	jazzy -x -project,Emarcam_Swift_4.xcodeproj
doc3:
	jazzy -x -project,Emarcam_Swift_3.xcodeproj

spec_lint:
	pod spec lint

trunk_push:
	pod trunk push Emarcam.podspec

