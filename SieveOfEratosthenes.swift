//
//  SieveOfEratosthenes.swift
//  Consecutive Primes Distribution
//
//  Created by Norm Norris on 3/18/16.
//  Copyright © 2016 Norm Norris. All rights reserved.
//

import Foundation

class SieveOfEratosthenes: NSObject {
    
    func SofE(limit: Int) -> [Bool] {
        var sieveList =  Array(count:limit, repeatedValue:true)
        
        let limitSqrt = Int(sqrt(Double(limit))) + 1
        
        sieveList[0] = false
        sieveList[1] = false
        
        for i in 2..<limitSqrt {
            if sieveList[i] == true {
                for var j = i*i; j < limit; j += i {
                    sieveList[j] = false
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