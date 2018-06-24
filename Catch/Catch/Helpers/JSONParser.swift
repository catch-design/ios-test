//
//  JSONParser.swift
//  Catch
//
//  Created by Nandika Johann Weerasuriya on 6/24/18.
//  Copyright © 2018 NandikaWeerasuriya. All rights reserved.
//

import Foundation
import Foundation

enum ParsingError: Error {
    
    case typeMismatch
    case dataCorrupted
    case keyNotFound
    case valueNotFound
    case errorUnknown
    
    var localizedDescription: String {
        switch self {
        case .typeMismatch: return "Given type could not be decoded because it did not match the type of what was found in the encoded payload."
        case .dataCorrupted: return "Data is corrupted or otherwise invalid."
        case .keyNotFound: return "Keyed decoding container was asked for an entry for the given key, but did not contain one."
        case .valueNotFound: return "Non-optional value of the given type was expected, but a null value was found."
        case .errorUnknown: return "Parsing Error."
        }
    }
}

class JSONParse {
    let jsonDecoder = JSONDecoder()
    
    /// Generic JSON parser using JSON decode
    ///
    /// - Parameters:
    ///   - data: Recived Data from api(Http response)
    ///   - decodingType: Generic Object to map
    /// - Returns: Results with generic object or parsing error
    
    func parse<T: Codable>(data: Data, decodingType: T.Type) -> (Result<[T]>) {
        let objectType = [T].self
        
        do {
            let genericModel = try jsonDecoder.decode(objectType, from: data)
            // return genericModel
            return (.success(genericModel))
            
        } catch let DecodingError.typeMismatch(type, context) {
            print("\(type) was expected,DecodingError.typeMismatch: \(context.debugDescription)")
            print("DecodingError.Context: codingPath:")
            for i in 0..<context.codingPath.count { print("  [\(i)] = \(context.codingPath[i])") }
            
            return (.failure(ParsingError.typeMismatch))
        } catch let DecodingError.valueNotFound(_, context) {
            print("DecodingError.valueNotFound: \(context.debugDescription)")
            return (.failure(ParsingError.valueNotFound))
            
        } catch let DecodingError.dataCorrupted(context) {
            print("DecodingError.dataCorrupted: \(context.debugDescription)")
            return (.failure(ParsingError.dataCorrupted))
            
        } catch let DecodingError.keyNotFound(key, context) {
            print("\(key.stringValue) was not found, \(context.debugDescription)")
            return (.failure(ParsingError.keyNotFound))
        } catch {
            print("ERROR- ", error)
            return (.failure(ParsingError.errorUnknown))
        }
    }
}
