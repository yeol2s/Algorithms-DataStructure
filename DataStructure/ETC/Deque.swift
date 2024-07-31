//
//  Deque.swift
//  Algorithms
//
//  Created by 유성열 on 8/1/24.
//
// MARK: - 덱(Deque)
// 양쪽 끝에서 모두 삽입과 삭제가 가능한 자료 구조(Queue와 Stack의 장점을 결합한 자료 구조, 양방향으로 요소를 추가하고 제거할 수 있음)
// 배열을 사용한 덱은 insert(앞에 요소 추가), removeFirst(앞 요소 제거) 메서드는 O(n)의 시간 복잡도(배열의 첫 번째 요소를 삽입하거나 제거할 때 나머지 요소들을 이동시켜야 하기 때문)
// pushBack(뒤에 요소 추가), popBack(뒤 요소 제거)는 O(1)의 시간 복잡도
/*
 * 덱을 사용하는 경우
    - 양방향 데이터 처리 : 데이터를 양쪽 끝에서 처리해야 할 때 유용(양방향 탐색 알고리즘 등)
    - 기록 및 되돌리기 기능 : 프로그램에서 실행 취소(undo)와 다시 실행(redo) 기능을 구현할 때, 기록을 덱에 저장하여 양쪽 끝에서 데이터를 삽입하고 제거 가능
    - 캐시 구현 : 덱을 사용하여 캐시를 구현할 수 있음 -> 양쪽 끝에서 데이터를 추가하고 제거하여 캐시의 LRU(Least Recently Used) 및 MRU(Most Recently Used) 정책 지원 가능
        LRU : 가장 오랫동안 사용되지 않은 데이터를 제거하여 새 데이터를 추가하는 방식(가장 최근에 사용된 데이터는 유지 - 오래된 데이터를 우선적으로 제거)
        MRU : 가장 최근에 사용된 데이터를 제거하여 새 데이터를 추가하는 방식(최근에 사용된 데이터를 가장 먼저 제거)
        * 두 방식은 서로 상반됨
    - 시간에 따른 데이터 처리 : 최근에 추가된 데이터와 오래된 데이터를 모두 효율적으로 관리할 때(시간에 따라 변하는 데이터를 모니터링하거나 로그를 관리하는 등의 경우)
 
    덱은 양방향 접근과 복잡한 데이터 처리를 지원하는 유연한 자료 구조. 상황에 따라 덱의 기능이 필요하지 않은 경우 스택이나 큐를 사용하여 단순화 및 성능을 최적화 할 수 있음
*/

/*
 * 덱의 주요 연산
    - pushFront(앞에 추가) : 요소를 덱의 앞쪽에 추가
    - pushBack(뒤에 추가) : 요소를 덱의 뒤쪽에 추가
    - popFront(앞에서 제거) : 덱의 앞쪽에서 요소 제거
    - popBack(뒤에서 제거) : 덱의 뒤쪽에서 요소 제거
*/

import Foundation

struct Deque<T> {
    
    private var array: [T] = []
    
    // 앞에 요소 추가
    mutating func pushFront(_ element: T) {
        array.insert(element, at: 0)
    }
    
    // 뒤에 요소 추가
    mutating func pushBack(_ element: T) {
        array.append(element)
    }
    
    // 앞에서 요소 제거
    mutating func popFront() -> T? {
        return isEmpty ? nil : array.removeFirst()
    }
    
    // 뒤에서 요소 제거
    mutating func popBack() -> T? {
        return isEmpty ? nil : array.removeLast()
    }
    
    // 덱이 비었는지 확인
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    // 덱의 요소 개수
    var count: Int {
        return array.count
    }
    
    // 덱의 앞쪽 요소 확인
    var front: T? {
        return array.first
    }

    // 덱의 뒤쪽 요소 확인
    var back: T? {
        return array.last
    }
}
