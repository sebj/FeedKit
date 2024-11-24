//
//  AtomFeedContent.swift
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

/// The "atom:content" element either contains or links to the content of
/// the entry.  The content of atom:content is Language-Sensitive.
public struct AtomFeedContent {
  /// The element's text.
  public var text: String?

  /// The element's attributes.
  public struct Attributes: Codable, Equatable {
    /// On the atom:content element, the value of the "type" attribute MAY be
    /// one of "text", "html", or "xhtml".  Failing that, it MUST conform to
    /// the syntax of a MIME media type, but MUST NOT be a composite type
    /// (see Section 4.2.6 of [MIMEREG]).  If neither the type attribute nor
    /// the src attribute is provided, Atom Processors MUST behave as though
    /// the type attribute were present with a value of "text".
    public var type: String?

    /// The atom:content MAY have a "src" attribute, whose value MUST be an IRI
    /// reference [RFC3987].  If the "src" attribute is present, atom:content
    /// MUST be empty.  Atom Processors MAY use the IRI to retrieve the
    /// content and MAY choose to ignore remote content or to present it in a
    /// different manner than local content.
    ///
    /// If the "src" attribute is present, the "type" attribute SHOULD be
    /// provided and MUST be a MIME media type [MIMEREG], rather than "text",
    /// "html", or "xhtml".  The value is advisory; that is to say, when the
    /// corresponding URI (mapped from an IRI, if necessary) is dereferenced,
    /// if the server providing that content also provides a media type, the
    /// server-provided media type is authoritative.
    public var src: String?

    public init(
      type: String? = nil,
      src: String? = nil) {
      self.type = type
      self.src = src
    }
  }

  /// The element's attributes.
  public var attributes: Attributes?

  public init(
    text: String? = nil,
    attributes: AtomFeedContent.Attributes? = nil) {
    self.text = text
    self.attributes = attributes
  }
}

// MARK: - Equatable

extension AtomFeedContent: Equatable {}

// MARK: - Codable

extension AtomFeedContent: Codable {
  private enum CodingKeys: CodingKey {
    case text
    case attributes
  }

  public init(from decoder: any Decoder) throws {
    let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)

    text = try container.decodeIfPresent(String.self, forKey: CodingKeys.text)
    attributes = try container.decodeIfPresent(AtomFeedContent.Attributes.self, forKey: CodingKeys.attributes)
  }

  public func encode(to encoder: any Encoder) throws {
    var container: KeyedEncodingContainer<CodingKeys> = encoder.container(keyedBy: CodingKeys.self)

    try container.encodeIfPresent(text, forKey: CodingKeys.text)
    try container.encodeIfPresent(attributes, forKey: CodingKeys.attributes)
  }
}
