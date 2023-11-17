import SwiftUI

class DoubleYAxisViewModel: ObservableObject {
    @Published var barSource: [Double] = [190000, 65000, 80000, 65000]
    @Published var lineSource: [Double] = [-10, 8, 3, 5]

    var barData: [Double] { barSource }
    var lineData: [Double] = []

    var yAxisForBar: [Double] = []
    var yAxisForLine: [Double] = []

    init() {
        calculate()
    }

    func calculate() {
        yAxisForBar = calcYAxisForBar()
        yAxisForLine = calcYAxisForLine()
        calcLineData()
    }

    private func calcLineData() {
        guard let barMin = yAxisForBar.first, let barMax = yAxisForBar.last,
              let lineMin = yAxisForLine.first, let lineMax = yAxisForLine.last else { return }

        let barSpan = barMax - barMin
        let lineSpan = lineMax - lineMin
        if lineSpan == 0 {
            return
        }

        lineData = lineSource.map {
            ($0 - lineMin) * (barSpan / lineSpan)
        }
    }

    private func calcYAxisForBar() -> [Double] {
        guard let max = barSource.max() else {
            return []
        }
        return YAxisUtil.calcYAxis(
            min: 0,
            max: max * 1.1, 
            lineCount: 6,
            minSpan: 10
        )
    }

    private func calcYAxisForLine() -> [Double] {
        guard let max = lineSource.max(), let min = lineSource.min() else {
            return []
        }

        return YAxisUtil.calcYAxis(
            min: min,
            max: max + (max - min) * 0.1,
            lineCount: 6,
            minSpan: 10
        )
    }
}
