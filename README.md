
<img src="https://img.shields.io/badge/Xcode-11.5-blue.svg?style=flat"> <img src="https://img.shields.io/badge/swift-5-orange.svg?style=flat">

<img src="Images/logo.jpg">

# Marvel Characters

Este projeto foi desenvolvido em Swift e tem como objetivo apresentar a lista de personagens da Marvel em um app para iOS.

-  [Começando](#começando)
	-  [Pré-requisito](#pré-requisito)
-  [Guia de instalação](#guia-de-instalação)
	-  [Xcode](#xcode)
	-  [Homebrew](#homebrew)
	    - [SwiftGen](#swiftgen)
	    - [SwiftLint](#swiftlint)
    -  [CocoaPods](#cocoapods)
-  [Clonando o repositório](#clonando-o-repositório)
-  [Testes](#testes)
-  [Bibliotecas utilizadas](#bibliotescas-utilizadas)
-  [Light e Dark Mode](#light-e-dark-mode)
-  [Funcionalidades](#funcionalidades)

## Começando
As instruções a seguir irão fornecer a você uma cópia do projeto e possibilitar a execução do mesmo em seu computador.

### Pré-requisito
- Computador com macOS Catalina 10.15.2 ou superior

## Guia de instalação
Instale as ferramentas abaixo para poder executar o app no Xcode.

### Xcode
Baixe o Xcode na [App Store](https://apps.apple.com/br/app/xcode/id497799835?mt=12).

### Homebrew
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

### CocoaPods
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

# Informações complementares

## Testes
O projeto possui testes automátizados, para os testes de UI e funcional foi utilizado o simulador do **Phone SE (2nd generation)** com **iOS 13.5**. Outros simuladores com a mesma proporção de tela podem funcionar.

## Bibliotescas utilizadas
Instalação via Pod:
- Nimble-Snapshots  (Testes de UI)
- KIF  (Testes instrumentados e funcional	)
- KIF/IdentifierTests  (Testes instrumentados e funcional)

Instalação via Swift Package Manager:
- Kingfisher  (Download de imagens)

## Light e Dark Mode
O app é adaptável ao tema do sistema operacional.

<img src="Images/light-mode.png" width="250"> <img src="Images/dark-mode.png" width="250">

## Funcionalidades
- Lista de personagens
- Detalhe do personagem
- Pesquisa de personagem
- Lista de favoritos

<img src="Images/screen-character-list.png" width="200"> <img src="Images/screen-detail.png" width="200"> <img src="Images/screen-search-character.png" width="200"> <img src="Images/screen-favorites-empty-state.png" width="200">
