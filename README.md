# Marvel Characters

Este projeto foi desenvolvido em Swift e tem como objetivo apresentar a lista de personagens da Marvel em um app para iOS.

-  [Começando](#começando)
	-  [Pré-requisito](#pré-requisito)
-  [Guia de instalação](#guia-de-instalação)
	-  [1. Xcode](#xcode)
	-  [2. Homebrew](#homebrew)
	    - [SwiftGen](#swiftgen)
	    - [SwiftLint](#swiftlint)
    -  [3. CocoaPods](#cocoapods)
-  [Clonando o repositório](#clonando-o-repositório)

## Começando
As instruções a seguir irão fornecer a você uma cópia do projeto e possibilitar a execução do mesmo em seu computador.

### Pré-requisito
- Computador com macOS Catalina 10.15.4 ou superior

## Guia de instalação
Instale as ferramentas abaixo para poder executar o app no Xcode.

### 1. Xcode
Baixe o Xcode na [App Store](https://apps.apple.com/br/app/xcode/id497799835?mt=12).

### 2. Homebrew
Siga as instruções de instalação no site [brew](https://brew.sh/index_pt-br) ou execute o comando abaixo no terminal do Mac:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

### SwiftGen
No **terminal** execute:
```
brew install swiftgen
```

### SwiftLint
No **terminal** execute:
```
brew install swiftlint
```

### 3. CocoaPods
No **terminal** execute:
```
sudo gem install cocoapods
```
Ao fim da instalação do comando acima, execute no **terminal**:
```
pod install
```

## Clonando o repositório
No **terminal**, abra o diretório de sua preferência e execute a linha de comando abaixo para clonar o repositório.
```
git clone https://github.com/alexbarbosabr/MarvelCharacters.git
```
Após clonar o repositório abra o arquivo **.xcodeproj**.
