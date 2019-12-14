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
        PageViewData(imageNamed: "image1"),
        PageViewData(imageNamed: "image1")
    ]
    
    var body: some View {
        GeometryReader { geometry in
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
