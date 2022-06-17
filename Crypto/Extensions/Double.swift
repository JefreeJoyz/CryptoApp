//
//  Double.swift
//  Crypto
//
//  Created by Eugene Yakushev on 17.06.2022.
//

import Foundation

extension Double {
    
    /// Конвертируем дабл в Валюту с 2 знаками
    /// ```
    ///  Convert 1234.56 to $1,234.56
    /// ```
    private var currencyFormatter2 : NumberFormatter {
        let formatter = NumberFormatter ()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        //formatter.locale = .current // дефолтное значение
        //formatter.currencyCode = "usd" // смена валюты ?
        //formatter.currencySymbol = "$" // меняем символ валюты
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// Конвертируем дабл в Валюту как стринг (!) с 2 знаками
    /// ```
    ///  Convert 1234.56 to "$1,234.56"
    /// ```
    func asCurrancyWith2Decimals () -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    func dsdff () {
        
    }
    
    
    /// Конвертируем дабл в Валюту с 2-6 знаками
    /// ```
    ///  Convert 1234.56 to $1,234.56
    ///  Convert 12.3456 to $12.3456
    ///  Convert 0.123456 to $0.123456
    /// ```
    private var currencyFormatter6 : NumberFormatter {
        let formatter = NumberFormatter ()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        //formatter.locale = .current // дефолтное значение
        //formatter.currencyCode = "usd" // смена валюты ?
        //formatter.currencySymbol = "$" // меняем символ валюты
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Конвертируем дабл в Валюту как стринг (!) с 2-6 знаками
    /// ```
    ///  Convert 1234.56 to "$1,234.56"
    ///  Convert 12.3456 to "$12.3456"
    ///  Convert 0.123456 to "$0.123456"
    /// ```
    func asCurrancyWithSixDecimals () -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Конвертируем дабл в  стринг с 2мя знаками после запятой
    /// ```
    ///  Convert 1.2345 to "1.23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Конвертируем дабл в  стринг с 2мя знаками после запятой c символом "%"
    /// ```
    ///  Convert 1.2345 to "1.23%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
}
