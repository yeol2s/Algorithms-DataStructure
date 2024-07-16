//
//  BinarySearchTree.swift
//  Algorithms
//
//  Created by 유성열 on 7/16/24.
//
// MARK: - 이진 탐색 트리(Binary Search Tree - BST)
// MARK: 효율적인 검색, 삽입, 삭제 작업을 지원하는 이진 트리 자료 구조이며, 이진 탐색 트리의 각 노드는 최대 두 개의 자식 노드를 가질 수 있다.
// MARK: 동적으로 데이터가 변하는 경우와 빈번한 삽입과 삭제가 필요한 경우 사용이 적합
// (삽입, 삭제, 검색)각 연산은 평균적으로 O(log n)의 시간 복잡도를 가지고 (균형이 맞지 않는 경우)최악의 경우에는 O(n)까지 늘어남
/*
 * 특성
    1. 노드의 왼쪽 서브트리에 있는 모든 노드의 값은 해당 노드의 값보다 작음
    2. 노드의 오른쪽 서브트리에 있는 모든 노드의 값은 해당 노드의 값보다 큼
    3. 각 서브트리 역시 이진 탐색 트리
 
 * 주요 연산
    1. 삽입(Insertion) :
        - 새로운 값을 삽입할 때는 트리의 루트(root)부터 시작하여 적절한 위치를 찾아 삽입
        - 새로운 값이 현재 노드의 값보다 작으면 왼쪽 자식으로 이동하고, 크면 오른쪽 자식으로 이동
        - 적절한 위치를 찾으면 새 노드를 생성하여 삽입
    
    2. 검색(Search) :
        - 트리의 루트부터 시작하여 찾고자 하는 값을 검색
        - 찾고자 하는 값이 현재 노드의 값보다 작으면 왼쪽 자식으로, 크면 오른쪽 자식으로 이동
        - 값을 찾으면 해당 노드를 반환하고 트리의 끝까지 찾아도 값이 없으면 nil 반환
 
    3. 삭제(Deletion) :
        - 삭제할 노드를 찾고, 세 가지 경우에 따라 처리
            1. 자식이 없는 노드 : 단순히 삭제
            2. 하나의 자식만 있는 노드 : 해당 노드를 삭제하고 자식을 부모 노드와 연결
            3. 두 개의 자식을 가진 노드 : 오른쪽 서브트리에서 가장 작은 값(혹은 왼쪽 서브트리에서 가장 큰 값)을 찾아 삭제할 노드와 교체한 후, 해당 값을 삭제
 
  * 구조
    - 루트 노드(Root Node) :
        - (*트리의 최상위 노드)부모 노드가 없는 유일한 노드
        - 트리의 모든 노드는 루트 노드를 기준으로 하여 그 아래에 배치
 
    - 내부 노드(Internal Nodes) :
        - 루트 노드를 포함한 모든 노드로, 자식 노드가 있는 노드를 의미
 
    - 단말 노드(Leaf Nodes) :
        - 자식 노드가 없는 노드
 
    - 왼쪽 자식 노드(Left Child) :
        - 현재 노드의 값보다 작은 값을 가지는 자식 노드

    - 오른쪽 자식 노드(Right Child) :
        - 현재 노드의 값보다 큰 값을 가지는 자식 노드
 
 ex)
       5       <- 루트 노드
      /  \
     3    7    <- 내부 노드
    / \  / \
   2  4  6  8  <- 단말 노드
 
*/



import Foundation

// 이진트리 자료구조(노드의 값을 저장하고, 왼쪽-오른쪽 자식 노드를 가리키는 속성을 가지는 이진 트리 구조 구성)
class TreeNode<T: Comparable> {
    var value: T
    var leftChild: TreeNode?
    var rightChild: TreeNode?
    
    init(value: T) {
        self.value = value
    }
}

class BinarySearchTree<T: Comparable> {
    var root: TreeNode<T>?
    
    // MARK: - 삽입 연산(insert)
    func insert(value: T) {
        let newNode = TreeNode(value: value)
        if let root = root { // 루트 노드가 있다면 루트 값과 새로운 값으로 노드 삽입
            insertNode(root, newNode)
        } else {
            root = newNode // 루트 노드가 없다면 루트 노드를 먼저 만듦
        }
    }
    
