//
//  TruncableText.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 17/09/2023.
//

import SwiftUI

struct TruncableText: View {
  let text: Text
  let lineLimit: Int?
  @State private var intrinsicSize: CGSize = .zero
  @State private var truncatedSize: CGSize = .zero
  let isTruncatedUpdate: (_ isTruncated: Bool) -> Void

  var body: some View {
    text
      .lineLimit(lineLimit)
      .readSize { size in
        truncatedSize = size
        isTruncatedUpdate(truncatedSize != intrinsicSize)
      }
      .background(
        text
          .fixedSize(horizontal: false, vertical: true)
          .hidden()
          .readSize { size in
            intrinsicSize = size
            isTruncatedUpdate(truncatedSize != intrinsicSize)
          }
      )
  }
    
}
extension View {
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
  
  @ViewBuilder func isShow(_ show: Bool) -> some View {
    if show {
      self
    } else {
      self.hidden()
    }
  }
}

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

//struct TruncableText_Previews: PreviewProvider {
//    static var previews: some View {
//        TruncableText(text: Text(""), lineLimit: 2, isTruncatedUpdate: Void(Bool: true))
//    }
//}
