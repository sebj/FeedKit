//
//  AtomFeedGenerator.swift
//
//  Copyright (c) 2016 - 2024 Nuno Dias
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

/// The "atom:generator" element's content identifies the agent used to
/// generate a feed, for debugging and other purposes.
///
/// The content of this element, when present, MUST be a string that is a
/// human-readable name for the generating agent.  Entities such as
/// "&amp;" and "&lt;" represent their corresponding characters ("&" and
/// "<" respectively), not markup.
///
/// The atom:generator element MAY have a "uri" attribute whose value
/// MUST be an IRI reference [RFC3987].  When dereferenced, the resulting
/// URI (mapped from an IRI, if necessary) SHOULD produce a
/// representation that is relevant to that agent.
///
/// The atom:generator element MAY have a "version" attribute that
/// indicates the version of the generating agent.
public struct AtomFeedGenerator {
  /// The element's text.
  public var text: String?

  /// The element's attributes.
  public struct Attributes: Codable, Equatable {
    /// The atom:generator element MAY have a "uri" attribute whose value
    /// MUST be an IRI reference [RFC3987].  When dereferenced, the resulting
    /// URI (mapped from an IRI, if necessary) SHOULD produce a
    /// representation that is relevant to that agent.
    public var uri: String?

    /// The atom:generator element MAY have a "version" attribute that
    /// indicates the version of the generating agent.
    public var version: String?

    public init(
      uri: String? = nil,
      version: String? = nil) {
      self.uri = uri
      self.version = version
    }
  }

  /// The element's attributes.
  public var attributes: Attributes?

  public init(
    text: String? = nil,
    attributes: Attributes? = nil) {
    self.text = text
    self.attributes = attributes
  }
}

// MARK: - Equatable

extension AtomFeedGenerator: Equatable {}

// MARK: - Codable

extension AtomFeedGenerator: Codable {
  private enum CodingKeys: CodingKey {
    case text
    case attributes
  }

  public init(from decoder: any Decoder) throws {
    let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)

    text = try container.decodeIfPresent(String.self, forKey: CodingKeys.text)
    attributes = try container.decodeIfPresent(AtomFeedGenerator.Attributes.self, forKey: CodingKeys.attributes)
  }

  public func encode(to encoder: any Encoder) throws {
    var container: KeyedEncodingContainer<CodingKeys> = encoder.container(keyedBy: CodingKeys.self)

    try container.encodeIfPresent(text, forKey: CodingKeys.text)
    try container.encodeIfPresent(attributes, forKey: CodingKeys.attributes)
  }
}
