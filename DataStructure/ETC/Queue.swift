//
//  Queue.swift
//  Algorithms
//
//  Created by 유성열 on 7/31/24.
//
// MARK: - 큐(Queue)
// FIFO(First In, First Out) 원칙을 따르는 자료 구조로 먼저 추가된 요소가 먼저 제거됨
// (순서가 중요한)순차적인 작업 처리에 사용
// 배열을 사용한 Queue를 구현하는데 대량의 데이터 처리에서는 O(n)의 시간 복잡도를 가지므로 대량의 데이터에서는 두 개의 스택(배열을 스택처럼 구현)을 사용하여 Queue를 구현하거나, 연결리스트로 구현하면 Queue의 모든 연산이 평균적으로 O(1)의 시간복잡도를 가진다.

/*
 * Queue의 기본 연산 2가지
    - Enqueue : 새로운 요소를 큐의 뒤에 추가
    - Dequeue : 큐의 앞에서 요소를 제거하고 반환
 
 * Queue의 특징
    - 선입선출(FIFO) : 가장 먼저 들어온 요소가 가장 먼저 나가는 구조
    - 연속적인 데이터 처리 : 큐는 대기열이나 작업 스케줄링 등, 순서대로 데이터를 처리해야 하는 상황에 적합
    - 양쪽에서의 접근 : 큐는 앞쪽에서 요소를 제거하고, 뒤쪽에서 요소를 추가하는 방식으로 작동
 
 * Queue는 운영체제에서도 쓰이는데 운영체제가 프로세스의 작업 요청을 들어온 순서대로 큐에 넣고 CPU가 순서대로 꺼내서 처리한다.(운영체제에서는 이를 'FIFO 스케줄링'이라고 함)
 
 * Queue의 활용 사례 :
    - 작업 스케줄링 : 프로세스나 작업을 순서대로 처리하는 스케줄링 시스템
    - 프린터 대기열 : 인쇄 작업은 큐를 사용하여 순차적으로 처리
    - 데이터 스트리밍 : 실시간 데이터 스트리밍에서 데이터는 큐에 저장되고, 순서대로 처리
    - 그래프 탐색 : 너비 우선 탐색(BFS) 알고리즘에서는 큐를 사용하여 탐색 경로를 관리 (이 부분은 이해 못함)
*/

import Foundation

// MARK: - 일반적인 Queue 구현
// 배열을 사용하여 Queue를 구현하면 'removeFirst() 메서드는 O(n)의 시간 복잡도를 가지므로 대량의 데이터 처리에서는 비효율적일 수 있음. 이 경우 두 개의 스택을 사용하여 큐를 구현하거나 연결리스트를 사용하여 효율성을 높일 수 있다.
struct Queue<T> {
    
    private var elements: [T] = []
    
    // 큐에 요소 추가
    mutating func enqueue(_ element: T) {
        elements.append(element)
    }
    
    // 큐의 앞 요소 제거 및 반환
    mutating func dequeue() -> T? {
        return isEmpty() ? nil : elements.removeFirst()
    }
    
    // 큐의 앞 요소 반환(제거하지 않음)
    func peek() -> T? {
        return elements.first
    }
    
    // 큐가 비어있는지 확인
    func isEmpty() -> Bool {
        return elements.isEmpty
    }
    
    // 큐의 크기 반환
    func size() -> Int {
        return elements.count
    }
}

// MARK: - 두 개의 스택을 사용한 Queue 구현
// 2개의 배열을 스택처럼 사용(inbox, outbox)
/*
 - inbox : 새로운 요소가 추가되는 스택
 - outbox : 요소가 제거되는 스택('dequeue' 연산이 호출될 때 'outbox'가 비어 있으면 inbox의 모든 요소를 뒤집어서 outbox에 넣은 다음 outbox에서 popLast()를 호출하여 가장 나중에 추가된 요소를 제거.
*/
struct StackQueue<T> {
    
    private var inbox: [T] = []
    private var outbox: [T] = []
    
    // 큐에 요소 추가
    mutating func enqueue(_ element: T) {
        inbox.append(element)
    }
    
    // 큐의 앞 요소 제거 및 반환
    mutating func dequeue() -> T? {
        if outbox.isEmpty {
            outbox = inbox.reversed() // inbox의 요소를 뒤집어 outbox에 저장
            inbox.removeAll() // inbox
        }
        return outbox.popLast() // outbox 마지막 요소 제거 및 반환(inbox의 선입되었던 요소가 리버스 되어 outbox로 전달되었으므로 마지막 요소로 됨)
    }
    
    // 큐의 앞 요소 반환(제거하지 않음)
    func peek() -> T? {
        if outbox.isEmpty {
            return inbox.first
        } else {
            return outbox.last
        }
    }
    
    // 큐가 비어있는지 확인
    func isEmpty() -> Bool {
        return inbox.isEmpty && outbox.isEmpty
    }
}

