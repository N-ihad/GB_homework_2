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
    var realm: Realm!
    
    private init() {
        do {
            realm = try Realm()
        } catch {
            print("DEBUG: \(error)")
        }
    }
    
    // MARK: - REALM: CREATE
    
    private func addUserFriendsToRealmDB(friends: [User]) {
        try? realm.write {
            realm.add(friends, update: .modified)
        }
    }
    
    private func addPhotosOfUserToRealmDB(photos: [Photo], for userID: Int) {
        try? realm.write {
            let user = self.realm.object(ofType: User.self, forPrimaryKey: userID)
            user?.photos.removeAll()
            user?.photos.append(objectsIn: photos)
        }
    }
    
    private func addUserGroupsToRealmDB(groups: [Group]) {
        realm.beginWrite()
        realm.add(groups, update: .all)
        try? realm.commitWrite()
    }
    
    private func fetchGroups(startingWithTitle queryString: String, completion: @escaping ([Group]) -> Void) {
        NetworkService.shared.getGroups(startingWithTitle: queryString) { response in
            guard let res = response.value else { return }
            completion(res.response.items)
        }
    }
    
    // MARK: - GET, POST
    
    func getUserFriends(update: Bool, completion: @escaping ([User]) -> Void) {
        if realm.objects(User.self).isEmpty || update {
            NetworkService.shared.getUserFriends { response in
                guard let res = response.value else { return }
                let friends = res.response.items
                
                self.addUserFriendsToRealmDB(friends: friends)
                completion(friends)
            }
        } else {
            completion(Array(realm.objects(User.self)))
        }
    }
    
    func getPhotosOfUser(withID userID: Int, completion: @escaping ([Photo]) -> Void) {
        guard let user = self.realm.object(ofType: User.self, forPrimaryKey: userID) else { return }
        
        if user.photos.isEmpty {
            NetworkService.shared.getPhotosOfUser(withID: String(userID)) { response in
                guard let res = response.value else { return }
                let photos = res.response.items
                
                self.addPhotosOfUserToRealmDB(photos: photos, for: userID)
                completion(photos)
            }
        } else {
            completion(Array(user.photos))
        }
    }
    
    func getUserGroups(completion: @escaping ([Group]) -> Void) {
        if realm.objects(Group.self).isEmpty {
            NetworkService.shared.getUserGroups { response in
                guard let res = response.value else { return }
                let groups = res.response.items
                
                self.addUserGroupsToRealmDB(groups: groups)
                completion(groups)
            }
        } else {
            completion(Array(realm.objects(Group.self)))
        }
    }
    
//    func notifyIfUsersInRalmDBChanged(completion: @escaping () -> Void) {
//        _ = realm.objects(User.self).observe {  (changes: RealmCollectionChange) in
//                    switch changes {
//                    case .initial(let results):
//                        print("DEBUG: results - \(results)")
//                    case let .update(results, deletions, insertions, modifications):
//                        print("DEBUG: results, deletions, insertions, modifications - \(results), \(deletions), \(insertions), \(modifications)")
//                    case .error(let error):
//                        print("DEBUG: error - \(error)")
//                    }
//                    print("Users data has been changed")
//                }
//    }
    
    
    
    // MARK: - DELETE
    
//    func deleteRealmDB() {
//        let realm = try! Realm(configuration: Realm.Configuration.init(deleteRealmIfMigrationNeeded: true))
//        try! realm.write {
//          realm.deleteAll()
//        }
//    }
}
