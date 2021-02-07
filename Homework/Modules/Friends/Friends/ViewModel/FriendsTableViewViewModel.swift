//
//  FriendsTableViewViewModel.swift
//  Homework
//
//  Created by Nihad on 1/27/21.
//

import Foundation

protocol FriendsTableViewProtocol {
    func fetchUserFriends(completion: (()->())?)
    func updateUserFriendsData(completion: @escaping ()->())
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func titleForHeaderInSection(section: Int) -> String
    func getSortedFriendsFirstLettersOfLastName() -> [String]
    func cellViewModel(for indexPath: IndexPath) -> FriendsTableViewCellViewModelProtocol
    func getUserID(for indexPath: IndexPath) -> Int
}

class FriendsTableViewViewModel {
    
    private var friends: [User] = [] {
        didSet {
            configureSections()
        }
    }
    private var sortedFirstLetters: [String] = []
    private var sections: [[User]] = [[]]
    
    init() {
        fetchUserFriends(completion: nil)
    }
    
    func configureSections() {
        let firstLetters = friends.map { $0.titleFirstLetter }
        let uniqueFirstLetters = Array(Set(firstLetters))

        sortedFirstLetters = uniqueFirstLetters.sorted()
        sections = sortedFirstLetters.map { firstLetter in
            return friends
                .filter { $0.titleFirstLetter == firstLetter }
                .sorted { $0.lastName < $1.lastName }
        }
    }
}

extension FriendsTableViewViewModel: FriendsTableViewProtocol {
    
    func fetchUserFriends(completion: (()->())?) {
        BackendService.shared.getUserFriends(update: false) { friends in
            self.friends = friends
            completion?()
        }
    }
    
    func updateUserFriendsData(completion: @escaping () -> ()) {
        BackendService.shared.getUserFriends(update: true) { friends in
            self.friends = friends
            completion()
        }
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        sections[section].count
    }
    
    func titleForHeaderInSection(section: Int) -> String {
        return sortedFirstLetters.isEmpty ? "Loading.." : sortedFirstLetters[section]
    }
    
    func getSortedFriendsFirstLettersOfLastName() -> [String] {
        return sortedFirstLetters
    }
    
    func getUser(in section: Int, and row: Int) -> User {
        return sections[section][row]
    }
    
    func cellViewModel(for indexPath: IndexPath) -> FriendsTableViewCellViewModelProtocol {
        let friend = sections[indexPath.section][indexPath.row]
        return FriendsTableViewCellViewModel(friend: friend)
    }
    
    func getUserID(for indexPath: IndexPath) -> Int {
        return sections[indexPath.section][indexPath.row].id
    }
}
