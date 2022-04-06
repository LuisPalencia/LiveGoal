/*

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
*/

import Foundation
import FirebaseAuth
import AlertToast


enum LoginOption{
    case sessionWithApple
    case emailAndPassword(email: String, password: String)
}

enum AuthenticationType: String {
    
    case signIn
    case signUp
    
    var text: String {
        rawValue.capitalized
    }
    
    var footterText: String {
        switch self{
        case .signIn:
            return "You aren't member yet, sign up"
        case .signUp:
            return "Do you have an account in LiveGoal?"
        }
    }
}

final class LoginViewModel: BaseViewModel, ObservableObject {
    
    
    
    // MARK: - Variables @Published
    @Published var userLogged: User?
    @Published var userAuthenticated = false
    @Published var error: NSError?
    
    @Published var showToast = false
    @Published var alertToast = AlertToast(type: .regular, title: "")
    
    
    private let authenticationData = Auth.auth()
    
    required init() {
        super.init()
        userLogged = authenticationData.currentUser
        authenticationData.addStateDidChangeListener(stateAuthenticationModified)
    }
    

    
    private func stateAuthenticationModified(with auth: Auth, user: User?){
        guard user != self.userLogged else { return }
        self.userLogged = user
    }
    
    // Sign in
    func signIn(with loginOption: LoginOption){
        
        switch loginOption {
        case .sessionWithApple:
            self.userAuthenticated = true
            self.error = nil
            print("Login con Apple")
        case let .emailAndPassword(email, password):
            let result = Utils.checkValidEmail(email: email)

            guard result else {
                self.error = NSError(domain: "", code: 9210, userInfo: [NSLocalizedDescriptionKey: "You must enter a valid email address"])
                self.alertToast = AlertToast(type: .error(.red), title: "Error", subTitle: "You must enter a valid email address")
                self.showToast.toggle()
                return
            }
            
            self.userAuthenticated = true
            self.error = nil
            
            authenticationData.signIn(withEmail: email,
                                      password: password,
                                      completion: handlerSignInCompletion)
        }
    }
    
    // Sign up
    func signUp(email: String, password: String, passwordConfirmation: String){
        // Check if email is correct
        let result = Utils.checkValidEmail(email: email)
        
        guard result else {
            self.error = NSError(domain: "", code: 9210, userInfo: [NSLocalizedDescriptionKey: "You must enter a valid email address"])
            self.alertToast = AlertToast(type: .error(.red), title: "Error", subTitle: "You must enter a valid email address")
            self.showToast.toggle()
            return
        }
        
        // check if passwords are the same
        
        guard password == passwordConfirmation else {
            self.error = NSError(domain: "", code: 9210, userInfo: [NSLocalizedDescriptionKey: "Password and confirmation password are not the same"])
            self.alertToast = AlertToast(type: .error(.red), title: "Error", subTitle: "Password and confirmation password are not the same")
            self.showToast.toggle()
            return
        }
        
        // Check if the passwords have a minimun lentgh
        
        guard password.count > 6 else {
            self.error = NSError(domain: "", code: 9210, userInfo: [NSLocalizedDescriptionKey: "The password must be at least 7 characters long"])
            self.alertToast = AlertToast(type: .error(.red), title: "Error", subTitle: "The password must be at least 7 characters long")
            self.showToast.toggle()
            return
        }
        
        self.userAuthenticated = true
        self.error = nil
        authenticationData.createUser(withEmail: email, password: password, completion: handlerSignUpCompletion)
    }
    
    // Logout
    func logoutSession(){
        do {
            try authenticationData.signOut()
        }catch {
            self.error = NSError(domain: "", code: 9999, userInfo: [NSLocalizedDescriptionKey: "El usuario no ha logrado cerrar la sesion"])
        }
    }
    
    // Handlers
    private func handlerSignInCompletion(with auth: AuthDataResult?, and error: Error?){
        DispatchQueue.main.async {
            self.userAuthenticated = false
            if let user = auth?.user {
                self.userLogged = user
                //self.alertToast = AlertToast(type: .complete(.green), title: "Success!", subTitle: "Welcome again!")
                //self.showToast.toggle()
            }else if let errorUnw = error {
                self.error = errorUnw as NSError
                self.alertToast = AlertToast(type: .error(.red), title: "Error", subTitle: "Credentials are not correct")
                self.showToast.toggle()
            }
        }
    }
    
    // Handlers
    private func handlerSignUpCompletion(with auth: AuthDataResult?, and error: Error?){
        DispatchQueue.main.async {
            self.userAuthenticated = false
            if let user = auth?.user {
                self.userLogged = user
                self.alertToast = AlertToast(type: .complete(.green), title: "Success!", subTitle: "Account created successfully")
                self.showToast.toggle()
            }else if let errorUnw = error {
                self.error = errorUnw as NSError
                self.alertToast = AlertToast(type: .error(.red), title: "Error", subTitle: "An error ocurred when trying to create the account")
                self.showToast.toggle()
            }
        }
    }
    
//    private func handlerAuthenticationState(with auth: AuthDataResult?, and error: Error?){
//        DispatchQueue.main.async {
//            self.userAuthenticated = false
//            if let user = auth?.user {
//                self.userLogged = user
//            }else if let errorUnw = error {
//                self.error = errorUnw as NSError
//            }
//        }
//    }
}


