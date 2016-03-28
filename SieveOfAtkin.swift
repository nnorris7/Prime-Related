//
//  SieveOfAtkin.swift
//  Consecutive Primes Distribution
//
//  Created by Norm Norris on 3/18/16.
//  Copyright © 2016 Norm Norris. All rights reserved.
//

import Foundation

class SieveOfAtkin: NSObject {
    
    func basic(limit: Int) -> [Bool] {
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
    
    func wiki(limit: Int) -> [Bool] {
        let s = [1, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 49, 53, 59]
        
        let limitSqrt = Int(sqrt(Double(limit))) + 1
        
        var sieveList =  Array(count:limit + 1, repeatedValue:false)
        sieveList[0] = false
        sieveList[1] = false
        sieveList[2] = true
        sieveList[3] = true
        sieveList[4] = false
        sieveList[5] = true
        
        // first quadratic
        for x in 1 ..< (limitSqrt/2 + 1) {
            var y = 1
            y_loop: while y < limitSqrt {
                let n = (4 * x * x) + (y * y)
                if n < limit {
                    switch n % 60 {
                    case 1, 13, 17, 29, 37, 41, 49, 53:
                        sieveList[n] = !sieveList[n]
                    default:
                        break
                    }
                }
                else {
                    break y_loop
                }
                y += 2
            }
        }
        
        // second quadratic
        var x = 1
        while x < limitSqrt {
            var y = 2
            while y < limitSqrt {
                let n = (3 * x * x) + (y * y)
                if n < limit {
                    switch n % 60 {
                    case 7, 19, 31, 43:
                        sieveList[n] = !sieveList[n]
                    default:
                        break
                    }
                }
                y += 2
            }
            x += 2
        }
        
        // third quadratic
        for x in 2 ..< limitSqrt {
            var y = x - 1
            while y > 0 {
                let n = (3 * x * x) - (y * y)
                if n < limit {
                    switch n % 60 {
                    case 11, 23, 47, 59:
                        sieveList[n] = !sieveList[n]
                    default:
                        break
                    }
                }
                y -= 2
            }
        }
        
        for w in 0 ..< (limitSqrt/60 + 1) {
            for i in 0 ..< 16 {
                let n = 60 * w + s[i]
                if n >= 7 && n * n <= limit {
                    if sieveList[n] {
                        ww_loop: for ww in 0..<(limit/60) {
                            for j in 0 ..< 16 {
                                let c = n * n * (60 * ww + s[j])
                                if c <= limit {
                                    sieveList[c] = false
                                }
                                else {
                                    break ww_loop
                                }
                            }
                        }
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
