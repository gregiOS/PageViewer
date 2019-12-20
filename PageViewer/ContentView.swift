//
//  ContentView.swift
//  PageViewer
//
//  Created by Grzegorz Przybyła on 10/12/2019.
//  Copyright © 2019 Grzegorz Przybyła. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var index: Int = 0
    @State var offset: CGFloat = 0
    
    let pages: [PageViewData] = [
        PageViewData(imageNamed: "image1"),
        PageViewData(imageNamed: "image2"),
        PageViewData(imageNamed: "image3")
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            SwiperView(index: self.$index, pages: self.pages)
            HStack(spacing: 8) {
                ForEach(0..<self.pages.count) { index in
                    DottedButton(isSelected: Binding<Bool>(get: { self.index == index }, set: { _ in })) {
                        withAnimation {
                            self.index = index
                        }
                    }
                }
            }
            .padding(.bottom, 12)
        }
    }
    
    
}

