//
//  SearchHistoryViewController.swift
//  Flickr
//
//  Created by Зибейда Алекперли on 02.12.21.
//

import UIKit

class SearchHistoryViewController: BaseViewController {
    
    private var viewModel: SearchHistoryViewModel?

    private let tableView: UITableView = {
        let inset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return UITableView(seperatorStyle: .none, contentInset: inset)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchHistoryViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchHistory()
        tableView.reloadData()
        searchBar.becomeFirstResponder()
    }
    
    override func setupUI() {
        super.setupUI()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchHistoryCell.self, forCellReuseIdentifier: SearchHistoryCell.ID)
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(tableView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        tableView.anchor(
            .leading(20),
            .trailing(-20),
            .top(searchBar.bottomAnchor, constant: 10),
            .bottom(view.safeAreaBottomAnchor, constant: -10))
        
    }

    // MARK: - Private
    
    private func fetchHistory() {
        viewModel?.getHistory()
        tableView.reloadData()
    }
    
    private func search(text: String) {
        viewModel?.saveHistory(text: text)
        let vc = SearchResultViewController()
        let searchViewModel = SearchViewModel(search: text)
        vc.viewModel = searchViewModel
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.filteredHistoryCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            SearchHistoryCell.ID, for: indexPath) as? SearchHistoryCell
        else { return UITableViewCell() }
        
        if let text = viewModel?.getItem(at: indexPath.row) {
            cell.configure(text)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let text = viewModel?.getItem(at: indexPath.row) {
            search(text: text)
            searchBar.text = text
        }
    }

}


// MARK: - UISearchBarDelegate

extension SearchHistoryViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let fieldText = searchBar.text?.trim(),
        !fieldText.isEmpty else { return }
        search(text: fieldText)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let fieldText = searchBar.text?.trim()  else { return }
        viewModel?.filterList(keyword: fieldText)
        tableView.reloadData()
    }
    
}
