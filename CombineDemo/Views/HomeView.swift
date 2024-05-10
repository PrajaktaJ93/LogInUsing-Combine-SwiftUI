//
//  HomeView.swift
//  CombineDemo
//
//  Created by Prajakta Jadhav on 09/05/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var model: ValueViewModel
    
    var body: some View {
        VStack {
            TextField("Enter Text", text: self.$model.homeViewText)
                .onChange(of: model.homeViewText) { oldValue, newValue in
                    model.homeViewText = newValue
                }
                .textFieldStyle(.roundedBorder)
                .frame(height: 40)
            
            Text(model.homeViewText)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.green)
            
        }
        .padding(20)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView(model: ValueViewModel())
}
