import Foundation

/// Looks up a localized string in `Localizable.xcstrings`, returning `key` verbatim when no translation exists.
nonisolated func L(_ key: String) -> String {
    Bundle.main.localizedString(forKey: key, value: key, table: nil)
}

/// Formats a localized string template from `Localizable.xcstrings` with `CVarArg` arguments.
nonisolated func L(_ key: String, _ args: CVarArg...) -> String {
    let format = Bundle.main.localizedString(forKey: key, value: key, table: nil)
    return String(format: format, locale: .current, arguments: args)
}

extension RawRepresentable where RawValue == String {
    /// Localized display label for string-backed UI enums without altering their persisted `rawValue`.
    nonisolated var localizedName: String { L(rawValue) }
}
