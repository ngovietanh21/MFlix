//
//  RealmManager.swift
//  MFlix
//
//  Created by Viet Anh on 5/20/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

struct RealmManager {
    static let shared = RealmManager()
    
    private var realm: Realm? {
        get {
            do {
                return try Realm()
            }
            catch {
               return nil
            }
        }
    }
    
    private init() {
    }
    
    func getAllData<T: Object>() -> Observable<[T]> {
        guard let realm = self.realm else { return .error(RealmError.cannotInitObject) }
        
        let object = realm.objects(T.self).sorted(byKeyPath: "addRealmDate", ascending: true)
        return Observable.array(from: object)
    }
    
    func addData<T: Object> (item: T) -> Observable<T> {
        guard let realm = self.realm else { return .error(RealmError.cannotInitObject) }
        
        do {
            try realm.write {
                realm.create(T.self, value: item, update: .modified)
            }
            return .just(item)
        } catch {
            return .error(RealmError.addFail)
        }
    }
    
    func deleteMovieData<T: Object>(item: T) -> Observable<Bool> {
        guard let realm = self.realm else { return .error(RealmError.cannotInitObject) }
        
        do {
            guard let primaryKey = T.primaryKey(),
                let primaryValue = item.value(forKey: primaryKey) as? Int,
                let object = realm.object(ofType: T.self,
                                          forPrimaryKey: primaryValue) else {
                                            return .just(true)
            }
            try realm.write {
                realm.delete(object)
            }
            return .just(false)
        } catch {
            return .error(RealmError.deleteFail)
        }
    }
    
    func checkMovieExist(item: Movie) -> Bool {
        guard let realm = self.realm,
            realm.object(ofType: Movie.self,
                         forPrimaryKey: item.id) != nil else {
                            return false
        }
        return true
    }
}
