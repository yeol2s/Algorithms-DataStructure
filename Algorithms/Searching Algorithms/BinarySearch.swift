//
//  BinarySearch.swift
//  Algorithms
//
//  Created by 유성열 on 7/15/24.
//
// MARK: - 이진 탐색(Binary Search)
// MARK: 이진 탐색은 정렬된 배열에서 빠르게 효율적으로 값을 찾는 알고리즘(데이터 구조가 '정렬된 배열'에 효율적이라는 것이 중요함)
// MARK: 빠른 검색이 필요한 경우에 사용되며, 효율적이고 큰 데이터셋에도 빠르게 작동한다. (하지만 배열이 정렬되어 있을 때에 해당)
// 이진 탐색은 배열의 중간 요소와 목표 값을 비교하여 탐색 범위를 절반으로 줄여가며 진행된다.
// 시간 복잡도는 O(log n)이다.(탐색 범위가 매 단계마다 절반으로 줄어들기 때문에)(log n은 이진 탐색 알고리즘이 목표 값을 찾기 위해 배열의 요소들을 몇 번 비교하는지를 비교 연산 횟수를 나타냄)
// 이진 탐색은 정렬된 배열에서 매우 효율적이므로, 특정 값을 찾는 작업이 빈번히 필요하다면, 배열을 정렬한 후 이진 탐색을 사용하는 것이 유리하다.

/*
 * 이진 탐색 알고리즘 개념
    1. 정렬된 배열에서 중간 요소를 찾는다.
    2. 중간 요소와 목표 값을 비교합니다.
        - 중간 요소가 목표 값과 같으면 탐색을 종료하고 해당 인덱스를 반환
        - 중간 요소가 목표 값보다 크면, 탐색 범위를 배열의 왼쪽 절반으로 줄임
        - 중간 요소가 목표 값보다 작으면, 탐색 범위를 배열의 오른쪽 절반으로 줄임
    3. 탐색 범위가 없을 때까지 위 1~2 과정을 반복한다. 목표 값을 찾기 못하면 nil을 반환
 */

import Foundation

// array: 이진 탐색을 수행할 '정렬된 배열', target: 찾고자 하는 '목표 값', 반환값은 '찾고자 하는 목표 값의 인덱스 or nil'
// 배열의 요소가 비교 가능하도록 Comparable 프로토콜 준수하는 제네릭 타입 선언
func binarySearch<T: Comparable>(array: [T], target: T) -> Int? {
    var lowerBound = 0 // 탐색 범위의 시작 인덱스
    var upperBound = array.count - 1 // 탐색 범위의 끝 인덱스
    
    while lowerBound <= upperBound {
        let midIndex = (lowerBound + upperBound) / 2 // 현재 탐색 범위의 중간 인덱스
        let midValue = array[midIndex] // 중간 인덱스의 값(value)
        
        if midValue == target { // 중간 값이 목표 값과 같으면 중간 인덱스를 반환
            return midIndex
        } else if midValue < target { // 중간 값이 목표 값보다 작으면 탐색 범위를 오른쪽 절반으로 줄임
            lowerBound = midIndex + 1
        } else { // 중간 값이 목표 값보다 크면 탐색 범위를 왼쪽 절반으로 줄임
            upperBound = midIndex - 1
        }
    }
    return nil // 탐색 범위가 없으면 nil 반환
}

// 사용
//let numbers = [1, 2, 3, 4, 5, 6]
//if let index = binarySearch(array: numbers, target: 5) {
//    print("찾는 값의 인덱스 : \(index)")
//} else {
//    print("찾는 값은 해당 데이터에서 존재하지 않습니다.")
//}
