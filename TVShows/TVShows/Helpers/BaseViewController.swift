//
//  BaseViewController.swift
//  TVShows
//
//  Created by Vladyslav Kolomiiets on 29.06.2020.
//  Copyright © 2020 Vladyslav Kolomiiets. All rights reserved.
//

import UIKit

protocol ActivityIndicatorProtocol {
    func showActivityIndicator(_ isShow: Bool)
}

class BaseViewController: UIViewController {
    
    // MARK: - properties
    lazy private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        if activityIndicator.superview == nil {
            view.addSubview(activityIndicator)
        }
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            activityIndicator.topAnchor.constraint(equalTo: self.view.topAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        return activityIndicator
    }()
    
    func convertToString(from array: [String]) -> String {
        var text = ""
        array.forEach { (element) in
            if array.isEmpty {
                text = "-"
                return
            }
            if array.last == element {
                text += element
            } else {
                text += element + ", "
            }
        }
        return text
    }
}

extension BaseViewController: ActivityIndicatorProtocol {
    func showActivityIndicator(_ isShow: Bool) {
        if isShow {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
