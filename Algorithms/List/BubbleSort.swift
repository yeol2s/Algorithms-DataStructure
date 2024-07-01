//
//  BubbleSort.swift
//  Algorithms
//
//  Created by 유성열 on 6/30/24.
//
// MARK: - 버블 정렬(Bubble Sort)
// MARK: 버블정렬은 앞에 있는 숫자와 옆에 숫자를 비교해서 자리를 바꾸는 알고리즘
// 2번의 루프가 사용되므로 시간복잡도 O(n2)가 된다. 가장 구현하기 쉽지만 성능이 아주 좋지는 않음

/*
 ex)
 [4, 2, 3, 1]을 정렬한다면..
 1. (첫번째 숫자 - 두번째 숫자)4를 2와 비교하여 4가 더 크므로 2와 바꿔줌 -> [2, 4, 3, 1]
 2. (두번째 숫자 - 세번째 숫자)4와 3을 비교해서 4가 더 크므로 3과 바꿔줌 -> [2, 3, 4, 1]
 3. (세번째 숫자 - 네번째 숫자)4와 1을 비교해서 4가 더 크므로 1과 바꿔줌 -> [2, 3, 1, 4]
 ----> 이제 가장 큰 숫자 4는 자기 위치를 찾아 마지막 요소로 정렬이 되었고 나머지 작업도 똑같이 진행되는데 마지막 원소인 '4'는 정렬이 완료 되었으므로 범위에서 제외 된다.(4는 범위에서 제외)
 4. 4가 제외된 [2, 3, 1] 상태에서는 첫 단계에서는 2가 3보다 작으므로 바꾸지 않고 3과 1이 비교되었을 때 바뀐다. 그리고 '3'은 정렬이 완료되고 [2, 1]에서 똑같이 진행되어 결국에는 마지막에 정렬이 완료된 [1, 2, 3, 4]가 된다.
 */

import Foundation

func bubbleSort(_ array: inout [Int]) {
    // 들어온 배열의 요소 만큼 루프(i)
    for i in 0..<array.count {
        // 배열의 요소 개수 - i - 1
        // ([4, 2, 3, 1]을 예로) 첫 루프때를 보자면 i는 '0', j도 '0'이므로 -1만 되므로 0..<3이 되므로 ([4, 2, 3]까지)마지막 인덱스 전까지의 요소를 순회
        // ⭐️ j루프는 i가 증가함에 따라 점점 범위를 줄인다.(마지막 i개 요소가 이미 정렬되었으므로)
        for j in 0..<(array.count - i - 1) {
            if array[j] > array[j + 1] { // 현재 인덱스 위치의 값과 그 다음 인덱스 위치의 값을 비교하여 현재 인덱스의 값이 큰 경우 스왑
                array.swapAt(j, j + 1)
            }
        }
    }
}
