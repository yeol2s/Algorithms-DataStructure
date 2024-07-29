//
//  LinkedList.swift
//  Algorithms
//
//  Created by 유성열 on 7/30/24.
//
// MARK: - 연결 리스트(LinkedList)
// 각 요소가 다음 요소에 대한 참조를 가지고 있는 데이터 구조(각 노드가 다음 노드에 대한 참조를 가지고 있음)
// MARK: 연결 리스트는 요소의 빈번한 삽입 및 삭제가 필요한 경우 효율적
// 데이터가 필요하다면 필요한 데이터만큼 노드를 만들어 데이터를 저장하고 다른 노드를 가리켜 연결(첫 노드의 주소만 알고 있으면 다른 모든 노드에 접근 가능)
// 연결리스트는 데이터들이 전부 떨어져있기 때문에 바로 접근할 수 없고 노드들을 순서대로 거쳐서 다음 노드를 찾아가서 데이터를 참조한다.(O(n)의 성능)
// 배열에서는 중간에 데이터를 삽입하면 그 뒤에 있는 데이터들은 모두 뒤로 밀려나기 때문에 오버헤드가 많이 든다. 반면 연결리스트는 중간에 데이터를 삽입하면 다음 가리키는 노드만 바꿔주면 되기 때문에 간단하다.
/*
 * 배열과 연결리스트 어떤 것이 좋을까?
    - 데이터의 수가 자주 바뀌지 않고 참조가 자주 일어난다면 -> 배열
    - 데이터의 삽입과 삭제가 자주 일어나서 데이터의 수가 자주 바뀐다면 -> 연결리스트(메모리 절약)
*/

/*
 * 연결 리스트의 장점 :
    - 요소의 삽입 및 삭제가 빠름(특히 리스트의 앞쪽이나 중간에)
    - 크기가 동적(리스트 크기를 사전에 알 필요가 없음)
 
 * 연결 리스트의 단점 :
    - 요소 접근이 느림(인덱스 기반으로 접근할 수 없고, 순회가 필요)
    - 메모리 사용량 증가(각 노드가 포인터를 추가로 저장하므로)
 
 * 연결 리스트 종류 :
    - 단일 연결 리스트(Singly) : 각 노드는 다음 노드에 대한 참조를 하나 가짐(한 방향으로만 순회 가능)
    - 이중 연결 리스트(Doubly) : 각 노드는 이전 노드와 다음 노드에 대한 참조를 가짐(양방향 순회 가능)
    - 원형 연결 리스트(Circular) : 마지막 노드가 첫 번째 노드를 참조(리스트의 끝에서 다시 처음으로 돌아갈 수 있음)
*/

// MARK: 단일 리스트만 구현
import Foundation

// 노드 클래스 정의(각 노드는 데이터와 다음 노드를 가리키는 참조를 가짐)
class Node<T> {
    var value: T
    var next: Node?
    
    init(value: T) {
        self.value = value
        self.next = nil
    }
}

// 연결 리스트 클래스 정의
class LinkedList<T: Equatable> { // 비교 연산을 위해 Equtable 프로토콜을 준수하도록 제네릭 타입 설정(삭제 부분)
    private var head: Node<T>? // 연결 리스트는 노드의 첫 번째 요소인 헤드(Head)를 가리킴
    
    // MARK: 리스트가 비어있는지 확인
    var isEmpty: Bool {
        return head == nil
    }
    
    // MARK: 첫 번째 노드 반환
    var first: Node<T>? {
        return head
    }
    
    // MARK: 마지막 노드 반환
    var last: Node<T>? {
        guard var node = head else {
            return nil
        }
        
        while let nextNode = node.next { // nil이 나올때 까지 반복(언래핑)
            node = nextNode
        }
        return node // nil이 나오면 마지막으로 할당된 node가 반환
    }
    
