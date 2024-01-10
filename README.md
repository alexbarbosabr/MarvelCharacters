
<img src="https://img.shields.io/badge/Xcode-14.3-blue.svg?style=flat"> <img src="https://img.shields.io/badge/swift-5-orange.svg?style=flat">

<img src="Images/logo.jpg">

# Marvel Characters

This project was developed in Swift with UIKit and aims to present the Marvel characters in an iOS app.

## Light e Dark Mode
The app is adaptable to the theme of the operating system.

<img src="Images/light-mode.png" width="250"> <img src="Images/dark-mode.png" width="250">

## Features
- Character list
- Character details
- Character search
- Favorite list

<img src="Images/screen-character-list.png" width="200"> <img src="Images/screen-detail.png" width="200"> <img src="Images/screen-search-character.png" width="200"> <img src="Images/screen-favorites-empty-state.png" width="200">

### Menu
-  [Starting](#starting)
	-  [Prerequisites](#prerequisites)
-  [Installation guide](#installation-guide)
	-  [Xcode](#xcode)
	-  [Homebrew](#homebrew)
	    - [SwiftGen](#swiftgen)
	    - [SwiftLint](#swiftlint)
    -  [CocoaPods](#cocoapods)
-  [Cloning the reposito](#cloning-the-reposito)
-  [Tests](#tests)
-  [Libraries used](#libraries-used)

## Starting
The following instructions will provide you with a copy of the project and allow you to run it on your computer.

### Prerequisites
- Computer with macOS Ventura 13 or higher

## Installation guide
Install the tools below to be able to run the app in Xcode.

### Xcode
Download Xcode from [App Store](https://apps.apple.com/br/app/xcode/id497799835).

### Homebrew
Follow the installation instructions on the website [brew](https://brew.sh/index_pt-br) or run the command below in the terminal:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

> Note: For Mac with **Apple Silicon** processor, you will need to run the command below in the terminal.
> 1. echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/<span style="color: red">YOUR USER</span>/.zprofile



### SwiftGen
In **terminal** run:
```
brew install swiftgen
```

### SwiftLint
In **terminal** run:
```
brew install swiftlint
```

### CocoaPods
In **terminal** run:
```
sudo gem install cocoapods
```

> Note: For Mac with **Apple Silicon** processor, you will need to run the commands below.
> 1. sudo arch -x86_64 gem install ffi
> 2. arch -x86_64 pod install

## Cloning the repository
In **terminal**, open the directory of your choice and run the command line below to clone the repository.
```
git clone https://github.com/alexbarbosabr/MarvelCharacters.git
```

At the end of the clone, open the root folder of the project in the terminal and execute the command:
```
pod install
```

After installing the Pods, open the **.xcworkspace** file located in the root folder of the project.

# Additional information

## Tests
The project has automated tests on MarvelCharactersTests and MarvelCharactersUITests targets.
For the MarvelCharactersTests snapshot tests, the **iPhone SE (3nd generation)** simulator with **iOS 16.4** was used. Other simulators with the same aspect ratio may work.

## Libraries used
Installation via CocoaPods:
- Nimble-Snapshots (UI Tests)
- KIF (Instrumented and Functional tests)
- KIF/IdentifierTests (Instrumented and functional tests)

Installation via Swift Package Manager:
- Kingfisher (Download images)