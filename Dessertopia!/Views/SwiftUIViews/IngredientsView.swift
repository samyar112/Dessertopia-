//
//  IngredientsView.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/26/23.
//

import SwiftUI

struct IngredientsView: View {
    
    @EnvironmentObject private var detailViewModel: DetailsViewModel
    var body: some View {
        LazyVStack {
            Text(IngredientConstant.title)
                .font(.system(size: 20))
                .fontWeight(.bold)
            ForEach(detailViewModel.flattenedIngredients, id: \.id) { ingredient in
                HStack(alignment: .firstTextBaseline) {
                    Circle()
                        .foregroundColor(.black)
                        .frame( height: 4)
                    Text(ingredient.measure)
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    Text(ingredient.name)
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                }
            }
        }
        Spacer()
    }
}
struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
    }
}


