//
//  DetailViewController.swift
//  SheetListUI
//
//  Created by Bosco Ho on 2023-06-19.
//

import UIKit
import SwiftUI
import Introspect

class DetailViewController: UIViewController {

//    private var hostingVC: UIHostingController<some View>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Detail"
        
        /// This has no effect on bug.
        view.insetsLayoutMarginsFromSafeArea = false
        /// This has no effect on bug.
//        automaticallyAdjustsScrollViewInsets = false
        /// We don't have access to SwiftUI `List`'s underyling scroll view.
//        UIScrollView().contentInsetAdjustmentBehavior = .never
        
        /// Workaround for this issue causes navigation bar to lose its background color.
        /// Set view's background color to SwiftUI view's background color.
        /// This causes navigation bar to lose its translucency.
//        view.backgroundColor = .secondarySystemBackground
//        navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        
//        additionalSafeAreaInsets = .init(top: 56, left: 0, bottom: 0, right: 0)
        
        makeSheetListView()
    }

    private func makeSheetListView() {
        /// Workaround using `Introspect` package.
        let view = SheetListView()
            .introspectCollectionView { collectionView in
                /// Doesn't appear to fix bug.
//                self.navigationController?.setContentScrollView(collectionView)
                /// Doesn't appear to fix bug.
//                collectionView.insetsLayoutMarginsFromSafeArea = false
                
                /** CRITICAL PIECE OF WORKAROUND CODE - START */
                
                /// Workaround: Set `contentInsetAdjustmentBehavior = .never`.
                /// Much better than the other workaround that sets `topAnchor = safeAreaLayoutGuide.topAnchor`.
                /// Source of bug could be some conflict between UISheetPresentationController's safe area logic and UIScrollView's safe area logic.
                collectionView.contentInsetAdjustmentBehavior = .never
                
                /** CRITICAL PIECE OF WORKAROUND CODE - END */
                
                /**
                 Additional adjustments to underlying collection view so that things look nice relative to safe area.
                 */
                /// Make sure List is inside safe area.
                collectionView.contentInset = self.view.safeAreaInsets
                /// Make sure scroll indicators account for safe area:
                /// Still appears a bit janky even if we set this to `false`.
                collectionView.automaticallyAdjustsScrollIndicatorInsets = false
                collectionView.scrollIndicatorInsets = self.view.safeAreaInsets
                /// Make List appear scrolled to top on load.
                collectionView.setContentOffset(.init(x: 0, y: -self.view.safeAreaInsets.top), animated: false)
            }
        /// Not necessary.
//            .safeAreaInset(edge: .top) {
//                EmptyView().frame(height: self.view.safeAreaInsets.top)
//            }
        
        let hostingVC = UIHostingController(rootView: view)
        hostingVC.view.translatesAutoresizingMaskIntoConstraints = false
        /// Doesn't appear to fix bug.
//        hostingVC.view.insetsLayoutMarginsFromSafeArea = false
        
        /// None of the `sizingOptions` has an effect on this bug.
//        hostingVC.sizingOptions = .intrinsicContentSize
//        hostingVC.sizingOptions = .preferredContentSize
//        hostingVC.sizingOptions = [.preferredContentSize, .intrinsicContentSize]
        
        /// This has no effect on bug.
//        hostingVC.automaticallyAdjustsScrollViewInsets = false
        
        addChild(hostingVC)
        self.view.addSubview(hostingVC.view)
        
        NSLayoutConstraint.activate([
            hostingVC.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            hostingVC.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            /// This causes SwiftUI scroll view's offset to shift when sheet's detent changes on swipe.
            hostingVC.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            /// This is a workaround, but navigation bar will lose its background color, which we can workaround by setting the parent view controller's view.backgroundColor.
//            hostingVC.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            hostingVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        hostingVC.didMove(toParent: self)
        
//        self.hostingVC = hostingVC
    }
    
    override var additionalSafeAreaInsets: UIEdgeInsets {
        didSet {
            print(#function, additionalSafeAreaInsets)
        }
    }
    
    override func viewLayoutMarginsDidChange() {
        super.viewLayoutMarginsDidChange()
        print(#function, view.layoutMargins)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        print(#function, view.safeAreaInsets)
    }
}
