//
//  MediaStatistics.swift
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

/// This element specifies various statistics about a media object like the
/// view count and the favorite count. Valid attributes are views and favorites.
public struct MediaStatistics {
  /// The element's attributes.
  public struct Attributes: Codable, Equatable {
    /// The number of views.
    public var views: Int?

    /// The number fo favorites.
    public var favorites: Int?

    public init(
      views: Int? = nil,
      favorites: Int? = nil) {
      self.views = views
      self.favorites = favorites
    }
  }

  /// The element's attributes.
  public var attributes: Attributes?

  public init(attributes: Attributes? = nil) {
    self.attributes = attributes
  }
}

// MARK: - Equatable

extension MediaStatistics: Equatable {}

// MARK: - Codable

extension MediaStatistics: Codable {
  private enum CodingKeys: CodingKey {
    case attributes
  }

  public init(from decoder: any Decoder) throws {
    let container: KeyedDecodingContainer<MediaStatistics.CodingKeys> = try decoder.container(keyedBy: MediaStatistics.CodingKeys.self)

    attributes = try container.decodeIfPresent(MediaStatistics.Attributes.self, forKey: MediaStatistics.CodingKeys.attributes)
  }

  public func encode(to encoder: any Encoder) throws {
    var container: KeyedEncodingContainer<MediaStatistics.CodingKeys> = encoder.container(keyedBy: MediaStatistics.CodingKeys.self)

    try container.encodeIfPresent(attributes, forKey: MediaStatistics.CodingKeys.attributes)
  }
}
