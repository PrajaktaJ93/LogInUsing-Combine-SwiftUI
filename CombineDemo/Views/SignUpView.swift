//
//  SignUpView.swift
//  CombineDemo
//
//  Created by Prajakta Jadhav on 09/05/24.
//

import SwiftUI


struct SignUpView: View {
    @StateObject var model = ValueViewModel()
    
    @State var warningLabel = ""
    @State var doesHideWarning = true
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Form {
                    Section {
                        
                        TextField("Enter Name", text: $model.userName)
                            .onChange(of: model.userName) { oldValue, newValue in
                                if !model.isNamevalid {
                                    warningLabel = "Name is not valid."
                                    doesHideWarning = false
                                } else {
                                    warningLabel = ""
                                    doesHideWarning = true
                                }
                            }
                        
                        
                        TextField("Enter Email", text: $model.email)
                            .keyboardType(.emailAddress)
                            .onChange(of: model.email) { oldValue, newValue in
                                if !model.isemailvalid {
                                    warningLabel = "Email is not valid."
                                    doesHideWarning = false
                                } else {
                                    warningLabel = ""
                                    doesHideWarning = true
                                }
                            }
                        
                        
                        SecureField("Enter Password", text: $model.password)
                            .onChange(of: model.password) { oldValue, newValue in
                                if !model.ispasswordvalid {
                                    warningLabel = "Password is not valid."
                                    doesHideWarning = false
                                } else {
                                    warningLabel = ""
                                    doesHideWarning = true
                                }
                            }
                        
                        SecureField("Confirm Password", text: $model.confirmPassword)
                            .onChange(of: model.confirmPassword) { oldValue, newValue in
                                if !model.ispasswordmatches {
                                    warningLabel = "Password does not match."
                                    doesHideWarning = false
                                } else {
                                    warningLabel = ""
                                    doesHideWarning = true
                                }
                            }
                        
                    }
                    Section {
                        if !doesHideWarning {
                            Text(warningLabel)
                        }
                        
                        NavigationLink( destination: HomeView(model: self.model)) {
                            Text("Sign Up")
                        }
                        .padding()
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .opacity(buttonOpacity)
                        .disabled(!model.formIsValid)
                        
                    }
                }
            }
        }
        var buttonOpacity: Double {
            return model.formIsValid ? 1 : 0.5
        }
    }
}

#Preview {
    SignUpView()
}
