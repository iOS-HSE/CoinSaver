//
//  Themes.swift
//  CoinSaver
//
//  Created by fiskirton on 17.12.2020.
//

import RxSwift
import RxTheme

typealias Color = UIColor
typealias Attributes = [NSAttributedString.Key: Any]

protocol Theme {
    var backgroundColor: Color { get }
    
    var accentColor: Color { get }
    var circleViewColor: Color { get }
    var labelTextColor: Color { get }
    var switcherColor: Color { get }
    var switcherThumbColor: Color { get }
    
    var popupBackgroundColor: Color { get }
    
    var black: Color { get }
    var white: Color { get }
    
    var navigationBarBarTintColor: Color { get }
    var navigationBarTintColor: Color { get }
    var navigationBarTitleTextAttributes: Attributes { get }
    
    var buttonBackgroundColor: Color { get }
    var buttonTitleColor: Color { get }
    var buttonBorderColor: CGColor { get }
}

struct LightTheme: Theme {
//    let backgroundColor: Color = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    let backgroundColor: Color = #colorLiteral(red: 0.9214878678, green: 0.9216203094, blue: 0.9214587808, alpha: 1)

    let circleViewColor: Color = #colorLiteral(red: 0.9882352941, green: 0.8, blue: 0.3764705882, alpha: 1)
    let accentColor: Color = #colorLiteral(red: 0.9921568627, green: 0.768627451, blue: 0.2745098039, alpha: 1)
    let labelTextColor: Color = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1529411765, alpha: 1)
    let switcherColor: Color = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1529411765, alpha: 1)
    let switcherThumbColor: Color = #colorLiteral(red: 0.467251718, green: 0.467251718, blue: 0.467251718, alpha: 1)
    
    let popupBackgroundColor: Color = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 0.9000963185)
    
    let black: Color = .black
    let white: Color = .white
    
    let navigationBarBarTintColor: Color = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    let navigationBarTintColor: Color = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1529411765, alpha: 1)
    let navigationBarTitleTextAttributes: Attributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1529411765, alpha: 1)]
    
    let buttonBackgroundColor: Color = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    let buttonTitleColor: Color = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1529411765, alpha: 1)
    let buttonBorderColor: CGColor = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1529411765, alpha: 1).cgColor
}

struct DarkTheme: Theme {
    let backgroundColor: Color = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1529411765, alpha: 1)
    
    let circleViewColor: Color = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    let accentColor: Color = #colorLiteral(red: 0.9921568627, green: 0.768627451, blue: 0.2745098039, alpha: 1)
    let labelTextColor: Color = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    let switcherColor: Color = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    let switcherThumbColor: Color = #colorLiteral(red: 0.1646243632, green: 0.1646243632, blue: 0.1646243632, alpha: 1)

    let popupBackgroundColor: Color = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 0.1038366866)
    
    let black: Color = .black
    let white: Color = .white
    
    let navigationBarBarTintColor: Color = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1529411765, alpha: 1)
    let navigationBarTintColor: Color = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    let navigationBarTitleTextAttributes: Attributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)]
    
    let buttonBackgroundColor: Color = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1529411765, alpha: 1)
    let buttonTitleColor: Color = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    let buttonBorderColor: CGColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1).cgColor
}

enum ThemeType: ThemeProvider {
    case light, dark
    var associatedObject: Theme {
        switch self {
        case .light: return LightTheme()
        case .dark: return DarkTheme()
        }
    }
}

let themeService = ThemeType.service(initial: .light)
func themed<T>(_ mapper: @escaping ((Theme) -> T)) -> Observable<T> {
    return themeService.attrStream(mapper)
}
