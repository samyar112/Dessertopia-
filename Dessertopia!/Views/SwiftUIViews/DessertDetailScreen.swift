//
//  DetailView.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/26/23.
//

import SwiftUI

struct DessertDetailScreen: View {
    @StateObject private var detailViewModel = DetailsViewModel()
    
    let mealId: String?
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    ForEach(detailViewModel.dessert) { meal in
                        ThumbnailView()
                        Divider()
                        InstructionsView()
                        IngredientsView()
                    }
                }
                // injecting this as parent view here. So, all child will have access.
                .environmentObject(detailViewModel)
                .alert(isPresented: $detailViewModel.isErrorShown, content: {
                    errorAlert()
                })
                .onAppear {
                    detailViewModel.fetchMealDetailswith(mealId: mealId ?? EmptyConstant.empty)
                }
            }
            if detailViewModel.isLoading {
                LoadingView()
            }
        }
    }
    
    private func errorAlert() -> Alert {
        Alert(title: Text(EmptyConstant.empty), message: Text(ErrorAlertConstant.alertMessage), primaryButton: .default(Text(ErrorAlertConstant.retryButton), action: {
            DispatchQueue.main.async {
                detailViewModel.fetchMealDetailswith(mealId: mealId ?? EmptyConstant.empty)
            }
        }), secondaryButton: .default(Text(ErrorAlertConstant.cancelButton))
        )
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetailScreen(mealId: "53049")
    }
}
