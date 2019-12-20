//
//  PageView.swift
//  PageViewer
//
//  Created by Grzegorz Przybyła on 20/12/2019.
//  Copyright © 2019 Grzegorz Przybyła. All rights reserved.
//

import SwiftUI

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
