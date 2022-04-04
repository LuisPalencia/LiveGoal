//
//  SaveFavoritesPresenter.swift
//  iTVShows
//
//  Created by Andres Felipe Ocampo Eljaiesk on 28/09/2020.
//

import Foundation

struct DownloadNewModel: Codable, Equatable, Identifiable {
    let id: String
    let name: String
    let logo: String
    init(pId: String, pName: String, pLogo: String) {
        self.id = pId
        self.name = pName
        self.logo = pLogo
    }
    static func == (lhs: DownloadNewModel, rhs: DownloadNewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func getIdInt() -> Int {
        return Int(id) ?? 0
    }
    
}

class DownloadNewModels: Codable, Identifiable {
    
    var downloads: [DownloadNewModel]?
    init() {
        self.downloads = []
    }
}


class DDBB {
    
    static let shared = DDBB()
    var key: String = "favorites"

    func addLocal(favorite: DownloadNewModel, success: @escaping(DownloadNewModel?) -> Void, failure: @escaping(String?) -> Void) {
        
        self.getAllLocal(success: { (favorites) in
            if let favoritesDes = favorites {
                if let fav = favoritesDes.downloads?.first( where: { $0 == favorite }) {
                    success(fav)
                } else {
                    favoritesDes.downloads?.append(favorite)
                    self.setLocal(favorites: favorites)
                    success(favorite)
                }
            } else {
                let favorites = DownloadNewModels()
                favorites.downloads?.append(favorite)
                self.setLocal(favorites: favorites)
                success(favorite)
            }
        }) { (error) in
            failure(error)
        }
    }
    
    func deleteLocal(favorite: DownloadNewModel?,
                     success: @escaping (DownloadNewModels?) -> Void,
                     failure: @escaping(String?) -> Void) {
        
        // Delete One
        if let favorite = favorite {
            self.getAllLocal(success: { (favorites) in
                favorites?.downloads = favorites?.downloads?.filter({ $0 != favorite })
                self.updateLocal(favorites: favorites)
                success(favorites)
            }) { (error) in
                failure(error)
            }
        } else {
            // Delete All
            UserDefaultCustom.shared.remove(for: self.key)
            self.getAllLocal(success: { (favorites) in
                success(favorites)
            }) { (error) in
                failure(error)
            }
        }
    }
    
    func delete(favorite: DownloadNewModel?, success: @escaping (DownloadNewModels?) -> Void, failure: @escaping(String?) -> Void) {
            self.deleteLocal(favorite: favorite,
                              success: { (favorites) in
                                success(favorites)
            }) { (error) in
                failure(error)
            }
    }
    
    func getAllLocal(success: @escaping(DownloadNewModels?) -> Void, failure : @escaping(String?) -> Void) {
        if let data = UserDefaults.standard.value(forKey: self.key) as? Data {
            let favs = try? JSONDecoder().decode(DownloadNewModels.self, from: data)
            success(favs)
            return
        }
        success(nil)
    }
         
   
    private func updateLocal(favorites: DownloadNewModels?) {
        UserDefaultCustom.shared.set(value: try? JSONEncoder().encode(favorites), key: self.key)
    }
    

    private func setLocal(favorites: DownloadNewModels?) {
        do {
            UserDefaultCustom.shared.set(value: try JSONEncoder().encode(favorites), key: self.key)
        } catch {
            print(error)
        }
    }
    
    func backResults() -> DownloadNewModels{
        var aux : DownloadNewModels?
        self.getAllLocal { (results) in
            if results != nil {
                aux = results!
            } else {
                
            }
        } failure: { (error) in
            print(error ?? "")
        }
        guard let auxDes = aux else { return DownloadNewModels() }
        return auxDes
    }
}

class UserDefaultCustom {

    static let shared = UserDefaultCustom()

    func set(value: Any?, key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
        UserDefaults.standard.synchronize()
    }

    func remove(for key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }

    func value(key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
}


