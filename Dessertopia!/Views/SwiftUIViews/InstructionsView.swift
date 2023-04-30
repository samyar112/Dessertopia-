//
//  InstructionsView.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/26/23.
//

import SwiftUI

struct InstructionsView: View {
    @EnvironmentObject private var detailViewModel: DetailsViewModel
    var body: some View {
        VStack {
            ForEach(detailViewModel.dessert, id: \.self) { meal in
                Text(meal.strMeal ?? InstructionConstant.defaultString)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .font(.system(size: 25))
                    .padding()
                Divider()
                Button(action: {
                    self.detailViewModel.isButtonTapped = true
                }) {
                    Text(InstructionConstant.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                }
            }
        }
        .sheet(isPresented: $detailViewModel.isButtonTapped) {
            InstructionScreen()
        }
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
