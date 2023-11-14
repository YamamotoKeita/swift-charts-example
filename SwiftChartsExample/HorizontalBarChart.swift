import SwiftUI
import Charts

struct HorizontalBarChart: View {
    var body: some View {
        Chart {
            BarMark(
                x: .value("Category", "Label"),
                y: .value("Value", 100)
            )
        }
        .chartXAxisLabel("Position (meters)")
        .chartYAxisLabel("(円)")
    }
}

#Preview {
    HorizontalBarChart()
}
