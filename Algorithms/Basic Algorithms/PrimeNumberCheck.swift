//
//  PrimeNumberCheck.swift
//  Algorithms
//
//  Created by 유성열 on 7/18/24.
//
// MARK: - 소수 판별(Prime Number Check)
// 1과 자기 자신만으로 나누어 떨어지는 1보다 큰 양의 정수
// 주어진 숫자가 소수인지 판별하는 알고리즘

import Foundation

// 모든 숫자를 확인하므로 약간 비효율적
func isPrime(_ number: Int) -> Bool {
    if number <= 1 {
        return false
    }
    
    // 2부터 ~ 자신-1 까지 숫자로 나누어 떨어진다면, 즉 다른 수로 나누어 떨어지면 소수가 아님 -> false
    for i in 2..<number {
        if number % i == 0 {
            return false
        }
    }
    return true
}


// 개선된 소수 판별
func isPrime(number: Int) -> Bool {
    // 1이하는 소수가 아니므로 false
    if number <= 1 {
        return false
    }
    
    // 2와 3은 소수이므로 true
    if number <= 3 {
        return true
    }
    
    // 2와 3으로 나눠 0으로 떨어지는 경우 소수가 아니므로 false
    if number % 2 == 0 || number % 3 == 0 {
        return false
    }
    
    // i를 5부터 증가시키며 검사(i * i <= number 조건을 사용하여 i가 number의 제곱근보다 작거나 같을 때까지 반복)
    var i = 5
    while i * i <= number {
        if number % i == 0 || number % (i + 2) == 0 {
            return false
        }
        i += 6 // i는 6씩 증가(2와 3으로 나누어 떨어지는 경우를 제외하고 더 효율적으로 소수 검사하기 위함)
    }
    return true
}
