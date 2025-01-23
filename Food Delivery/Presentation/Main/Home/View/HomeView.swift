//
//  HomeView.swift

//

import SwiftUI
import NavigationBackport


struct HomeView: View {
    @State private var search: String = ""
    @State private var filteredCategories: [[String]] = [
        ["Fruit", "Vegetable", "Dairy"],
        ["Meat & Fish", "Ingredient & Spices", "Grains"]
    ]

    let allCategories: [[String]] = [
        ["Fruit", "Vegetable", "Dairy"],
        ["Meat & Fish", "Ingredient & Spices", "Grains"]
    ]

    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 20) {
                // Search Bar
                TextField("Search...", text: $search)
                    .frame(height: 54)
                    .padding(.leading, 60)
                    .background(Color.theme.fieldBackground)
                    .cornerRadius(50)
                    .overlay(
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.theme.label)
                            .frame(width: 20, height: 20)
                            .padding(.leading, 20),
                        alignment: .leading
                    )
                    .overlay(
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.theme.label)
                            .frame(width: 20, height: 20)
                            .padding(.trailing, 20),
                        alignment: .trailing
                    )
                    .onChange(of: search) { newValue in
                        filterCategories()
                    }

                // Inventory Heading
                Text("Inventory")
                    .font(.custom("Satoshi-Bold", size: 24))
                    .foregroundColor(.theme.label)

                // Filtered Inventory Categories
                VStack(spacing: 20) {
                    ForEach(filteredCategories, id: \ .self) { row in
                        InventoryCategoryRow(categories: row)
                    }
                }

                Spacer()

                // Let's Cook Button
                Button(action: {
                    // Action for the Let's Cook button
                }) {
                    Text("Let’s Cook")
                        .font(.custom("Satoshi-Bold", size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color(red: 0.99, green: 0.36, blue: 0.41)) // #FD5D69
                        .cornerRadius(12)
                }
            }
            .padding()
        }
    }

    private func filterCategories() {
        guard !search.isEmpty else {
            filteredCategories = allCategories
            return
        }

        let lowercasedSearch = search.lowercased()
        filteredCategories = allCategories.map { row in
            row.filter { category in
                category.lowercased().contains(lowercasedSearch)
            }
        }.filter { !$0.isEmpty }
    }
}

struct InventoryCategoryRow: View {
    let categories: [String]

    var body: some View {
        HStack(spacing: 20) {
            ForEach(categories, id: \ .self) { category in
                VStack {
                    Image(systemName: iconForCategory(category))
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .background(
                            Circle()
                                .foregroundColor(Color.theme.fieldBackground)
                        )
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)

                    Text(category)
                        .font(.custom("Satoshi-Regular", size: 14))
                        .foregroundColor(.theme.label)
                }
            }
        }
    }

    private func iconForCategory(_ category: String) -> String {
        switch category {
        case "Fruit": return "applelogo"
        case "Vegetable": return "leaf"
        case "Dairy": return "carton"
        case "Meat & Fish": return "hare"
        case "Ingredient & Spices": return "leaf.arrow.circlepath"
        case "Grains": return "circle.grid.3x3"
        default: return "questionmark"
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewLayout(.sizeThatFits)
    }
}


extension HomeView {
    var loadingView: some View {
        ProgressView()
            .frame(height: 50)
            .frame(maxWidth: .infinity,alignment: .center)
    }
}
