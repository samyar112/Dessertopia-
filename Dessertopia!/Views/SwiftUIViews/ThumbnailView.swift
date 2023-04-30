//
//  ThumbnailView.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/26/23.
//





import SwiftUI
import WebKit
import SDWebImageSwiftUI

struct ThumbnailView: View {

    @EnvironmentObject private var detailViewModel: DetailsViewModel
    @State private var isNetworkCallSuccessful = false
    let bounds = UIScreen.main.bounds
    let youtubeURL = URL(string: ThumbnailConstants.youtubeURL)!
   
    let mealId: String?

    var body: some View {
        ZStack() {
            ForEach(detailViewModel.dessert, id: \.self) { meal in
                if !meal.strMealThumb.isEmpty {
                    WebImage(url: URL(string: meal.strMealThumb))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: bounds.width - 16, height: 300)
                        .cornerRadius(40)
                        .id(UUID())
                } else {
                    Image(systemName: TableCellConstant.placeHolderImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.gray)
                        .frame(width: bounds.width - 16, height: 300)
                        .cornerRadius(40)
                }

                Button(action: {
                    self.detailViewModel.isPlayButtonTapped.toggle()
                    self.detailViewModel.fetchMealDetailswith(mealId: mealId ?? EmptyConstant.empty)
                }) {
                    Image(systemName: ThumbnailConstants.playImage)
                        .font(.system(size: 64))
                        .foregroundColor(.white)
               }
                .alert(isPresented: $detailViewModel.isErrorShown) {
                    Alert(title: Text(EmptyConstant.empty), message: Text(ErrorAlertConstant.alertMessage))
                }
                .sheet(isPresented: $detailViewModel.isPlayButtonTapped) {
                                   WebView(url: URL(string: meal.strYoutube) ?? youtubeURL)
                              }
            }
        }
    }
}

struct ThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailView(mealId: "53049")
    }
}
