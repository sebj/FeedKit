//
// XMLUnkeyedDecodingContainer.swift
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

class XMLUnkeyedDecodingContainer: UnkeyedDecodingContainer {
  // MARK: Lifecycle

  /// Initializes the container for decoding an unkeyed XML element.
  /// - Parameters:
  ///   - decoder: The XML decoder used for decoding.
  ///   - element: The XML element representing the unkeyed container.
  init(decoder: _XMLDecoder, node: XMLNode) {
    self.decoder = decoder
    if let parent = node.parent {
      decoder.stack.pop()
      decoder.stack.push(parent)
      nodes = parent.children?.filter {
        $0.name == decoder.codingPath.last!.stringValue
      } ?? []
    } else {
      nodes = []
    }
  }

  // MARK: Internal

  /// The XML decoder used for decoding the current node.
  var decoder: _XMLDecoder
  /// The XML nodes being decoded.
  var nodes: [XMLNode]
  /// The current index in the container's nodes.
  var currentIndex: Int = 0

  /// The current XML node being decoded.
  var node: XMLNode { nodes[currentIndex] }
  /// The coding path of the current decoding process.
  var codingPath: [CodingKey] { decoder.codingPath }
  /// The number of nodes in the container, or `nil` if unknown.
  var count: Int? { nodes.count }
  /// A Boolean value indicating whether the container has reached the end.
  var isAtEnd: Bool { currentIndex >= count ?? 0 }

  // MARK: - Decode

  func decodeNil() throws -> Bool {
    fatalError()
  }

  func decode(_: Bool.Type) throws -> Bool {
    fatalError()
  }

  func decode(_ type: String.Type) throws -> String { try decoder.decode(node, as: type) }

  // MARK: - Floating point

  func decode(_ type: Float.Type) throws -> Float { try decoder.decode(node, as: type) }
  func decode(_ type: Double.Type) throws -> Double { try decoder.decode(node, as: type) }

  // MARK: - Int

  func decode(_ type: Int.Type) throws -> Int { try decoder.decode(node, as: type) }
  func decode(_ type: Int8.Type) throws -> Int8 { try decoder.decode(node, as: type) }
  func decode(_ type: Int16.Type) throws -> Int16 { try decoder.decode(node, as: type) }
  func decode(_ type: Int32.Type) throws -> Int32 { try decoder.decode(node, as: type) }
  func decode(_ type: Int64.Type) throws -> Int64 { try decoder.decode(node, as: type) }

  // MARK: - Int

  func decode(_ type: UInt.Type) throws -> UInt { try decoder.decode(node, as: type) }
  func decode(_ type: UInt8.Type) throws -> UInt8 { try decoder.decode(node, as: type) }
  func decode(_ type: UInt16.Type) throws -> UInt16 { try decoder.decode(node, as: type) }
  func decode(_ type: UInt32.Type) throws -> UInt32 { try decoder.decode(node, as: type) }
  func decode(_ type: UInt64.Type) throws -> UInt64 { try decoder.decode(node, as: type) }

  // MARK: - Type

  func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
    // Ensure we have not reached the end of the children array
    guard !isAtEnd else {
      throw DecodingError.valueNotFound(T.self, .init(
        codingPath: codingPath,
        debugDescription: "Unkeyed container is at end."
      ))
    }

    // Get the current child element for decoding
    let node = nodes[currentIndex]
    let value = try decoder.decode(node: node, as: type)
    // Advance the index for the next decode call
    currentIndex += 1
    return value
  }

  // MARK: -

  func nestedContainer<NestedKey>(keyedBy _: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
    fatalError()
  }

  func nestedUnkeyedContainer() throws -> any UnkeyedDecodingContainer {
    fatalError()
  }

  func superDecoder() throws -> any Decoder {
    fatalError()
  }
}
