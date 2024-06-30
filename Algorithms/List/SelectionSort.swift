//
//  SelectionSort.swift
//  Algorithms
//
//  Created by 유성열 on 7/1/24.
//
// MARK: - 선택 정렬(Selection Sort)
// MARK: 배열의 정렬되지 않은 영역의 첫 번째 요소를 시작으로 마지막 요소까지 비교 후 가장 작은 값을 첫 번째 요소로 가져옴
// 2번의 루프가 사용되므로 시간복잡도 O(n2)가 된다. 구현하기 쉽지만 성능이 아주 좋지는 않음

/*
 1. 주어진 배열에서 가장 작은 요소를 찾음
 2. 그 요소를 배열의 첫 번째 요소와 교환
 3. 그 다음 작은 요소를 찾아서 배열의 두 번째 요소와 교환
 4. 배열의 끝까지 위 과정을 반복
 
 일단 요소의 마지막까지 다 읽고 거기서 가장 낮은 값을 첫 번째 원소로 가져온다.

ex)
 [64, 25, 12, 22, 11] 이 들어간다면
 1. 처음 루프(i = 0) : 최소 값 11을 찾아 첫 번째 요소와 교환 -> [11, 25, 12, 22, 64]
 2. 두번째 루프(i = 1) : 나머지 부분 [25, 12, 22, 64]에서 최소 값 12를 찾아 두 번째 요소와 교환 -> [11, 12, 25, 22, 64]
 3. 세번째 루프(i = 2) : 나머지 부분 [25, 22, 64]에서 최소 값 22를 찾아 세 번째 요소와 교환 -> [11, 12, 22, 25, 64] (*이 시점에 배열의 나머지 부분 [25, 64]는 이미 정렬되어 있음)
 세 번째 루프가 끝나면 마지막 요소는 이미 이전 단계에서 가장 큰 값이 될 수밖에 없기 때문에 나머지 요소 [25, 64]는 이미 정렬이 된 상태가 된다.
 */

import Foundation
func selectionSort(_ array: inout [Int]) {
    
    // 첫 루프는 배열의 모든 요소를 순회한다.
    for i in 0..<array.count - 1 { // 배열의 마지막 요소는 자연스럽게 정렬
        var minIndex = i // 현재 가장 작은 요소의 인덱스를 저장(루프가 한번 진행될 때 마다 최소값이 하나 정렬되기 때문에 정렬된 영역은 반복에서 제외됨)
        // 두 번째 루프는 배열의 나머지 부분을 순회하여 가장 작은 요소를 찾아낸다.
        for j in i + 1..<array.count { // i + 1 부터 시작하는 이유는 (minIndex)현재 인덱스 이후의 배열에서 최소값을 찾아 현재 인덱스와 교환하는 것이기 때문
            if array[j] < array[minIndex] {
                minIndex = j // minIndex에 현재 가장 작은 요소의 인덱스를 저장
            }
        }
        
        if i != minIndex { // minIndex의 값이 변경된 경우에는 값을 스왑
            array.swapAt(i, minIndex)
        }
    }
}
