//
//  LinearSearch.swift
//  Algorithms
//
//  Created by 유성열 on 7/15/24.
//
// MARK: - 선형 탐색(Linear Search)
// MARK: 선형 탐색은 가장 간단한 검색 알고리즘으로, 배열의 첫 번째 요소부터 마지막 요소까지 순차적으로 탐색하면서 목표 값을 찾음(배열이 정렬되지 않은 경우에도 사용할 수 있음)
// MARK: (간단한 문제)배열이 작거나, 정렬되지 않은 배열에서 탐색할 때 사용
// 시간 복잡도는 O(n)

import Foundation

func linearSearch<T: Equatable>(array: [T], target: T) -> Int? {
    for (index, element) in array.enumerated() { // enumerated() : 배열 요소들을 네임드튜플 형태(인덱스, 요소)로 한개씩 전달받음(index(인덱스), element(요소))
        if element == target { // 요소의 값이 목표 값(target)과 같다면 해당 인덱스를 반환
            return index
        }
    }
    return nil
}
