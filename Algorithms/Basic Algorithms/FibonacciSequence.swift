//
//  FibonacciSequence.swift
//  Algorithms
//
//  Created by 유성열 on 7/17/24.
//
// MARK: - 피보나치 수열(FibonacciSequence)
// MARK: 각 숫자가 앞의 두 숫자의 합인 수열(마지막 요소와 마지막 요소 이전의 요소를 더함)

import Foundation

// MARK: - 재귀적 알고리즘(재귀적 피보나치 수열)
// 재귀적으로 피보나치 수열을 구현하는 방법은 간단하지만 비효율적이다.(반복되는 계산이 생기면서 같은 계산이 여러번 반복되는 경우로 성능에 좋지 않고 (스택에 쌓이므로)메모리 낭비가 심함)
// 시간 복잡도는 O(2^n) (입력크기 n에 대해 실행 시간이 기하급수적으로 증가한다. O(2^n)는 호출 트리의 구조 때문에 발생, 각 함수 호출이 두 개의 하위 호출을 발생시키므로 호출의 수가 기하급수적으로 증가)
/*
 ex) n에 5가 들어가는 경우
    - fibonacciRecursive(5) : 1회 호출
    - fibonacciRecursive(4) : 1회 호출
    - fibonacciRecursive(3) : 2회 호출
    - fibonacciRecursive(2) : 3회 호출
    - fibonacciRecursive(1) : 5회 호출
    - fibonacciRecursive(0) : 3회 호출
 
    이렇게 호출 횟수가 매우 많아진다.
 */
/*
 * 과정
 ex) finbonacciRecursive(4)
 
 1. 초기 호출
    - n이 4이므로 fibonacciRecursive(3)과 fibonacciRecursive(2)를 호출
 
 2. 첫 번째 레벨의 재귀 호출
    - fibonacciRecursive(3)은 -> *fibonacciRecursive(2) + fibonacciRecursive(1)을 호출
    - fibonacciRecursive(2)는 -> *fibonacciRecursive(1) + fibonacciRecursive(0)을 호출
 
 3. 두 번째 레벨의 재귀 호출
    - *fibonacciRecursive(2)는 -> fibonacciRecursive(1) + fibonacciRecursive(0)을 호출
    - fibonacciRecursive(1)과 fibonacciRecursive(0)은 각각 1과 0을 반환하며 합산
 
 * 요약 정리
    -> ((fibonacciRecursive(3) -> (fibonacciRecursive(2) -> (1 + 0) = 1)
                            + 1 = 2)
       + (fibonacciRecursive(2) -> 1 + 0 = 1))
    
    -> (결과) (2 + 1) = 3
*/
func fibonacciRecursive(_ n: Int) -> Int {
    if n <= 1 {
        return n
    } else {
        return fibonacciRecursive(n - 1) + fibonacciRecursive(n - 2) // 재귀적으로 피보나치 함수가 호출되고 -1의 값과 -2의 값이 더해지는 재귀가 반복
    }
}

// MARK: - 동적 계획법(Dynamic Programing)
// 중복 계산을 피할 수 있음
// 중복 계산이 없고 시간 복잡도는 O(n)
// [Int](repeating: 0, count: n + 1) 문법을 통해 필요한 크기의 배열을 초기화 한다.

func fibonacciDP(_ n: Int) -> Int {
    if n <= 1 {
        return n
    }
    
    var fib = [Int](repeating: 0, count: n + 1) // Int 배열을 0으로 초기화하고 배열의 개수는 n + 1
    fib[1] = 1 // 초기 값 설정
    
    for i in 2...n { // 배열의 2 인덱스부터 반복(값 계산)
        fib[i] = fib[i - 1] + fib[i - 2]
    }
    return fib[n]
}


// MARK: - 메모이제이션(Memoization)(동적 계획법의 한 형태)
// 메모이제이션을 사용하면 재귀적 접근의 단점을 극복할 수 있다.
// 중복되는 계산을 피하기 위해 이전의 계산한 결과를 저장해서 여러 번 계산하지 않도록 하는 기법(속도는 빠르지만 속도를 위해서 메모리를 사용한다. (메모이제이션 테이블을 저장하기 위한 메모리))
// 재귀적인 피보나치 수열에서는 fibonacciRecursive 함수 호출이 여러 번 발생되어 비효율적
// 중복 계산을 피함으로써 시간 복잡도가 O(n)으로 감소
/*
 * 메모이제이션의 기본 개념
    - 캐싱 : 함수의 결과를 저장하기 위한 캐시 또는 메모이제이션 테이블을 사용
    - 재사용 : 이미 계산된 값이 있으면, 저장된 값을 재사용
    - 계산 : 값이 계산되지 않은 경우에만 계산하고, 그 결과를 캐시에 저장
 
 * 메모이제이션을 사용한 피보나치 수열 :
    - 메모이제이션 테이블 : 계산된 값을 저장할 배열을 만듦
    - 캐시 확인 : 함수가 호출될 때, 먼저 캐시에서 값을 찾는다.
    - 계산 및 저장 : 값이 없으면 계산하고, 그 결과를 캐시에 저장
 
 * 동작 과정 :
    1. 초기 호출 'fibonacci(5)'를 호출하면 'memo' 배열은 '[nil, nil, nil, nil, nil, nil]'로 초기화 됨
    2. 계산 및 저장 :
        - 'fibonacciMemoization(5)'가 호출되면, 'memo[5]'가 'nil'이므로 값을 계산
        - 'fibonacciMemoization(4)'와 'fibonacciMemoization(3)'을 호출하여 각각의 값을 계산하고 'memo'에 저장
        - 이러한 과정이 반복되어 'memo' 배열이 '[0, 1, 1, 2, 3, 5]'로 채워짐
    3. 재사용 : 이후의 호출에서는 'memo' 배열에 저장된 값을 재사용하므로, 중복 계산이 발생하지 않음
*/

func fibonacci(_ n: Int) -> Int {
    // 메모이제이션 테이블 초기화
    var memo = [Int?](repeating: nil, count: n + 1)
    return fibonacciMemoization(n, memo: &memo)
}

private func fibonacciMemoization(_ n: Int, memo: inout [Int?]) -> Int {
    // 캐시 확인
    if let result = memo[n] {
        return result
    }
    
    // 기저 사례
    if n <= 1 {
        memo[n] = n
    } else {
        // 값 계산 및 저장
        memo[n] = fibonacciMemoization(n - 1, memo: &memo) + fibonacciMemoization(n - 2, memo: &memo)
    }
    return memo[n]!
}

















