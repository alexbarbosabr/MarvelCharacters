// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// close
  internal static let close = L10n.tr("Localizable", "close")
  /// tryAgain
  internal static let tryAgain = L10n.tr("Localizable", "tryAgain")

  internal enum CharacterDetail {
    /// About:
    internal static let about = L10n.tr("Localizable", "characterDetail.about")
  }

  internal enum CharacterList {
    /// No characters found.
    internal static let noCharactersFound = L10n.tr("Localizable", "characterList.noCharactersFound")
    /// MARVEL
    internal static let title = L10n.tr("Localizable", "characterList.title")
    internal enum Error {
      /// Something went wrong!
      /// Touch to try again.
      internal static let tryAgain = L10n.tr("Localizable", "characterList.error.tryAgain")
    }
    internal enum SearchBar {
      /// search for characters
      internal static let placeholder = L10n.tr("Localizable", "characterList.searchBar.placeholder")
    }
  }

  internal enum FavoriteCharacters {
    /// Favorites
    internal static let title = L10n.tr("Localizable", "favoriteCharacters.title")
    internal enum Message {
      /// You don't have favorite characters
      internal static let empty = L10n.tr("Localizable", "favoriteCharacters.message.empty")
    }
  }

  internal enum Message {
    /// Oops! Something went wrong.
    internal static let generic = L10n.tr("Localizable", "message.generic")
    /// No internet connection.
    internal static let noInternet = L10n.tr("Localizable", "message.noInternet")
    /// Character not found.
    internal static let notfound = L10n.tr("Localizable", "message.notfound")
    internal enum Error {
      /// Error! The character could not be removed.
      internal static let removeFavorite = L10n.tr("Localizable", "message.error.removeFavorite")
      /// Error! The character cannot be saved as a favorite
      internal static let setAsFavorite = L10n.tr("Localizable", "message.error.setAsFavorite")
    }
    internal enum Title {
      /// Oops!
      internal static let generic = L10n.tr("Localizable", "message.title.generic")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