    private func insertNode(_ node: TreeNode<T>, _ newNode: TreeNode<T>) {
        // 새로운 노드의 값이 루트 노드 값보다 작다면
        if newNode.value < node.value {
            if let leftChild = node.leftChild { // 1. 노드의 왼쪽 자식 노드에 값이 있다면(존재하고 있다면)
                insertNode(leftChild, newNode) // 2. 왼쪽 자식노드에서 inserNode 재귀 호출해서 다시 왼쪽 자식의 자식의 노드로 삽입할 수 있도록
            } else {
                node.leftChild = newNode // 왼쪽 노드의 값이 없는 상태면 왼쪽 자식 노드로 삽입
            }
        } else { // 새로운 노드의 값이 루트 노드 값보다 크다면
            if let rightChild = node.rightChild { // 상동(오른쪽으로만 바뀜)
                insertNode(rightChild, newNode)
            } else {
                node.rightChild = newNode
            }
        }
    }
    
/*
 * 삽입 과정
    ex) let bst = BinarySearchTree<Int>()
        bst.insert(value: 5) -> bst.insert(value: 3) -> ..(value: 7) -> (value: 2) -> (value: 4) -> (value: 6) -> (value: 8) 순서대로 삽입
 
    1. '5'를 삽입 : 트리가 비어 있으므로, '5'가 루트 노드가 됨
    2. '3'을 삽입 : '3'은 '5'보다 작으므로, '5'의 왼쪽 자식으로 삽입
    3. '7'을 삽입 : '7'은 '5'보다 크므로, '5'의 오른쪽 자식으로 삽입
    4. '2'를 삽입 : '2'는 '5'보다 작고, '3'보다 작으므로, '3'의 왼쪽 자식으로 삽입
    5. '4'를 삽입 : '4'는 '5'보다 작고, '3'보다 크므로, '3'의 오른쪽 자식으로 삽입
    6. '6'을 삽입 : '6'은 '5'보다 크고, '7'보다 작으므로, '7'의 왼쪽 자식으로 삽입
    7. '8'을 삽입 : '8'은 '5'보다 크고, '7'보다 크므로, '7'의 오른쪽 자식으로 삽입
 
    * 첫 번째 값은 트리의 루트 노드가 된다.
    루트 노드의 값을 변경할 수 있지만, 루트 노드의 값은 트리의 나머지 부분에 강한 영향을 미치므로, 트리의 구조를 유지하면서 값을 변경해야 한다.(신중해야 한다.)
    루트 노드 값을 무작위로 변경하면 '왼쪽 서브트리의 모든 노드 값은 루트 노드 값보다 작고, 오른쪽 서브트리의 모든 노드 값은 루트 노드 값보다 크다."라는 이 속성을 위반할 수 있다.
    따라서 루트 노드의 값을 변경하려면 트리를 다시 구성하거나 트리의 모든 노드가 이 속성을 만족하도록 값을 조정해야 한다.
    
    방법 1 : 트리 재구성
        - 루트 노드의 값을 변경하고 트리를 재구성하는 한 가지 방법은 현재 루트 노드를 삭제하고, 새로운 값을 루트 노드로 삽입하는 것(삭제 연산과 삽입 연산을 사용하여 트리를 재구성)
        ex )
            // 루트 노드 값 변경하는 메서드 구현
            func changeRootValue(newValue: T) {
                guard let rootNode = root else { return }
                // 루트 노드를 삭제하고 새로운 값을 삽입
                delete(value: rootNode.value)
                insert(value: newValue)
            }
    방법 2 : 직접 변경
        - 루트 노드의 값을 직접 변경할 수 있지만 이 경우에는 트리의 속성이 깨질 수 있으므로 권장되지 않음. 직접 값을 변경하는 경우 트리의 모든 노드를 재조정하거나 정렬된 리스트로 변환 후 다시 트리를 구성하는 작업이 필요할 수 잇음
*/
    
    // MARK: - 검색 연산(search)
    // 루트 노드에서 시작하여 재귀적으로 트리를 탐색(트리의 각 노드에서 현재 노드의 값과 찾고자 하는 값을 비교하여 왼쪽 자식이나 오른쪽 자식으로 이동)
    func search(value: T) -> TreeNode<T>? {
        return searchNode(root, value)
    }
    
