//
//  SieveOfAtkin.swift
//  Consecutive Primes Distribution
//
//  Created by Norm Norris on 3/18/16.
//  Copyright © 2016 Norm Norris. All rights reserved.
//

import Foundation

class SieveOfAtkin: NSObject {
    
    func SofA(limit: Int) -> [Bool] {
        let limitSqrt = Int(sqrt(Double(limit)))
        
        var sieveList =  Array(count:limit + 1, repeatedValue:false)
        sieveList[0] = false
        sieveList[1] = false
        sieveList[2] = true
        sieveList[3] = true
        
        for x in 1...limitSqrt {
            for y in 1...limitSqrt {
                // first quadractic
                var n = (4 * x * x) + (y * y)
                if n <= limit && (n % 12 == 1 || n % 12 == 5) {
                    sieveList[n] = !sieveList[n]
                }
                
                // second quadractic
                n = (3 * x * x) + (y * y)
                if n <= limit && (n % 12 == 7) {
                    sieveList[n] = !sieveList[n]
                }
                
                // third quadractic
                n = (3 * x * x) - (y * y)
                if x > y && n <= limit && (n % 12 == 11) {
                    sieveList[n] = !sieveList[n]
                }
            }
        }

        if limitSqrt > 5 {
            for n in 5...limitSqrt {
                if sieveList[n] {
                    let x = n * n
                    var i = x
                    while i <= limit {
                        sieveList[i] = false
                        i += x
                    }
                }
             }
        }
        
        return sieveList
    }
    
    func consolidatePrimes(arrayOfBools: [Bool]) -> [Int] {
        var primes = [Int]()
        for (index, value) in arrayOfBools.enumerate() {
            if value == true {
                primes.append(index)
            }
        }
        
        return primes
    }
    
    func printPrimes(arrayOfBools: [Bool]) {
        print("Primes: ")
        for (index, value) in arrayOfBools.enumerate() {
            if value == true {
                print("\(index)", terminator: ", ")
            }
        }
    }
    
    func exportPrimes(arrayOfBools: [Bool]) -> String {
        var primes = "Primes:\n"
        for (index, value) in arrayOfBools.enumerate() {
            if value == true {
                primes.appendContentsOf("\(index), ")
            }
        }
        
        primes = String(primes.characters.dropLast(2))
        
        return primes
    }
}