    // MARK: 노드 추가(끝에)
    func append(value: T) {
        let newNode = Node(value: value)
        if let laseNode = last { // (기존)노드가 있다면 마지막 노드 다음 노드로 추가
            laseNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    // MARK: 노드 삽입(특정 위치에)
    
    // 이건 특정 노도를 인자로 전달해줘야 하는 부분이고
//    func insert(value: T, after node: Node<T>) {
//        let newNode = Node(value: value)
//        newNode.next = node.next
//        node.next = newNode
//    }
    
    // 인덱스로 특정 위치에 노드 삽입(지정된 인덱스에 도달할 떄까지 리스트를 순회하여 도달하면 노드 삽입(인덱스가 리스트 길이보다 크면 리스트의 끝에 삽입)
    func insert(value: T, at index: Int) {
        let newNode = Node(value: value)
        
        if index == 0 { // 매개변수 index가 0이라면
            // 맨 앞에 삽입
            newNode.next = head // 기존 헤드가 다음 노드로 옮겨진다.
            head = newNode // 헤드가 변경
            return
        }
        
        // 인덱스가 0이 아니라면
        var current = head
        var currentIndex = 0
        
        // 이전 노드 찾기
        // 지정된 인덱스에 도달할 떄까지 리스트를 순회(index - 1 은 삽입할 위치 앞의 노드 찾기)
        // 'current != nil' 은 루프가 끝났을 때 리스트의 끝에 도달하지 않았는지 확인
        while current != nil && currentIndex < index - 1 {
            current = current?.next // 여기서 head였던 current가 다음 노드로 계속해서 바뀌게 됨
            currentIndex += 1
        }
        
        // 주어진 인덱스가 리스트 길이보다 크면 끝에 삽입
        // 현재 노드(current)가 nil 이라는 것은 리스트 끝까지 탐색했지만 삽입할 인덱스에 도달하지 못했다는 것(즉 리스트의 길이보다 큰 인덱스에 삽입-노드 리스트 끝)
        if current == nil {
            append(value: value) // 새로운 노드를 리스트 끝에 추가
        } else {
            // 삽입할 위치의 직전 노드(current)가 존재하는 경우로 새 노드의 next 포인터를 현재 노드의 next 포인터로 설정해서 기존 노드와의 연결을 유지하고 현재 노드의 next 포인터를 새 노드로 설정하여 새 노드를 삽입
            newNode.next = current?.next // 직전노드는 위 while 루프에서 정해짐
            current?.next = newNode
        }
    }
    
    // MARK: 노드 삭제(특정 값)
    func remove(value: T) {
        head = remove(node: head, value: value)
    }
    
    // 재귀적으로 호출
    private func remove(node: Node<T>?, value: T) -> Node<T>? {
        guard let node = node else { // (재귀 기저 사례)리스트 끝까지 탐색했다면 nil 반환하고 재귀 종료
            return nil
        }
        
        if node.value == value {
            return node.next // 노드를 삭제하고 다음 노드를 반환
        }
        node.next = remove(node: node.next, value: value)
        return node
    }
    /*
     * 삭제 동작 과정(재귀)
        초기 리스트 : 1 -> 2 -> 3 이라는 가정하에 list.remove(value: 2)
        
        1. 노드 1 :
            - 현재 노드 값 '1'은 삭제 대상 '2'와 다름
            - 'node.next = remove(node: node.next, value: 2)'를 호출하여 다음 노드로 진행
        2. 노드 2 :
            - 현재 노드 값 '2'는 삭제 대상 '2'와 같음
            - 'return node.next'로 노드 '2'를 (삭제)건너뛰고 노드 '3'을 반환
            (이 단계에서 노드 '2'가 삭제되고, 반환된 값(node.next 노드 '3')이 상위 호출로 전달
        3. 첫 번째 호출로 반환 :
            - 'node.next = remove(node: node.next, value: 2)'에서 반환된 값은 노드 '3'
            - 'node'next'를 노드 '3'으로 설정하여 리스트가 '1 -> 3'으로 업데이트 됨
            - 'return node'를 통해 현재 노드(노드 '1')을 반환(최종 리스트 '1 -> 3')
     */
    
    // MARK: 리스트 출력
    func printList() {
        var node = head
        while let currentNode = node {
            print(currentNode.value)
            node = currentNode.next
        }
    }
}

class LinkedListTest {
    // 연결 리스트 객체 생성
    let list = LinkedList<Int>()
    
    func linkedListBasic() {
        // 추가
        list.append(value: 1)
        list.append(value: 2)
        list.append(value: 3)
        
        // 위치로 삽입(2번 인덱스)
        list.insert(value: 4, at: 2) // 1, 2, 3 -> 1, 2, 4, 3
        list.insert(value: 5, at: 10) // 리스트 끝 삽입(인덱스 초과) // 1, 2, 4, 3, 5
        
        // 값 삭제
        list.remove(value: 2) // 1, 4, 3, 5
    }
}
