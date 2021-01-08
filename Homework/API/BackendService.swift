//
//  BackendService.swift
//  Homework
//
//  Created by Nihad on 12/26/20.
//

import Foundation
import RealmSwift

class BackendService {
    static let shared = BackendService()
    var users = [User]()
    var groups = [Group]()
    private var realm: Realm?
    
    // MARK: - Create
    
    func addUser(user: User) {
        users.append(user)
    }
    
    func addGroup(group: Group) {
        groups.append(group)
    }
    
    func addUsersToRealmDB(users: [User]) {
        realm = try? Realm()
        realm?.beginWrite()
        realm?.delete(realm!.objects(User.self))
        realm?.add(users)
        try? realm?.commitWrite()
    }
    
    func addPhotosToRealmDB(photos: [Photo]) {
        realm = try? Realm()
        realm?.beginWrite()
        realm?.delete(realm!.objects(Photo.self))
        realm?.add(photos)
        try? realm?.commitWrite()
    }
    
    func addGroupsToRealmDB(groups: [Group]) {
        realm = try? Realm()
        realm?.beginWrite()
        realm?.delete(realm!.objects(Group.self))
        realm?.add(groups)
        try? realm?.commitWrite()
    }
    
    // MARK: - Get
    
    func fetchUserFriends(completion: @escaping ([User]) -> Void) {
        NetworkService.shared.getCurrentUserFriends { (response) in
            guard let res = response.value else { return }
            self.users = res.response.items
            
            // adding user's friends to RealmDB
            self.addUsersToRealmDB(users: self.users)
            
            completion(self.users)
        }
    }
    
    func fetchUserGroups(completion: @escaping ([Group]) -> Void) {
        NetworkService.shared.getCurrentUserGroups { response in
            guard let res = response.value else { return }
            self.groups = res.response.items
            
            // adding user's groups to RealmDB
            self.addGroupsToRealmDB(groups: self.groups)
            
            completion(self.groups)
        }
    }
    
    func fetchGroups(startingWithTitle queryString: String, completion: @escaping ([Group]) -> Void) {
        NetworkService.shared.getGroups(startingWithTitle: queryString) { response in
            guard let res = response.value else { return }
            completion(res.response.items)
        }
    }
    
    func fetchPhotosOfUser(withID userID: String, completion: @escaping ([Photo]) -> Void) {
        NetworkService.shared.getPhotosOfUser(withID: userID) { response in
            guard let res = response.value else { return }
            
            // adding user's photos to RealmDB
            self.addPhotosToRealmDB(photos: res.response.items)
            
            completion(res.response.items)
        }
    }
    
    
    
    private init() { }
}
