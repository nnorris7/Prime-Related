//
//  PrimeDistributionStats.swift
//  Consecutive Primes Distribution
//
//  Created by Norm Norris on 3/18/16.
//  Copyright © 2016 Norm Norris. All rights reserved.
//

import Foundation

class PrimeDistributionStats: NSObject {
    
    func calcModTenDistributionStats(primes: [Int]) -> String {
        let n = primes.count
        
        var modTenDM = [0, 0, 0, 0]
        var modTenCDM = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]] // [1[1,3,7,9], 3[1,3,7,9], 7[1,3,7,9], 9[1,3,7,9]]
        
        for var i = 4; i < n - 1; i++ {
            switch primes[i] % 10 {
            case 1:
                modTenDM[0]++
                switch primes[i+1] % 10 {
                case 1:
                    modTenCDM[0][0]++
                case 3:
                    modTenCDM[0][1]++
                case 7:
                    modTenCDM[0][2]++
                case 9:
                    modTenCDM[0][3]++
                default:
                    break
                }
            case 3:
                modTenDM[1]++
                switch primes[i+1] % 10 {
                case 1:
                    modTenCDM[1][0]++
                case 3:
                    modTenCDM[1][1]++
                case 7:
                    modTenCDM[1][2]++
                case 9:
                    modTenCDM[1][3]++
                default:
                    break
                }
            case 7:
                modTenDM[2]++
                switch primes[i+1] % 10 {
                case 1:
                    modTenCDM[2][0]++
                case 3:
                    modTenCDM[2][1]++
                case 7:
                    modTenCDM[2][2]++
                case 9:
                    modTenCDM[2][3]++
                default:
                    break
                }
            case 9:
                modTenDM[3]++
                switch primes[i+1] % 10 {
                case 1:
                    modTenCDM[3][0]++
                case 3:
                    modTenCDM[3][1]++
                case 7:
                    modTenCDM[3][2]++
                case 9:
                    modTenCDM[3][3]++
                default:
                    break
                }
            default:
                break
            }
        }
        
        let sum1 = modTenCDM[0].reduce(0, combine: +)
        let sum2 = modTenCDM[1].reduce(0, combine: +)
        let sum3 = modTenCDM[2].reduce(0, combine: +)
        let sum4 = modTenCDM[3].reduce(0, combine: +)

        let fmt = NSNumberFormatter()
        fmt.numberStyle = .DecimalStyle
        
        var statsResults = "π(x0; 10, 1) = \(fmt.stringFromNumber(modTenDM[0])!), π(x0; 10, 3) = \(fmt.stringFromNumber(modTenDM[1])!), π(x0; 10, 7) = \(fmt.stringFromNumber(modTenDM[2])!), π(x0; 10, 9) = \(fmt.stringFromNumber(modTenDM[3])!), π(x0)= \(fmt.stringFromNumber(n)!)\n"
        statsResults.appendContentsOf("π(x0; 10, (1, 1)) = \(fmt.stringFromNumber(modTenCDM[0][0])!)\nπ(x0; 10, (1, 3)) = \(fmt.stringFromNumber(modTenCDM[0][1])!)\nπ(x0; 10, (1, 7)) = \(fmt.stringFromNumber(modTenCDM[0][2])!)\nπ(x0; 10, (1, 9)) = \(fmt.stringFromNumber(modTenCDM[0][3])!)\n\n")
        statsResults.appendContentsOf("π(x0; 10, (3, 1)) = \(fmt.stringFromNumber(modTenCDM[1][0])!)\nπ(x0; 10, (3, 3)) = \(fmt.stringFromNumber(modTenCDM[1][1])!)\nπ(x0; 10, (3, 7)) = \(fmt.stringFromNumber(modTenCDM[1][2])!)\nπ(x0; 10, (3, 9)) = \(fmt.stringFromNumber(modTenCDM[1][3])!)\n\n")
        statsResults.appendContentsOf("π(x0; 10, (7, 1)) = \(fmt.stringFromNumber(modTenCDM[2][0])!)\nπ(x0; 10, (7, 3)) = \(fmt.stringFromNumber(modTenCDM[2][1])!)\nπ(x0; 10, (7, 7)) = \(fmt.stringFromNumber(modTenCDM[2][2])!)\nπ(x0; 10, (7, 9)) = \(fmt.stringFromNumber(modTenCDM[2][3])!)\n\n")
        statsResults.appendContentsOf("π(x0; 10, (9, 1)) = \(fmt.stringFromNumber(modTenCDM[3][0])!)\nπ(x0; 10, (9, 3)) = \(fmt.stringFromNumber(modTenCDM[3][1])!)\nπ(x0; 10, (9, 7)) = \(fmt.stringFromNumber(modTenCDM[3][2])!)\nπ(x0; 10, (9, 9)) = \(fmt.stringFromNumber(modTenCDM[3][3])!)\n")
        statsResults.appendContentsOf("π(x0) = \(fmt.stringFromNumber(sum1 + sum2 + sum3 + sum4)!)")
        
        print("\(statsResults)")
        
        return statsResults
    }
    
    func calcModThreeDistributionStats(primes: [Int]) -> String {
        let n = primes.count
        
        var modThreeDM = [0, 0]
        var modThreeCDM = [[0, 0], [0, 0]] // (1,1), (1,2), (2,1), (2,2)
        
        // This version calculates the correct distribution of primes as well as the correct distribution of consecutive primes but needs to add an extra check to do both at once.
        // If just the correct consecutive distribution is required, then change the limit of the "for" loop to "n - 1" and remove just the "if" statements in each "case", leaving the "switch"es.
        // If just the correct distribution (and utmost speed) is required, leave the "for" loop as is and remove the entire "if" statements from each "case".
        
        for var i = 0; i < n; i++ {
            switch primes[i] % 3 {
            case 1:
                modThreeDM[0]++
                if i < n - 1 {
                    switch primes[i+1] % 3 {
                    case 1:
                        modThreeCDM[0][0]++
                    case 2:
                        modThreeCDM[0][1]++
                    default:
                        break
                    }
                }
            case 2:
                modThreeDM[1]++
                if i < n - 1 {
                    switch primes[i+1] % 3 {
                    case 1:
                        modThreeCDM[1][0]++
                    case 2:
                        modThreeCDM[1][1]++
                    default:
                        break
                    }
                }
            default:
                break
            }
        }
        
        let sum = modThreeCDM[0].reduce(0, combine: +) + modThreeCDM[1].reduce(0, combine: +)

        let fmt = NSNumberFormatter()
        fmt.numberStyle = .DecimalStyle
        
        var statsResults = "π(x0; 3, 1) = \(fmt.stringFromNumber(modThreeDM[0])!) and π(x0; 3, 2) = \(fmt.stringFromNumber(modThreeDM[1])!), π(x0)= \(fmt.stringFromNumber(n)!)\n"
        statsResults.appendContentsOf("π(x0; 3, (1, 1)) = \(fmt.stringFromNumber(modThreeCDM[0][0])!)\nπ(x0; 3, (1, 2)) = \(fmt.stringFromNumber(modThreeCDM[0][1])!)\nπ(x0; 3, (2, 1)) = \(fmt.stringFromNumber(modThreeCDM[1][0])!)\nπ(x0; 3, (2, 2)) = \(fmt.stringFromNumber(modThreeCDM[1][1])!)\n")
        statsResults.appendContentsOf("π(x0) = \(fmt.stringFromNumber(sum)!)")
        
        print("\(statsResults)")
        
        return statsResults
    }
}
