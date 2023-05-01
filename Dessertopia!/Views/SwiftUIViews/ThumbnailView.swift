//
//  ThumbnailView.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/26/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ThumbnailView: View {
    
    @EnvironmentObject private var detailViewModel: DetailsViewModel
    private let bounds = UIScreen.main.bounds
    
    var body: some View {
        LazyVStack() {
            ForEach(detailViewModel.dessert) { meal in
                if !meal.strMealThumb.isEmpty {
                    WebImage(url: URL(string: meal.strMealThumb))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: bounds.width - 16, height: 250)
                        .cornerRadius(40)
                } else {
                    Image(systemName: TableCellConstant.placeHolderImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.gray)
                        .frame(width: bounds.width - 16, height: 300)
                        .cornerRadius(40)
                }
                Text(meal.strMeal ?? EmptyConstant.empty)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .font(.system(size: 25))
                    .padding()
            }
        }
    }
}

struct ThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailView()
    }
}
