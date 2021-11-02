//
//  ViewModel.swift
//  BongoCodeTest
//
//  Created by S.M.Moinuddin on 11/2/21.
//

import Foundation
import Alamofire
import SwiftSoup

struct ViewModel {
    
    func getEveryNthCharacter(from txt:String, n:Int) -> String {
        var stringArr = [String]()
        
        for i in 1...txt.count where i%n == 0 {
            stringArr.append("\(txt[i-1]) ") //as array start with 0th index
        }
        var joinedStr = stringArr.joined()
        joinedStr.removeLast() //remove the last spaces added in above logic. 
        return joinedStr
    }
    
    private func getWordsCount(text:String) -> String {
        let freqMap = getFreqMap(text)
        
        var stringArr = [String]()
        // Traverse through map and print frequencies
        for key in freqMap.keys {
            stringArr.append("\(key) : \(freqMap[key]!)\n")
        }
        return stringArr.joined()
    }
    
    ///count of every word that occurred on the Text
    func getFreqMap(_ text:String) -> [String: Int] {
        let words = scrutinizedWords(text)
        return countFreq(words)
    }
    
    ///clerars the data to get proper word.
    private func scrutinizedWords(_ txt:String) -> [String] {
        let words = txt.components(separatedBy: " ")
        var onlyWords = [String]()
        for var word in words {
            let removeCharacters: Set<Character> = [",", ".", "?", "!", ";", "(", ")", "\"", "'", "“", "”", "‘", "’"]
            let removeCharForLink: Set<Character> = [",", "!", ";", "(", ")", "\"", "'", "“", "”", "‘", "’"]
            if(!word.contains("http") || !word.contains("www")) {
                word.removeAll(where: { removeCharacters.contains($0) } )
            }else {
                word.removeAll(where: { removeCharForLink.contains($0) } )
            }
            onlyWords.append(word.lowercased())
        }
        return onlyWords
    }
    
    ///find the multiple occurance frequency of a element in the array
    private func countFreq(_ arr: [String]) -> [String: Int] {
        var map = [String: Int]()
        let length = arr.count
        
        // Traverse through array elements and
        // count frequencies
        for i in 0..<length {
            if(map.keys.contains(arr[i])) {
                map[arr[i]] = (map[arr[i]] ?? 0) + 1
            }else {
                map[arr[i]] = 1
            }
        }
        return map
    }
    
    ///combine 3 results to show together
    private func prepareDisplayText(_ txt:String) -> String {
        var combinedTxt = "Last Character: \(txt.last!)\n\n"
        combinedTxt += "Every 10th Character:\n\n"
        combinedTxt += getEveryNthCharacter(from: txt, n: 10)
        combinedTxt += "\n\n"
        combinedTxt += "Frequency of Word:\n\n"
        combinedTxt += getWordsCount(text: txt)
        print(combinedTxt) //as asked on the codeTest questions. 
        return combinedTxt
    }
    
}

extension ViewModel {
    func fetchData(completion: @escaping (String)->()) {
        AF.request("https://www.bioscopelive.com/en/tos", method: .get)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    guard let contents = String(data: data, encoding: .utf8) else{
                        completion("Unable to get data")
                        return
                    }
                    let text = parseHTML(contents)
                    let displayText = prepareDisplayText(text)
                    completion(displayText)
                case .failure(let error):
                    print(error)
                    completion(error.localizedDescription)
                }
            }
    }
    
    ///get all the text form html page
    private func parseHTML(_ html:String) -> String {
        do {
            let doc: Document = try SwiftSoup.parse(html)
            let text: String = try doc.body()!.text()
            return text
            
        } catch Exception.Error(let type, let message) {
            print("error type = \(type)")
            print(message)
            return "exception while trying to parse"
            
        } catch {
            print("error")
            return "unable to parse"
            
        }
    }
}

