//
//  ViewModel.swift
//  CryptoMarketDemo
//
//  Created by Ruchin Somal on 2021-06-19.
//

import UIKit
import Alamofire

class ViewModel: NSObject {
    let marketURL = "https://api.coincap.io/v2/assets?limit=20&offset=0"
    var arrMarketElement: [MarketElement] = []
    var storedArr: [MarketElement] = []
    
    func fetchData(callBack: @escaping (Bool, Error?) -> Void) {
        guard let url = URL(string: marketURL) else {
            return
        }
        AF.request(url, method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                    case .success(let json):
                        print(json)
                        do {
                            let responseModel = try JSONDecoder().decode(Market.self, from: response.data ?? Data())
                            self.arrMarketElement = responseModel.data
                            self.storedArr = responseModel.data
                            callBack(true, nil)
                        } catch let error {
                            callBack(false, error)
                    }
                    case .failure(let error):
                        callBack(false, error)
                    }
            }
    }

}
extension String {
    func doubleValue() -> Double {
        if let value = Double(self) {
            return value
        }
        if let value = Float(self) {
            return Double(value)
        }
        return 0.0
    }
    
    func decimalDigit(digit: Int = 2) -> String {
        return String(format: "%.\(digit)f",self.doubleValue())
    }
    
    func formatAsNumber() -> String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = NumberFormatter.Style.currency
    // localize to your grouping and decimal separator
    currencyFormatter.locale = Locale(identifier: "en")
    currencyFormatter.currencySymbol = "$"
    let value: NSDecimalNumber = NSDecimalNumber(string: self)
    let priceString = currencyFormatter.string(from: value)
    return priceString ?? self
    }
}
