//
//  UserDefaultsHelper.swift
//  Vollmed
//
//  Created by Elisangela Pethke on 25.03.24.
//

import Foundation

// para salvar uma autenticaçao
struct UserDefaultsHelper {
    
    static func save(value: String,key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    // para recuperar uma informaçao de acordo com a chave
    
    static func get(for key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    // para remover uma informaçao
    
    static func remove(for key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