    private func searchNode(_ node: TreeNode<T>?, _ value: T) -> TreeNode<T>? {
        guard let node = node else { return nil } // 현재 노드가 nil이면 nil 반환
        
        if value == node.value { // 찾고자 하는 값이 현재 노드의 값과 같다면 현재 노드를 반환
            return node
        } else if value < node.value { // 찾고자 하는 값이 현재 노드의 값보다 작으면 왼쪽 자식으로 이동
            return searchNode(node.leftChild, value) // 재귀 호출
        } else { // 찾고자 하는 값이 현재 노드의 값보다 크면 오른쪽 자식으로 이동
            return searchNode(node.rightChild, value)
        }
    }
    
/*
 * 검색 과정 (searchNode 메서드가 재귀적으로 호출된다.)
    ex) search(value: 4)
    
    1. 루트 노드에서 시작 :
        - 'searchNode' 메서드가 'root'노드(값 5)와 찾고자 하는 값 4를 인자로 호출
        - 현재 노드의 값이 5이므로, 4는 5보다 작으므로 왼쪽 자식 노드로 이동
    
    2. 왼쪽 자식 노드(값 3) 탐색 :
        - 'searchNode' 메서드가 왼쪽 자식 노드(값 3)와 찾고자 하는 값 4를 인자로 호출
        - 현재 노드의 값이 3이므로, 4는 3보다 크다. 따라서 오른쪽 자식 노드로 이동
 
    3. 오른쪽 자식 노드(값 4) 탐색 :
        - 'searchNode' 메서드가 오른쪽 자식 노드(값 4)와 찾고자 하는 값 4를 인자로 호출
        - 현재 노드의 값이 4이므로, 찾고자 하는 값과 일치한다. 따라서 현재 노드(값 4)를 반환
 
    * 이 과정에서 'searchNode' 메서드가 재귀적으로 호출되며, 각 단계에서 현재 노드의 값을 확인하고 다음 이동할 방향을 결정하는 것.
    찾고자 하는 값을 발견할 때 해당 노드를 반환하고, 트리의 끝까지 값을 찾지 못하면 nil 반환
*/
    
    // MARK: - 삭제 연산(Delete)
    func delete(value: T) {
        root = deleteNode(root, value)
    }
    
    private func deleteNode(_ node: TreeNode<T>?, _ value: T) -> TreeNode<T>? {
        guard let node = node else { return nil }
        
        if value < node.value {
           // 삭제할 값이 현재 노드의 값보다 작으면 왼쪽 자식으로 이동
            node.leftChild = deleteNode(node.leftChild, value)
        } else if value > node.value {
            // 삭제할 값이 현재 노드의 값보다 크면 오른쪽 자식으로 이동
            node.rightChild = deleteNode(node.rightChild, value)
        } else {
            // 삭제할 노드를 찾은 경우
            
            // 자식이 없는 경우 또는 하나인 경우
            // 왼쪽 자식만 있는 경우 왼쪽 자식을 반환하고, 오른쪽 자식만 있는 경우 오른쪽 자식을 반환
            if node.leftChild == nil {
                return node.rightChild
            } else if node.rightChild == nil {
                return node.leftChild
            }
            
            // 두 개의 자식을 가진 경우
            // 'minValue' 메서드를 사용해서 오른쪽 서브트리에서 가장 작은 값을 찾는다.
            // 현재 노드의 값을 오른쪽 서브트리에서 찾은 가장 작은 값으로 대체하고, 대체된 값을 오른쪽 서브트리에서 삭제
            node.value = minValue(node.rightChild!)
            node.rightChild = deleteNode(node.rightChild, node.value)
        }
        return node
    }
    
