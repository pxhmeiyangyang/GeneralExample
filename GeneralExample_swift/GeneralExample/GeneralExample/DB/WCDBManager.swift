//
//  DBPersonModel.swift
//  GeneralExample
//
//  Created by pxh on 2018/6/25.
//  Copyright © 2018年 pxh. All rights reserved.
//

import UIKit

import WCDBSwift

let kWcdbVersionKey = "kWcdbVersionKey"

let dataBase = Database.init(withPath: WCDBPath())

let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString

/// 升级数据库版本更新所有表
func WCDBUpdatedVersion(){
    guard let version = UserDefaults.standard.string(forKey: kWcdbVersionKey) else {
        WCDBUpdateAllTables()
        return
    }
    if version != UserDefaults.standard.string(forKey: kWcdbVersionKey) {
        WCDBUpdateAllTables()
    }
}

func WCDBUpdateAllTables(){
    do {
        try dataBase.create(table: "WCDBPerson", of: WCDBPerson.self)
    } catch  {
        
    }
}

func WCDBPath()->String{
    return documentPath.appendingPathComponent("wcdb.db")
}

class WCDBPerson: WCDBSwift.TableCodable {
    //Your own properties
    let variable1: Int = 0
    var variable2: String? // Optional if it would be nil in some WCDB selection
    var variable3: Double? // Optional if it would be nil in some WCDB selection
    let unbound: Date? = nil
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = WCDBPerson
        
        //List the properties which should be bound to table
        case variable1 = "custom_name"
        case variable2
        case variable3
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
    }
}
