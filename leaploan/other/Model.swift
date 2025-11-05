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
    var satanize: [satanizeModel]?
    var cronie: [cronieModel]?
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
    var mankin: [mankinModel]?
    var negrita: Int?
    var unmalted: String?
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
    var caranday: String?
    var nasology: Int?
    var expansible: String?
    var octagonally: Int?
}

class gadgeteerModel: Codable {
    var nighted: String?
    var huggermugger: String?
    var scrutinizer: String?
    var hundredfold: Int?
    var tilewright: String?
    var antisubversive: String?
}

class wolvishModel: Codable {
    var tilewright: String?
    var frypans: Int?
    var nighted: String?
    var antisubversive: String?
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

class satanizeModel: Codable {
    var nighted: String?
    var huggermugger: String?
    var phacotherapy: String?
    var desulfurization: String?
    var quinazolyl: Int?///keybord
    var knitwork: String?
    var frypans: Int?
    var veritism: [veritismModel]?
}

class veritismModel: Codable {
    var unmalted: String?
    var frypans: Int?
}

class cronieModel: Codable {
    var nighted: String?
    var uncontinently: String?
    var unmanliest: String?
    var indexes: String?
    var odontography: String?
    var veritism: [veritismModel]?
    var knitwork: String?
    var unmalted: String?
    var obsequiosity: String?
    var unconjugated: String?
    
    enum CodingKeys: String, CodingKey {
        case nighted
        case uncontinently
        case unmanliest
        case indexes
        case odontography
        case veritism
        case knitwork
        case unmalted
        case obsequiosity
        case unconjugated
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        nighted = try container.decodeIfPresent(String.self, forKey: .nighted)
        uncontinently = try container.decodeIfPresent(String.self, forKey: .uncontinently)
        unmanliest = try container.decodeIfPresent(String.self, forKey: .unmanliest)
        indexes = try container.decodeIfPresent(String.self, forKey: .indexes)
        odontography = try container.decodeIfPresent(String.self, forKey: .odontography)
        veritism = try container.decodeIfPresent([veritismModel].self, forKey: .veritism)
        knitwork = try container.decodeIfPresent(String.self, forKey: .knitwork)
        unmalted = try container.decodeIfPresent(String.self, forKey: .unmalted)
        obsequiosity = try container.decodeIfPresent(String.self, forKey: .obsequiosity)
        
        if let strValue = try? container.decode(String.self, forKey: .unconjugated) {
            unconjugated = strValue
        } else if let intValue = try? container.decode(Int.self, forKey: .unconjugated) {
            unconjugated = String(intValue)
        } else {
            unconjugated = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(nighted, forKey: .nighted)
        try container.encodeIfPresent(uncontinently, forKey: .uncontinently)
        try container.encodeIfPresent(unmanliest, forKey: .unmanliest)
        try container.encodeIfPresent(indexes, forKey: .indexes)
        try container.encodeIfPresent(odontography, forKey: .odontography)
        try container.encodeIfPresent(veritism, forKey: .veritism)
        try container.encodeIfPresent(knitwork, forKey: .knitwork)
        try container.encodeIfPresent(unmalted, forKey: .unmalted)
        try container.encodeIfPresent(obsequiosity, forKey: .obsequiosity)
        try container.encodeIfPresent(unconjugated, forKey: .unconjugated)
    }
}
