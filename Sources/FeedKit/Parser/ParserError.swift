//
//  ParserError.swift
//
//  Copyright (c) 2016 - 2018 Nuno Manuel Dias
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation


/// Error types with `NSError` codes and user info providers
///
/// - feedNotFound: Couldn't parse any known feed.
/// - feedCDATABlockEncodingError: Unable to convert the bytes in `CDATABlock` 
///   to Unicode characters using the UTF-8 encoding.
/// - internalError: An internal error from which the user cannot recover.
public enum ParserError: Equatable {
    case feedNotFound
    case feedCDATABlockEncodingError(path: String)
    case internalError(reason: String)
}

// MARK: - Error Descriptors

extension ParserError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .feedNotFound:
            return "Feed not found"
        case .feedCDATABlockEncodingError:
            return "`CDATAblock` encoding error"
        case .internalError(let reason):
            return "Internal unresolved error: \(reason)"
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .feedNotFound:
            return "Couldn't parse any known feed"
        case .feedCDATABlockEncodingError(let path):
            return "Unable to convert the bytes in `CDATABlock` to Unicode characters using the UTF-8 encoding at current path: \(path)"
        case .internalError(let reason):
            return "Unable to recover from an internal unresolved error: \(reason)"
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .feedNotFound:
            return "Provide a valid Atom/RSS/JSON feed "
        case .feedCDATABlockEncodingError:
            return "Make sure the encoding provided in a `CDATABlock` is encoded as UTF-8"
        case .internalError:
            return "If you're seeing this error you probably should open an issue on github"
        }
    }
    
}

// MARK: - NSError

extension ParserError {
    
    /// An error's code for the specified case.
    var code: Int {
        switch self {
        case .feedNotFound: return -1000
        case .feedCDATABlockEncodingError: return -10001
        case .internalError: return -90000
        }
    }
    
    /// The error's userInfo dictionary for the specified case.
    var userInfo: [String: String] {
        return [
            NSLocalizedDescriptionKey: errorDescription ?? "",
            NSLocalizedFailureReasonErrorKey: failureReason ?? "",
            NSLocalizedRecoverySuggestionErrorKey: recoverySuggestion ?? ""
        ]
    }
    
    /// The error's domain for the specified case.
    var domain: String {
        return "com.feedkit.error"
    }

    /// The `NSError` from the specified case.
    public var value: NSError {
        return NSError(domain: domain, code: code, userInfo: userInfo)
    }
    
}
