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

func WCDBPath()->String{
    return documentPath.appendingPathComponent("wcdb.db")
}

class WCDBManager{
    
    /// 数据库是否需要升级版本
    ///
    /// - Returns: 返回是否需要的bool值
    class func isNeedUpdated()->Bool{
        guard let version = UserDefaults.standard.string(forKey: kWcdbVersionKey) else {
            return true
        }
        if version != UserDefaults.standard.string(forKey: kWcdbVersionKey) {
            return true
        }
        return false
    }
    
    class func update<T: TableCodable>(table: T.Type){
        let tableName = String(describing: table)
        guard let judge = try? dataBase.isTableExists(tableName) else {
            create(table: table)
            return
        }
        if isNeedUpdated() || !judge {
            create(table: table)
        }
    }
    
    class func create<T: TableCodable>(table: T.Type){
        do {
            let tableName = String(describing: table)
            try dataBase.create(table: tableName, of: table)
        } catch {
            
        }
    }
    
    class func insertOrReplace<T: TableCodable>(table: T,tableType: T.Type){
        update(table: tableType)
        do {
            let tableName = String(describing: tableType)
            try dataBase.insertOrReplace(objects: [table], intoTable: tableName)
        } catch {
            
        }
    }
    
    class func deleteObject<T: TableCodable>(table: T.Type,condition : Condition) {
        do {
            let tableName = String(describing: table)
            try dataBase.delete(fromTable: tableName, where: condition, orderBy: nil, limit: nil, offset: nil)
        } catch  {
            
        }
    }
    
    class func getObjects<T: TableCodable>(table: T.Type,condition : Condition)->[T]?{
        do {
            let tableName = String(describing: table)
            let objects : [T] = try dataBase.getObjects(on: table.Properties.all, fromTable: tableName, where: condition, orderBy: nil, offset: nil)
            return objects
        } catch {
            return nil
        }
    }
    
}

func test(){
    let person = WCDBPerson()
    try? dataBase.insertOrReplace(objects: person, intoTable: "person")
}


class WCDBPerson: WCDBSwift.TableCodable {
    //Your own properties
    var id: Int? // Optional if it would be nil in some WCDB selection
    var name: String? // Optional if it would be nil in some WCDB selection
    var age: Int?
    var gener: String?
    var address: String?
    var car : WCDBCar?
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = WCDBPerson
        
        //List the properties which should be bound to table
        case id
        case name
        case age
        case gener
        case address
        case car
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                id: ColumnConstraintBinding(isPrimary: true)
            ]
        }
        
    }
}


class WCDBCar: WCDBSwift.TableCodable {
    //Your own properties
    
    var brand: String? // Optional if it would be nil in some WCDB selection
    var name: String? // Optional if it would be nil in some WCDB selection
    var number: String?
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = WCDBCar
        
        //List the properties which should be bound to table
        case brand
        case name
        case number
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        
    }
}

