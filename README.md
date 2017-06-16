# Emarcam
## Getting started
Assuming you have integrated `Emarcam` into your project using your preferred method (CococaPods, Carthage, Swift Package Manager or manually), just import the module at the top of your file.

````swift
import Emarcam
````

## Subscripting
`Emarcam` greatly simplifies subscripting strings by allowing you to use `Int`s as indices. For example:
````swift
let str = "Hello, playground!"
str[0] // "H"
str[1] // "e"
str[0..<4] // "Hell"
str[0...4] // "Hello"
str[6..<str.count] // " playground!"
````
Compare this to the same expressions in Swift 4.
````swift
str[str.startIndex]
str[str.index(after: str.startIndex)]
str[str.startIndex..<str.index(str.startIndex, offsetBy:4)]
str[str.startIndex...str.index(str.startIndex, offsetBy:4)]
str[str.index(str.startIndex, offsetBy:6)..<str.endIndex]
````
## Replacing Substrings
The same simplified integer ranges can be used in the replacement methods. Here the Kanji '休' is replaced with its pronunciation 'やす'.
````swift
var ms0 = "お休みなさい"
let hiragana: [Character] = [ "や", "す" ]
ms0.replaceSubrange(1..<2, with: hiragana)
// おやすみなさい
````
## Removing Substrings
Removal of substrings is also a happier experience.
````swift
var ms1 = "😭☠️☠️😀💀😀☠️☠️😡"
ms1.removeSubrange(0...2)          // ms1 = "😀💀😀☠️☠️😡"
ms1.remove(at: 1)                  // returns '💀' and ms1 = "😀😀☠️☠️😡"
ms1.removeSubrange(2..<ms1.count)  // ms1 = ""😀😀"
````
