//
//  SearchResultViewController.swift
//  Flickr
//
//  Created by Зибейда Алекперли on 02.12.21.
//

import UIKit

class SearchResultViewController: BaseViewController {
    
    var viewModel: SearchViewModel?
    
    private let collectionView: PhotoCollectionView = {
        let collectionView = PhotoCollectionView()
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        searchBar.text = viewModel?.searchText
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(collectionView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        collectionView.anchor(
            .leading(),
            .trailing(),
            .top(searchBar.bottomAnchor, constant: 10),
            .bottom(view.safeAreaBottomAnchor, constant: -10))
    }
    
    // MARK: - Private
    private func initialLoad() {
        collectionView.showLoadingIndicator()
        
        viewModel?.initialLoad { [weak self] error  in
            
            self?.collectionView.hideLoadingIndicator()
            
            if let error = error {
                self?.errorHandler(error)
            } else {
                if self?.viewModel?.photosCount == 0 {
                    self?.collectionView.showEmptyView()
                }
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func loadNextPhotos() {
        
        guard let viewModel = viewModel ,
              !viewModel.isLastFetch
        else { return }
        
        collectionView.animateSpinner(true)
        
        viewModel.getNextPhotos { [weak self] error in
            
            self?.collectionView.animateSpinner(false)
            
            if let error = error {
                self?.errorHandler(error)
            } else {
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
}


// MARK: - UICollectionView data source
extension SearchResultViewController:  UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dataCount = viewModel?.photosCount ?? 0
        return section == 0 ? dataCount : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            return itemCell(indexPath: indexPath)
        } else {
            return loadingCell(indexPath: indexPath)
        }
    }
    
    func itemCell(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.collectionView.dequeueReusableCell(
                withReuseIdentifier: PhotoCell.ID, for: indexPath) as? PhotoCell,
              let cellViewModel = viewModel?.getPhoto(at: indexPath.item)
        else { return UICollectionViewCell() }
        
        cell.configure(cellViewModel)
        return cell
    }
    
    func loadingCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.collectionView.dequeueReusableCell(
            withReuseIdentifier: LoadingCell.ID, for: indexPath) as? LoadingCell
        return cell ?? UICollectionViewCell()
    }

}


// MARK: - CatalogCollectionViewDelegate delegate
extension SearchResultViewController: PhotoCollectionViewDelegate {

    func scrollViewDidScrollToBottom() {
        loadNextPhotos()
    }
    
}

// MARK: - UISearchBarDelegate delegate
extension SearchResultViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.dismiss(animated: false, completion: nil)
        return false
    }
    
}
