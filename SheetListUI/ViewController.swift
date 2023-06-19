//
//  ViewController.swift
//  SheetListUI
//
//  Created by Bosco Ho on 2023-06-19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if presentedViewController == nil {
           presentDetailSheet()
        }
    }
    
    private func presentDetailSheet() {
        let vc = DetailViewController(nibName: nil, bundle: nil)
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .pageSheet
        nc.sheetPresentationController?.detents = [
            .custom { $0.maximumDetentValue * 0.2 }, .medium(), .large()
        ]
        nc.isModalInPresentation = true
        present(nc, animated: true)
    }
}

