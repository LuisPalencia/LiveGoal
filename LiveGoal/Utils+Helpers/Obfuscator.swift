//
//  Obfuscator.swift
//  NEOL
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/10/21.
//  Copyright © 2021 everis. All rights reserved.
//

import Foundation

final class Dummy {
    
}

final class Obfuscator {
    
    // MARK: - Variables
    var salt: String
    
    // MARK: - Initialization
    init() {
        self.salt = "\(String(describing: Dummy.self))\(String(describing: NSObject.self))"
    }
    
    init(with salt: String) {
        self.salt = salt
    }
    
    
    // MARK: - Instance Methods
    func bytesByObfuscatingString(string: String) -> [UInt8] {
        let text = [UInt8](string.utf8)
        let cipher = [UInt8](self.salt.utf8)
        let length = cipher.count
        
        var encrypted = [UInt8]()
        
        for t in text.enumerated() {
            encrypted.append(t.element ^ cipher[t.offset % length])
        }
        
        #if DEVELOPMENT
        print("Salt used: \(self.salt)\n")
        print("Swift Code:\n************")
        print("// Original \"\(string)\"")
        print("let key: [UInt8] = \(encrypted)\n")
        #endif
        
        return encrypted
    }
    

    func reveal(key: [UInt8]) -> String {
        let cipher = [UInt8](self.salt.utf8)
        let length = cipher.count
        
        var decrypted = [UInt8]()
        
        for k in key.enumerated() {
            decrypted.append(k.element ^ cipher[k.offset % length])
        }
        
        return String(bytes: decrypted, encoding: .utf8)!
    }
}
