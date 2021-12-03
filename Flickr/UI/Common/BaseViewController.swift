//
//  BaseViewController.swift
//  Flickr
//
//  Created by Зибейда Алекперли on 02.12.21.
//

import UIKit

class BaseViewController: UIViewController {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.isTranslucent = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.barStyle = .black
        searchBar.searchTextField.clearButtonMode = .whileEditing
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addSubviews()
        setConstraints()
    }
    
    func setupUI() {
        view.backgroundColor = .mainBGColor
    }
    
    func addSubviews() {
        view.addSubview(searchBar)
    }
    
    func setConstraints() {
        searchBar.anchor(
            .trailing(-20),
            .leading(20),
            .top(view.safeAreaTopAnchor))
    }
    
    func errorHandler(_ error: Error) {
        self.trackError(with: error.localizedDescription)
        self.errorAlert(with: error.localizedDescription)
    }


}

