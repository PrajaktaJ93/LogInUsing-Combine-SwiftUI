//
//  ValueViewModel.swift
//  CombineDemo
//
//  Created by Prajakta Jadhav on 09/05/24.
//

import Foundation
import Combine

class ValueViewModel: ObservableObject {
    
    @Published var homeViewText = ""
    
    @Published var userName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var isNamevalid = false
    @Published var isemailvalid = false
    @Published var ispasswordvalid = false
    @Published var ispasswordmatches = false
    
    @Published var formIsValid = false
    
    private var cancellable = Set<AnyCancellable>()
    private var publishers = Set<AnyCancellable>()
    
    var isNameValidPublisher: AnyPublisher<Bool, Never> {
        $userName
            .map { name in
                let namePredicate = NSPredicate(format:"SELF MATCHES %@", "([A-Za-z ]+)")
                return namePredicate.evaluate(with: name)
            }
            .eraseToAnyPublisher()
    }
    
    var isUserEmailValidPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { email in
                let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                return emailPredicate.evaluate(with: email)
            }
            .eraseToAnyPublisher()
    }
    
    var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $password
            .map { password in
                return password.count >= 8
            }
            .eraseToAnyPublisher()
    }
    
    var passwordMatchesPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $confirmPassword)
            .map { password, repeated in
                return password == repeated
            }
            .eraseToAnyPublisher()
    }
    
    var isSignupFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(
            isNameValidPublisher,
            isUserEmailValidPublisher,
            isPasswordValidPublisher,
            passwordMatchesPublisher)
        .map { isNameValid, isEmailValid, isPasswordValid, passwordMatches in
            return isNameValid && isEmailValid && isPasswordValid && passwordMatches
        }
        .eraseToAnyPublisher()
    }
    
    init() {
        
        isSignupFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.formIsValid, on: self)
            .store(in: &publishers)
        
        isNameValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isNamevalid, on: self)
            .store(in: &publishers)
        
        isUserEmailValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isemailvalid, on: self)
            .store(in: &publishers)
        
        isPasswordValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.ispasswordvalid, on: self)
            .store(in: &publishers)
        
        passwordMatchesPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.ispasswordmatches, on: self)
            .store(in: &publishers)
        
    }
    
}
