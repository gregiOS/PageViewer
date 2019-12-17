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
    @State var pages: [PageViewData] = [
        PageViewData(imageNamed: "image1"),
        PageViewData(imageNamed: "image2"),
        PageViewData(imageNamed: "image3")
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(alignment: .center, spacing: 0) {
                        ForEach(self.pages) { viewData in
                            PageView(viewData: viewData)
                                .frame(width: geometry.size.width,
                                       height: geometry.size.height)
                        }
                    }
                }
                .content
                .offset(x: self.offset)
                .frame(width: geometry.size.width, alignment: .leading)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            self.offset = value.translation.width + -geometry.size.width * CGFloat(self.index)
                        })
                        .onEnded({ value in
                            var offset = CGFloat(self.index) * -geometry.size.width
                            if value.predictedEndTranslation.width < geometry.size.width / 2, self.index < self.pages.count - 1 {
                                self.index += 1
                                offset = CGFloat(self.index) * -geometry.size.width
                            }
                            if value.predictedEndTranslation.width > geometry.size.width / 2, self.index > 0 {
                                self.index -= 1
                                offset = CGFloat(self.index) * -geometry.size.width
                            }
                            withAnimation {
                                self.offset = offset
                            }
                        })
                )
                HStack(spacing: 8) {
                    ForEach(0..<self.pages.count) { index in
                        DottedButton(index: index, selectedIndex: self.$index)
                    }
                }
                .padding(.bottom, 12)
            }
        }
    }
}

struct PageViewData: Identifiable {
    let id: String = UUID().uuidString
    let imageNamed: String
}

struct PageView: View {
    let viewData: PageViewData
    var body: some View {
        Image(viewData.imageNamed)
            .resizable()
            .clipped()
    }
}


struct DottedButton: View {
    let index: Int
    @Binding var selectedIndex: Int
    
    var body: some View {
        Button(action: {
            print("Button tapped")
        }) {
            Circle()
                .foregroundColor(self.selectedIndex == index ? Color.white : Color.white.opacity(0.5))
                .frame(width: 12, height: 12)
            
        }
    }
}
