//
//  ReactiveTheme.swift
//  CoinSaver
//
//  Created by fiskirton on 17.12.2020.
//

import Foundation
import RxTheme
import RxSwift
import RxCocoa
import Charts

//self.topCostsPieChart.legend.textColor = .white


extension Reactive where Base: UIView {
    var borderColor: Binder<UIColor?> {
        return Binder(self.base) { view, color in
            view.layer.borderColor = color?.cgColor
        }
    }
}

extension ThemeProxy where Base: UIView {
    var borderColor: Observable<UIColor?> {
        get { return .empty() }
        set {
            let disposable = newValue
                .takeUntil(base.rx.deallocating)
                .observeOn(MainScheduler.instance)
                .bind(to: base.rx.borderColor)
            hold(disposable, for: "borderColor")
        }
    }
}

extension Reactive where Base: PieChartView {
    var legendTextColor: Binder<UIColor?> {
        return Binder(self.base) { view, color in
            let chart = view as PieChartView
            chart.legend.textColor = color!
        }
    }
}

extension ThemeProxy where Base: PieChartView {
    var legendTextColor: Observable<UIColor?> {
        get { return .empty() }
        set {
            let disposable = newValue
                .takeUntil(base.rx.deallocating)
                .observeOn(MainScheduler.instance)
                .bind(to: base.rx.legendTextColor)
            hold(disposable, for: "legendTextColor")
        }
    }
}
