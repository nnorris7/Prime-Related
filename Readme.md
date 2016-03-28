# Prime Generator and Distribution Statistics Classes
[![](http://img.shields.io/badge/OS%20X-10.10%2B-blue.svg)]() [![](http://img.shields.io/badge/iOS-8.0%2B-blue.svg)]() [![](http://img.shields.io/badge/Swift-2.2-blue.svg)]()



Swift classes that perform the Sieve of Atkin and the Sieve of Eratosthenes. There is an additional class that will calculate prime distribution statistics.

### Install
Download or clone to your Desktop and then drag the relevant file(s) into your project.

### Usage - Generating Primes
There are multiple versions of each sieve available for use/experimentation. Both sieve of Atkin options function as described below. This is also true for the first 3 variants of the sieve of Eratosthenes (basic, basicWhile, odd).

Both sieve classes take an `Int` as a function argument and return an array of `Bool` for which the prime numbers are marked as `true`. Each class also contains functions to print the prime numbers to the console, "consolidate" them into an array of `Int`, and "export" them as a `String`.

To generate all prime numbers up to 1,000 using the Sieve of Atkin/Eratosethenes and print them to the console, add the following to `main` or your `ViewController`.

```swift
let limit = 1000
var boolListOfPrimes = [Bool]()

boolListOfPrimes = SieveOfAtkin().basic(limit)
SieveOfAtkin().printPrimes(boolListOfPrimes)

// or

boolListOfPrimes = SieveOfEratosthenes().basic(limit)
SieveOfEratosthenes().printPrimes(boolListOfPrimes)
```

#####NB: The prime-counting function grows exponentially! Generating millions of primes could take several minutes or (quite a bit) more, depending on the speed of your computer.

The final 2 versions of the Sieve of Eratosthenes, while they can count the number of primes up to a given limit very quickly, they do not generate the prime numbers themselves. So if you are not displaying the actual primes or calculating the distribution statistics, these to versions provide significantly faster variations. The "odd" version takes an integer and returns an integer. The "eratosthenesBlockwise" takes 2 integers, the limit and the slice size, and returns an integer.

```swift
let limit = 1000
var primes = [Int]()

primes = SieveOfEratosthenes().odd(limit)
print("Number of primes: "\(primes)")

// or

let sliceSize = 128 * 1024
primes = SieveOfEratosthenes().eratosthenesBlockwise(limit, sliceSize: sliceSize)
print("Number of primes: "\(primes)")
```
You can adjust the `sliceSize` to obtain the best results for your machine.

### Usage - Calculating Distribution Statistics
The distribution stats class currently only handles modulo 3 and modulo 10. It calculates the number of primes for the reduced residual class (mod q) as well as the distribution of pairs of consecutive primes among the permissible ϕ(q)<sup>2</sup>  pairs of the reduced residual classes (mod q). This class' functions require the consolidated array of primes of type `Int` as their argument.

```swift
let primes = SieveOfAtkin().consolidatePrimes(boolListOfPrimes)
let primeDistStatsString = PrimeDistributionStats().calcModThreeDistributionStats(primes)
```

### Improvements
While both sieve classes include some optimization, I'm sure further "tweaks" are possible. Report an issue to leave feedback on the algorithms themselves, or submit a pull request. 

### License
The MIT License (MIT)

Copyright (c) 2016 Norman Norris

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
