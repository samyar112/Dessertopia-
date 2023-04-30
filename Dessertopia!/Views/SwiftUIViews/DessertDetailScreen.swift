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
        
        ScrollView {
            ZStack {
                VStack {
                    ForEach(detailViewModel.dessert, id: \.self) { meal in
                        ThumbnailView(mealId: mealId)
                        InstructionsView()
                        IngredientsView()
                    }
                    if detailViewModel.isLoading {
                       LoadingView()
                    }
                }
                .environmentObject(detailViewModel)
                
                .alert(isPresented: $detailViewModel.isErrorShown, content: {
                    errorAlert()
                })
            }
            .onAppear {
                 
                detailViewModel.fetchMealDetailswith(mealId: mealId ?? EmptyConstant.empty)
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

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint:
                        .blue))
                .scaleEffect(3)
                .padding()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
