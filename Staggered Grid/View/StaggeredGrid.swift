//
//  StaggeredGrid.swift
//  Staggered Grid
//
//  Created by Tal talspektor on 18/04/2022.
//

import SwiftUI

// Custom View Builder...

// T -> is to hold the identifiable collection of data...

struct StaggeredGrid<Content: View, T: Identifiable>: View where T: Hashable {

    // It will return each object from collection to build View...
    var content: (T) -> Content

    var list: [T]

    // Columns...
    var columns: Int

    // Properties...
    var showsIndicators: Bool
    var spacing: CGFloat

    init(columns: Int, showsIndicators: Bool, spacing: CGFloat, list: [T], @ViewBuilder content: @escaping (T) -> Content) {
        self.content = content
        self.list = list
        self.showsIndicators = showsIndicators
        self.spacing = spacing
        self.columns = columns
    }

    // Staggered Grid Function...
    func setUpLIst() -> [[T]] {

        // create empty sub array of columns count...
        var gridArray: [[T]] = Array(repeating: [], count: columns)

        // spiliting array for Vstack oriented View...
        var currentIndex: Int = 0

        for object in list {
            gridArray[currentIndex].append(object)

            // increasing index count...
            // and reseting if overbounds the columns count...
            if currentIndex == (columns - 1) {
                currentIndex = 0
            }
            else {
                currentIndex += 1
            }
        }

        return gridArray
    }

    var body: some View {

        ScrollView(.vertical, showsIndicators: showsIndicators) {

            HStack(alignment: .top) {

                ForEach(setUpLIst(), id: \.self) { columnsData in

                    // For Optimized Using LazyStack
                    LazyVStack(spacing: spacing) {

                        ForEach(columnsData) { object in
                            content(object)
                        }
                    }
                }
            }
            // only vertical padding...
            // horizontal padding will be user's optional...
            .padding(.vertical)
        }
    }
}

struct StaggeredGrid_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
