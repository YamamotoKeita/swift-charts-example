import Foundation

enum YAxisUtil {
    static private let units: [Double] = [10, 12, 15, 20, 25, 30, 40, 50, 60, 80]

    static func calcYAxis(
        min: Double,
        max: Double,
        lineCount: Int,
        minSpan: Double,
        forcePositive: Bool = false
    ) -> [Double] {
        var safeMin = min
        var safeMax = max
        if min == max {
            safeMin = min - minSpan / 2
            safeMax = max + minSpan / 2
        }

        let lowerLimit = (safeMax - safeMin) / (Double(lineCount) - 1)
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

            graphMin = graphMax - interval * (Double(lineCount) - 1)

            if forcePositive {
                while graphMin < 0 {
                    graphMin += interval
                }
                graphMax = graphMin + interval * (Double(lineCount) - 1)
            }

            if graphMin <= safeMin && safeMax <= graphMax {
                break
            }
            proceedUnitIndex()
        }

        return (0..<lineCount)
            .map {
                graphMin + (Double($0) * interval)
            }
    }
}
