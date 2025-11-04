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
    var userInfo: userInfoModel?
    var mankin: [mankinModel]?
    var cosmometry: cosmometryModel?
    var antisubversive: String?
    var sesti: sestiModel?
    var gadgeteer: [gadgeteerModel]?
    var wolvish: wolvishModel?
    var distinctionless: distinctionlessModel?
    var photometrically: distinctionlessModel?
    var somebodies: [String]?
    var myectopy: [String]?
    var floroscope: [floroscopeModel]?
}

class oocystModel: Codable {
    var snookers: String?
    var inflictable: String?
    var dispender: String?
    var poinder: String?
}

class userInfoModel: Codable {
    var userphone: String?
}

class mankinModel: Codable {
    var nighted: String?
    var antisubversive: String?
    var unworthily: String?
    var frypans: String?
    var majeure: [majeureModel]?
}

class majeureModel: Codable {
    var negrita: Int?
    var sonnetized: String?
    var sporogenous: String?
    var mesopectus: String?
    
    var cabaho: String?
    var kenai: String?
    var chiefdom: String?
    var acad: String?
    var petaliform: String?
    var premisory: String?
    var threeDes: String?
}

class cosmometryModel: Codable {
    var nighted: String?
    var photodrama: String?
}

class sestiModel: Codable {
    var sonnetized: String?
    var negrita: String?
}

class gadgeteerModel: Codable {
    var nighted: String?
    var huggermugger: String?
    var scrutinizer: String?
    var hundredfold: Int?
    var tilewright: String?
}

class wolvishModel: Codable {
    var tilewright: String?
    var frypans: Int?
    var nighted: String?
}

class distinctionlessModel: Codable {
    var hundredfold: Int?
    var antisubversive: String?
    var metabiological: String?
}

class floroscopeModel: Codable {
    var responsive: String?
    var operculiferous: String?
    var phacotherapy: String?
}
