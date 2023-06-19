//
//  SheetListView.swift
//  SheetListUI
//
//  Created by Bosco Ho on 2023-06-19.
//

import SwiftUI

struct SheetListView: View {
    var body: some View {
        list
//        listForEach
//        listInZStack
//        nonScrollView
    }
    
    @ViewBuilder
    private var list: some View {
        List(0..<30) { value in
            Color.accentColor
            Text(verbatim: "\(value)")
        }
//        .ignoresSafeArea(.container, edges: .top)
        /// This doesn't fix bug.
//        .scrollBounceBehavior(.basedOnSize)
        /// This doesn't fix bug.
//        .presentationDetents([.medium, .large])
        /// Adding `scenePadding` fixes issue where list offset "jumps" when user swipes on sheet presentation controller, and detent changes.
        /// But this adds an unwanted small view at the top, and its color can't be changed, which is not desirable.
//        .scenePadding(.minimum, edges: .top)
//        .background(.clear)
    }
    
    @ViewBuilder
    private var listForEach: some View {
        List {
            ForEach(0..<30) { value in
                Text(verbatim: "\(value)")
            }
        }
//        .scenePadding(.minimum, edges: .top)
        /// Adding `safeAreaInset.top` doesn't fix issue.
        //        .safeAreaInset(edge: .top) {
        //            /// Doesn't fix issue.
        //            Text(verbatim: "")
        //            /// Causes top edge to be absurdly insetted.
        //            EmptyView()
        //        }
        /// Adding `scenePadding` fixes issue, huh.
        //        .scenePadding(.minimum, edges: .top)
    }
    
    @ViewBuilder
    private var listInZStack: some View {
        ZStack {
            List {
                ForEach(0..<30) { value in
                    Text(verbatim: "\(value)")
                }
            }
        }
        /// Adding `safeAreaInset.top` doesn't fix issue.
        //        .safeAreaInset(edge: .top) {
        //            /// Doesn't fix issue.
        //            Text(verbatim: "")
        //            /// Causes top edge to be absurdly insetted.
        //            EmptyView()
        //        }
        /// Adding `scenePadding` fixes issue, huh.
        //        .scenePadding(.minimum, edges: .top)
    }
    
    
    @ViewBuilder
    private var nonScrollView: some View {
        GroupBox {
            Text(verbatim: "A")
            Text(verbatim: "B")
            Text(verbatim: "C")
        }
    }
}

struct SheetList_Previews: PreviewProvider {
    static var previews: some View {
        SheetListView()
    }
}
