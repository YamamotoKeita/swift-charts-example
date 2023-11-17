import Foundation

enum YAxisUtil {
    /// 目盛り刻み数の左2桁がこの中のいずれかになるようにする
    static private let units: [Double] = [10, 12, 15, 20, 25, 30, 40, 50, 60, 80]

    ///
    /// min〜maxの値が収まり、かつキリのいい刻みになるY軸の目盛り刻みを計算する
    ///
    /// - Parameters:
    ///   - min: 取りえる最小値
    ///   - max: 取りえる最大値
    ///   - divideCount: 目盛り刻みの分割数
    ///   - defaultSpan: maxとminが同一の場合にとる幅
    ///   - forcePositive: これがtrueの場合、マイナスの目盛りをとらない
    /// - Returns: 目盛り刻みの配列。値昇順の要素数divideCount + 1の配列になる。
    static func calcYAxis(
        min: Double,
        max: Double,
        divideCount: Int,
        defaultSpan: Double,
        forcePositive: Bool = false
    ) -> [Double] {
        var safeMin = min
        var safeMax = max

        // min == maxだと0除算が起きてしまうためdefaultSpanの幅をとる
        if min == max {
            safeMin = min - defaultSpan / 2
            safeMax = max + defaultSpan / 2
        }

        let lowerLimit = (safeMax - safeMin) / Double(divideCount)
        let length = String(Int(lowerLimit)).count
        let suffix = pow(10.0, Double(length) - 2)
        let prefix = ceil(lowerLimit / suffix)

        var unitScale: Double = 1
        var unitIndex = 0
        let proceedUnitIndex = {
            if unitIndex < units.count - 1 {
                unitIndex += 1
            } else {
                unitScale *= 10
                unitIndex = 0
            }
        }

        var interval: Double = 0
        var graphMin: Double = 0

        while true {
            let unit = units[unitIndex] * unitScale
            if unit < prefix {
                proceedUnitIndex()
                continue
            }

            interval = unit * suffix
            let remainder = safeMax.truncatingRemainder(dividingBy: interval)

            var graphMax = safeMax - remainder
            if 0 < remainder {
                graphMax += interval
            }

            graphMin = graphMax - interval * Double(divideCount)

            if forcePositive {
                while graphMin < 0 {
                    graphMin += interval
                }
                graphMax = graphMin + interval * Double(divideCount)
            }

            if graphMin <= safeMin && safeMax <= graphMax {
                break
            }
            proceedUnitIndex()
        }

        return (0...divideCount)
            .map {
                graphMin + (Double($0) * interval)
            }
    }
}
