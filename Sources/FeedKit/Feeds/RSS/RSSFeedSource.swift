//
// RSSFeedSource.swift
//
// Copyright (c) 2016 - 2025 Nuno Dias
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation
import XMLKit

public struct RSSFeedSourceAttributes: Codable, Equatable, Hashable, Sendable {
  // MARK: Lifecycle

  public init(url: String? = nil) {
    self.url = url
  }

  // MARK: Public

  /// Required attribute of the `Source` element, which links to the
  /// XMLization of the source. e.g. "http://www.tomalak.org/links2.xml"
  public var url: String?
}

/// The RSS channel that the item came from.
///
/// <source> is an optional sub-element of <item>.
///
/// Its value is the name of the RSS channel that the item came from, derived
/// from its <title>. It has one required attribute, url, which links to the
/// XMLization of the source.
///
/// <source url="http://www.tomalak.org/links2.xml">Tomalak's Realm</source>
///
/// The purpose of this element is to propagate credit for links, to
/// publicize the sources of news items. It can be used in the Post command
/// of an aggregator. It should be generated automatically when forwarding
/// an item from an aggregator to a weblog authoring tool.
public typealias RSSFeedSource = XMLKit.XMLElement<RSSFeedSourceAttributes>
