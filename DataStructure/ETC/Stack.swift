//
//  Stack.swift
//  Algorithms
//
//  Created by 유성열 on 7/31/24.
//
// MARK: - 스택(Stack)
// LIFO(Last In First Out - 후입선출) 원칙을 따르는 자료구조로 마지막에 추가된 요소가 가장 먼저 제거됨
// 함수 호출 및 재귀, 실행 취소(되돌리기) 기능 등에서 사용
// 스택은 선형 자료 구조
// 스택은 요소의 추가 및 제거를 O(1) 시간 복잡도로 매우 빠르게 수행할 수 있음(제한된 접근을 통해)

/*
 * 스택 기본 연산
    - push : 새로운 요소를 스택의 맨 위에 추가
    - pop : 스택의 맨 위에 있는 요소를 제거하고 반환
    - peek(or Top) : 스택의 맨 위에 있는 요소를 반환하되, 제거하지는 않음
 
 * 스택의 특징
    - 후입선출 : 가장 최근에 추가된 요소가 가장 먼저 제거
    - 제한된 접근 : 스택의 맨 위에 있는 요소에만 접근할 수 있음
    - 유용성 : 함수 호출 스택, 탐색 알고리즘, 데이터 역전 등 다양한 분야에서 사용
 
 * 스택의 구조
    스택은 선형 자료구조로, 데이터를 일렬로 쌓아 올리는 형태임. 이 때, 요소를 추가하거나 제거할 수 있는 곳은 '항상 스택의 맨 위'이다.
    즉, 스택의 하단에 있는 요소는 상단의 요소를 모두 제거하기 전에는 직접적으로 접근할 수 없음
    - 스택 구조에서는 직접적인 인덱스 접근 불가함
    - 데이터 보호 : 스택의 하단에 있는 데이터는 스택이 정상적으로 사용되는 한, 다른 요소에 의해 가려져 있음. 그러므로 데이터의 무결성을 보호하고, 예기치 않은 데이터 수정이나 접근을 방지한다.
 */

import Foundation

struct Stack<T> {
    
    // 요소(직접 접근 불가) - 외부에서 요소의 인덱스로 접근 불가
    private var elements: [T] = []
    
    // 스택에 요소 추가
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
    // 스택의 맨 위 요소 제거 및 반환
    mutating func pop() -> T? {
        return elements.popLast()
    }
    
    // 스택의 맨 위 요소 반환
    func peek() -> T? {
        return elements.last
    }
    
    // 스택이 비어있는지 확인
    func isEmpty() -> Bool {
        return elements.isEmpty
    }
    
    // 스택의 크기 반환
    func size() -> Int {
        return elements.count
    }
    
}

