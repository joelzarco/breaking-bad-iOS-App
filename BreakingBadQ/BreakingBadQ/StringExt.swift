//
//  StringExt.swift
//  BreakingBadQ
//
//  Created by Sergio J. on 02/09/25.
//

extension String{
    func removeSpaces() -> String{
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    func removeCaseAndSpaces() -> String{
        return self.removeSpaces().lowercased()
    }
}
