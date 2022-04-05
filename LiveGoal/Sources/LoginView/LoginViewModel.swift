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

// Output del Interactor
protocol LoginInteractorOutputProtocol: BaseInteractorOutputProtocol {
    
}

final class LoginViewModel: BaseViewModel, ObservableObject {
    
    // MARK: - DI
    var interactor: LoginInteractorInputProtocol?{
        super.baseInteractor as? LoginInteractorInputProtocol
    }
    
    // MARK: - Variables @Published
    
    
    // MARK: - Metodospublicos
    func fetchData(){
        
    }
    
}

// Output del Interactor
extension LoginViewModel: LoginInteractorOutputProtocol {
    
}