    // 주어진 노드의 서브트리에서 가장 작은 값을 찾기 위함(서브트리의 가장 작은 값은 해당 노드의 왼쪽 자식 노드를 반복적으로 탐색함으로써 찾을 수 있음)
    private func minValue(_ node: TreeNode<T>) -> T {
        var currentNode = node
        while let next = currentNode.leftChild { // 왼쪽 자식이 존재하는 동안 반복
            currentNode = next // 왼쪽 자식으로 이동(왼쪽 자식 노드가 존재할 경우 currentNode를 왼쪽 자식 노드로 업데이트)
        }
        return currentNode.value // 가장 작은 값을 반환
    }
    
/*
 * 동작 과정 :
    1. 삭제할 노드를 찾는 과정
        - 트리의 루트 노드에서 시작하여 삭제할 값을 찾기 위해 트리를 탐색
        - 삭제할 값이 현재 노드의 값보다 작으면 왼쪽 자식으로 이동하고, 크면 오른쪽 자식으로 이동
        - 값을 찾으면 해당 노드를 삭제
 
    2. 삭제 연산
        - 자식이 없는 경우(리프 노드) :
            - 노드를 단순히 삭제하고 'nil'을 반환
        - 하나의 자식만 있는 경우 :
            - 현재 노드를 삭제하고, 그 자식 노드를 부모 노드에 연결
            (왼쪽 자식만 있는 경우 왼쪽 자식을 반환하고, 오른쪽 자식만 있는 경우 오른쪽 자식을 반환)
        - 두 개의 자식을 가진 경우 :
            - 오른쪽 서브트리에서 가장 작은 값을 찾는다.('minValue' 메서드 사용)
            - 현재 노드의 값을 오른쪽 서브트리에서 찾은 가장 작은 값으로 대체
            - 대체된 값을 오른쪽 서브트리에서 삭제
 
ex) root 노드 '5'
    5
   / \
  3   7
 / \ / \
2  4 6  8

- 값 '3' 삭제하는 경우
 1. 루트 노드(5)에서 시작하여 값 3을 찾는다. 3은 5보다 작으므로 왼쪽 자식으로 이동
 2. 왼쪽 자식 노드(3)에서 값을 찾는다.
 3. 노드 3은 두 개의 자식을 가지고 있다. 따라서 오른쪽 서브트리에서 가장 작은 값을 찾으면 이 경우 4가 된다.
 4. 노드 3의 값을 4로 대체
 5. 오른쪽 서브트리에서 값 4를 삭제(노드 4는 리프 노드이므로 단순히 삭제됨)
 
-> 결과
    5
   / \
  4   7
 /   / \
2   6   8
 
 
 *리프노드? :
    1. 자식 노드 없음(리프 노드는 왼쪽 자식 노드와 오른쪽 자식 노드 모두가 'nil'이다.)
    2. 트리의 끝(리프 노드는 트리의 가장 말단에 위치하며, 그 아래에 더 이상의 노드가 존재하지 않음)
    3. 경로의 종착점(루트 노드에서 시작하여 어떤 경로로든 내려가면 결국 리프 노드에 도달하게 됨)
*/
    
    // MARK: - 중위 순회(특징 : 중위 순회를 통해 얻은 노드의 값들은 항상 오름차순으로 정렬됨)
/*
 전위 순회 : 현재 노드(루트)를 먼저. 방문하고 왼쪽 서브트리 -> 오른쪽 서브트리 순으로 방문
 중위 순회 : 왼쪽 서브트리 -> 현재 노드 -> 오른쪽 서브트리 순으로 방문
 후위 순회 : 왼쪽 서브트리 -> 오른쪽 서브트리 -> 현재 노드 순으로 방문
 
 * 중위 순회의 정의
    중위 순회는 아래와 같은 재귀적 과정을 따름
        1. 왼쪽 자식 노드를 중위 순회
        2. 현재 노드를 방문(출력)
        3. 오른쪽 자식 노드를 중위 순회
*/
    func inOrderTraversal() {
        inOrderTraversalNode(root)
    }
    
    // 재귀적으로 노드를 중위 순회
    private func inOrderTraversalNode(_ node: TreeNode<T>?) {
        guard let node = node else { return }
        inOrderTraversalNode(node.leftChild) // 왼쪽 자식 노드를 중위 순회
        print(node.value) // 현재 노드의 값을 출력(방문)
        inOrderTraversalNode(node.rightChild) // 마지막으로 오른쪽 자식 노드를 중위 순회
    }
/*
 ex)
    10
   /  \
  5   15
 / \    \
3  7    20
 
-> 중위 순회 과정을 거치면 노드 방문 순서는 '3, 5, 7, 10, 15, 20'이 됨
 
* 과정
    1. 루트 노드 '10'에서 시작
    2. 왼쪽 자식 노드 '5'로 이동
    3. 다시 왼쪽 자식 노드 '3'으로 이동, '3'은 리프 노드이므로 값을 출력 : '3'
    4. '5'로 돌아와 값을 출력 : '5'
    5. '5'의 오른쪽 자식 노드 '7'로 이동, '7'은 리프 노드이므로 값을 출력 : '7'
    6. 루트 노드 '10'으로 돌아와 값을 출력 : '10'
    7. 오른쪽 자식 노드 '15'로 이동, 왼쪽 자식 노드가 없으므로 현재의 노드 값을 출력 : '15'
    8. 오른쪽 자식 노드 '20'으로 이동, '20'은 리프 노드이므로 값을 출력 : '20'
*/
    
}
