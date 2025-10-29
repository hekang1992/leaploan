//
//  Model.swift
//  leaploan
//
//  Created by hekang on 2025/10/28.
//

class BaseModel: Codable {
    var phacotherapy: String?
    var marsi: String?
    var billionth: billionthModel?
}

class billionthModel: Codable {
    var oocyst: oocystModel?
    var morts: String?
    var shavery: String?
}

class oocystModel: Codable {
    var snookers: String?
    var inflictable: String?
    var dispender: String?
    var poinder: String?
}
