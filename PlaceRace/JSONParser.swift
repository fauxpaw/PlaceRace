//
//  JSONParser.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/24/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import Foundation

class JSONParser {
    
    func dataToDictionaryRootObject(data: Data) -> [String: Any]? {
        
        do {
            if let rootObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                return rootObject
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
        return nil
    }
   
    
    func dictionaryRootToArrayOfDict(rootObj: [String: Any], key: String) -> [[String: Any]]? {
        
        let array : [[String: Any]] = rootObj[key] as! [[String: Any]]
        return array
        
    }
    
    
    
    /*
    func arrayOfDictToSingleDict(arrOfDict: [[String: Any]]) -> [String: Any] {
     
    }
    */
    
}
