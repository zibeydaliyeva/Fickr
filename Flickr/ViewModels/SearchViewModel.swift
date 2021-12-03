//
//  SearchViewModel.swift
//  Flickr
//
//  Created by Зибейда Алекперли on 02.12.21.
//

import Foundation

class SearchViewModel {
    
    typealias Response = (ErrorService?) -> Void
    
    private var service: APIServiceProtocol
    
    private var photosList: [Photo] = []
    
    private var isFetchingData = false
    
    private(set) var isLastFetch = false
    
    private var page = 1
    
    let searchText: String
    
    var photosCount: Int {
        return photosList.count
    }
    
    init(_ service: APIServiceProtocol = APIService(), search: String) {
        self.service = service
        self.searchText = search
    }
    
    func initialLoad(completion: @escaping Response) {
        page = 1
        photosList.removeAll()
        isLastFetch = false
        fetchPhotos(completion: completion)
    }
    
    func getNextPhotos(completion: @escaping Response) {
        fetchPhotos(completion: completion)
    }

    func getPhoto(at index: Int) -> SearchCellViewModel? {
        guard photosCount > index else { return nil }
        let item = photosList[index]
        return SearchCellViewModel(photo: item)
    }
    
    private func fetchPhotos(completion: @escaping Response) {
        guard !isFetchingData else { return }
        isFetchingData = true
        service.getPhotos(text: searchText, page: page) { [weak self] result  in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.handleSuccess(data: data)
                completion(.none)
            case .failure(let error):
                completion(error)
            }
            self.isFetchingData = false
        }
    }
    
    private func handleSuccess(data: Search?) {
        guard let data = data?.photos.photo  else { return }
        if data.isEmpty {
            self.isLastFetch = true
        } else {
            self.photosList.append(contentsOf: data)
            self.page += 1
        }
    }

}
