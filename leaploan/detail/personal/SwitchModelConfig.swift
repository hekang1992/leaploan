//
//  SwitchModel.swift
//  leaploan
//
//  Created by hekang on 2025/11/4.
//

import BRPickerView

class EnumModel {
    static func getFirstModelArray(dataSourceArr: [Any]) -> [BRProvinceModel] {
        var result = [BRProvinceModel]()
        
        for proviceDic in dataSourceArr {
            guard let proviceDic = proviceDic as? veritismModel else {
                continue
            }
            
            let proviceModel = BRProvinceModel()
            proviceModel.code = String(proviceDic.frypans ?? 0)
            proviceModel.name = proviceDic.unmalted ?? ""
            proviceModel.index = dataSourceArr.firstIndex(where: { $0 as AnyObject === proviceDic as AnyObject }) ?? 0
            
            result.append(proviceModel)
        }
        
        return result
    }
}

class AddressModel {
    static func getAddressModelArray(dataSourceArr: [Any]) -> [BRProvinceModel] {
        return dataSourceArr.compactMap { item -> BRProvinceModel? in
            guard let provinceDic = item as? mankinModel else {
                return nil
            }
            
            let provinceModel = BRProvinceModel()
            provinceModel.code = String(provinceDic.negrita ?? 0)
            provinceModel.name = provinceDic.unmalted ?? ""
            provinceModel.index = dataSourceArr.firstIndex { $0 as AnyObject === provinceDic as AnyObject } ?? 0
            
            let cityList = provinceDic.mankin ?? []
            provinceModel.citylist = processCityList(cityList)
            
            return provinceModel
        }
    }
    
    private static func processCityList(_ cityList: [mankinModel]) -> [BRCityModel] {
        return cityList.enumerated().map { index, cityDic in
            let cityModel = BRCityModel()
            cityModel.code = String(cityDic.negrita ?? 0)
            cityModel.name = cityDic.unmalted ?? ""
            cityModel.index = index
            
            let areaList = cityDic.mankin ?? []
            cityModel.arealist = processAreaList(areaList)
            
            return cityModel
        }
    }
    
    private static func processAreaList(_ areaList: [mankinModel]) -> [BRAreaModel] {
        return areaList.enumerated().map { areaIndex, areaDic in
            let areaModel = BRAreaModel()
            areaModel.code = String(areaDic.negrita ?? 0)
            areaModel.name = areaDic.unmalted ?? ""
            areaModel.index = areaIndex
            return areaModel
        }
    }
}
