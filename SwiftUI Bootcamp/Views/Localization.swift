//
//  Localization.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 17.04.2022.
//

import SwiftUI

struct Localization: View {
    
    let langCode = Bundle.main.preferredLocalizations[0]
    let currency = Locale.current.currencyCode
    let simbol = Locale.current.currencySymbol
    let isMetric = Locale.current.usesMetricSystem
    var simbol2: String? {
        getSymbol(forCurrencyCode: "EUR")
    }
    let reg = Locale.current.identifier
    let decimal = Locale.current.decimalSeparator
    let group = Locale.current.groupingSeparator
    let langCode2 = Locale.current.languageCode
    
    func getSymbol(forCurrencyCode code: String) -> String? {
       let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: code)
    }
    
//    func getSymbol(forCurrencyCode code: String) -> String? {
//       let locale = NSLocale(localeIdentifier: code)
//       return locale.displayNameForKey(NSLocaleCurrencySymbol, value: code)
//    }
    
//    var langName = ""
//    if let languageName = usLocale.localizedString(forLanguageCode: langCode) {
//        langName = languageName
//    }
    
    var body: some View {
        VStack(spacing: 12) {
            Menu {
                Button("Open in Preview", action: {})
                Button("Save as PDF", action: {})
            } label: {
                Label("PDF", systemImage: "doc.fill")
            }
//            Text(langCode)
//            Text(currency ?? "")
//            Text(simbol ?? "")
//            Text(isMetric.description)
//            Text(simbol2 ?? "No")
//            Text("₽")
//            Text("...\(reg)...")
//            Text("...\(decimal ?? "?")...")
//            Text("...\(group ?? "?")...")
//            Text(langCode2 ?? "No")
        }
    }
}

