//
//  ComposeNewMessageController.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 13/06/2021.
//

import UIKit

class ComposeNewMessageController: UIViewController {

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.text = "Search for users"
        searchBar.delegate = self
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.titleView = searchBar
    }
}

extension ComposeNewMessageController: UISearchBarDelegate {

}
