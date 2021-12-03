//
//  SearchHistoryViewModel.swift
//  Flickr
//
//  Created by Зибейда Алекперли on 02.12.21.
//

import Foundation

class SearchHistoryViewModel {
    
    private var historyList: [String] = []
    
    private var filteredHistoryList: [String] = []
    
    private let limit = 10
    
    private var keyWord: String?
    
    private var historyCount: Int {
        return historyList.count
    }
    
    var filteredHistoryCount: Int {
        return filteredHistoryList.count
    }
    
    func getHistory() {
        guard let photos = AppDefaults.getAny(key: .searchPhoto) as? [String]
        else { return }
        historyList = photos
        getFilterHistory()
    }
    
    func saveHistory(text: String) {
        historyList.insert(text, at: 0)
        if historyCount > limit { historyList.removeLast() }
        AppDefaults.setAny(value: historyList, key: .searchPhoto)
    }
    
    func getItem(at index: Int) -> String? {
        guard filteredHistoryCount > index else { return nil }
        return filteredHistoryList[index]
    }
    
    func filterList(keyword: String?) {
        keyWord = keyword?.lowercased()
        getFilterHistory()
    }
    
    private func getFilterHistory() {
        filteredHistoryList.removeAll()
        if let text = keyWord, text.count != 0 {
            filteredHistoryList = historyList.filter({
                $0.lowercased().contains(text.lowercased())
            })
        } else {
            filteredHistoryList.append(contentsOf: historyList)
        }
    }
}


