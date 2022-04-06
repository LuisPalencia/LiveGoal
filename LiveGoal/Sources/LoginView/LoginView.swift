//
//  LoginView.swift
//  LiveGoal
//
//  Created by CICE on 04/04/2022.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var viewModelSession: LoginViewModel
    @State var authType: AuthenticationType
    
    @State var email: String = ""
    @State var password = ""
    @State var confirmationPassword = ""
    @State var showPassword = false
    
    var body: some View {
        ZStack{
            VStack(spacing: 30, content: {
               
                Image("la_liga_logo_v")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    //.frame(width: 200, height: 200)
                    .padding(20)
                    //.padding(.horizontal, 20)
                    //.clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
//                    .overlay(
//                        Circle()
//                            .stroke(Color.blue.opacity(0.7), lineWidth: 4)
//                    )
//                    .padding(20)
                    
                Text("Welcome to LiveGoal")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom, 10)
                    .foregroundColor(.gray)
                
                if !self.viewModelSession.userAuthenticated {
                    VStack(spacing: 20, content: {
                        TextField("Email", text: self.$email)
                            .textFieldLoginStyle()
                        
                        
                        if showPassword {
                            TextField("Password",
                                            text: self.$password)
                                .textFieldLoginStyle()
                        }else{
                            SecureField("Password",
                                                  text: self.$password)
                                .textFieldLoginStyle()
                        }
                        
                        
                        if authType == .signUp {
                            if showPassword {
                                TextField("Confirmation Password",
                                                text: self.$confirmationPassword)
                                    .textFieldLoginStyle()
                            }else{
                                SecureField("Confirmation Password",
                                                      text: self.$confirmationPassword)
                                    .textFieldLoginStyle()
                            }
                        }
                        
                        Toggle("Show password", isOn: self.$showPassword)
                            .padding()
                            .foregroundColor(.gray)
                            .font(.headline)
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: 50)
                        
                        
                        // Button de login / registro
                        Button(action: {
                            self.authEmailTouched()
                        }, label: {
                            Text(self.authType.text)
                                .loginButtonStyle()
                        })
                        .foregroundColor(.gray)
                        //.padding()
                        
                        Button(action: {
                            self.footerTouched()
                        }, label: {
                            Text(self.authType.footterText)
                                .loginButtonStyle()
                        })
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                    })
                }
            })
        }
    }
    
    private func authEmailTouched(){
        switch authType {
        case .signIn:
            self.viewModelSession.signIn(with: .emailAndPassword(email: self.email, password: self.password))
        case .signUp:
            self.viewModelSession.signUp(email: self.email, password: self.password, passwordConfirmation: self.confirmationPassword)
        }
    }
    
    private func footerTouched(){
        self.authType = authType == .signUp ? .signIn : .signUp
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authType: .signIn)
    }
}
