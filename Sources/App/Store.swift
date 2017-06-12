//
//  Store.swift
//  Hello
//
//  Created by Rushan on 2017-06-12.
//
//

class Store {
    
    var info = [String:String]()
    
    func set(key: String, value: String){
        info[key] = value
    }
    
    func allItems() -> [String] {
        return Array(info.values)
    }
    
    func get(key: String) -> String? {
        return info[key]
    }
    

}
