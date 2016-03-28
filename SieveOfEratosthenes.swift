//
//  SieveOfEratosthenes.swift
//  Consecutive Primes Distribution
//
//  Created by Norm Norris on 3/18/16.
//  Copyright © 2016 Norm Norris. All rights reserved.
//

import Foundation

class SieveOfEratosthenes: NSObject {
    
    // 3rd fastest of the functions that generate primes
    func basic(limit: Int) -> [Bool] {
        var sieveList =  Array(count:limit, repeatedValue:true)
        
        let limitSqrt = Int(sqrt(Double(limit))) + 1
        
        sieveList[0] = false
        sieveList[1] = false
        
        if limitSqrt > 2 {
            for i in 2..<limitSqrt {
                if sieveList[i] == true {
                    let j = i * i
                    for y in j.stride(to: limit, by: i) {
                        sieveList[y] = false
                    }
                }
            }
        }

        return sieveList
    }

    // 2nd fastest (just slightly) of the functions that generate primes
    func basicWhile(limit: Int) -> [Bool] {
        var sieveList =  Array(count:limit, repeatedValue:true)
        
        let limitSqrt = Int(sqrt(Double(limit))) + 1
        
        sieveList[0] = false
        sieveList[1] = false
        
        if limitSqrt > 2 {
            for i in 2..<limitSqrt {
                if sieveList[i] == true {
                    var j = i*i
                    while j < limit {
                        sieveList[j] = false
                        j += i
                    }
                }
            }
        }
        
        return sieveList
    }

    // fastest (just barely) of the functions that generate primes
    func odd(limit: Int) -> [Bool] {
        var sieveList =  Array(count:limit, repeatedValue:true)
        
        let limitSqrt = Int(sqrt(Double(limit))) + 1
        
        var even = 2
        while even < limit {
            sieveList[even] = false
            even += 2
        }

        sieveList[0] = false
        sieveList[1] = false
        sieveList[2] = true
        
        if limit > 3 {
            for i in 3..<limitSqrt {
                if sieveList[i] == true {
                    var j = i*i
                    while j < limit {
                        sieveList[j] = false
                        j += i
                    }
                }
            }
        }
    
        return sieveList
    }

    // this function can only count the number of primes up to limit, it cannot actual provide the primes themselves
    // it is by far the fastest
    func oddChars(limit: Int) -> Int {
        
        // initialize
        let memorySize = (limit - 1) / 2
        var isPrime: Array<CChar> = Array(count: memorySize + 1, repeatedValue: 1)
        let limitSqrt = Int(sqrt(Double(limit))) + 1
        
        // find all primes
        if limit > 3 {
            var i = 3
            while i <= limitSqrt {
                if isPrime[i/2] == 1 {
                    var j = i*i
                    while j < limit {
                        isPrime[j/2] = 0
                        j += 2*i
                    }
                }
                i += 2
            }
        }
        
        // sieve is complete, count primes
        var found = limit >= 2 ? 1 : 0
        for i in 1...memorySize {
            found += Int(isPrime[i])
        }

        return found
    }
    
    func eratosthenesOddSingleBlock(from: Int, to: Int) -> Int {
        
        // initialize
        let memorySize = (to - from + 1) / 2
        var isPrime: Array<CChar> = Array(count: memorySize, repeatedValue: 1)

        // find all primes
        var i = 3
        while i*i <= to {
            
            // skip multiples of 3
            if (i >= 3*3) && (i % 3 == 0) {
                i += 2
                continue
            }
            
            // skip multiples of 5
            if (i >= 5*5) && (i % 5 == 0) {
                i += 2
                continue
            }
           
            // skip multiples of 7
            if (i >= 7*7) && (i % 7 == 0) {
                i += 2
                continue
            }
            
            // skip multiples of 11
            if (i >= 11*11) && (i % 11 == 0) {
                i += 2
                continue
            }

            // skip multiples of 13
            if (i >= 13*13) && (i % 13 == 0) {
                i += 2
                continue
            }
            
            // skip numbers before current slice
            var minJ = ((from + i - 1) / i) * i
            if minJ < (i*i) {
                minJ = i*i
            }
            
            // start value must be odd
            if minJ % 2 == 0 {
                minJ += i
            }
            
            // find all odd non-primes
            var j = minJ
            while j < to {
                let index = j - from
                isPrime[index/2] = 0
                j += 2*i
            }
            
            i += 2
        }
        
        // count primes for this block
        var found = 0
//        Apply.background(memorySize) { i in
        for i in 0..<memorySize {
            found += Int(isPrime[i])
        }
        
        // 2 is not odd -> include on demand
        if from <= 2 {
            found += 1
        }
        
        return found
    }
    
    func eratosthenesBlockwise(lastNumber: Int, sliceSize: Int) -> Int {
        
        var found = 0
        
        // each slice covers [from, to]
        var from = 2
        while from <= lastNumber {
            var to = from + sliceSize
            if to > lastNumber {
                to = lastNumber
            }
            
            found += eratosthenesOddSingleBlock(from, to: to)
            
            from += sliceSize
        }
        
        return found
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
