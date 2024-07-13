//
//  HeapSort.swift
//  Algorithms
//
//  Created by 유성열 on 7/11/24.
//
// MARK: - 힙 정렬(Heap Sort) (비선형)이진 트리 자료구조를 사용하는 정렬 알고리즘(힙 자료구조)
// MARK: 힙 정렬(heapSort)는 '힙 자료구조(heapify)'를 이용하여 배열을 정렬하는 정렬 알고리즘으로 핵심은 '최대 힙' 또는 '최소 힙'을 활용하여 효율적으로 정렬하는 것으로 힙 자료 구조는 특성상 가장 큰 값(최대 힙) 또는 가장 작은 값(최소 힙)을 빠르게 찾고 제거할 수 있어 정렬에 유리하다.
// MARK: heapify 함수는 주어진 배열을 최대 힙이나 최소 힙 속성을 만족하도록 재구성하고 힙 정렬은 힙 자료 구조를 사용하여 배열을 정렬하는 전체 과정을 담당
// MARK: 1. 주어진 배열을 최대 힙으로 변환(힙 구성 단계) -> 2. 힙에서 요소를 하나씩 추출하여 정렬(정렬 단계)
// 이진 힙 자료구조를 사용하는 정렬알고리즘으로 최악의 경우에도 O(n log n)의 시간 복잡도를 가지는 효율적인 알고리즘

/*
 *힙 속성
 
 힙 속성은 힙 자료 구조가 가져야 할 특정한 규칙을 의미하는데
 이 규칙은 최대 힙(Max-Heap)이나 최소 힙(Min-Heap)으로 정의하는데 사용된다.
 
 *최대 힙 속성
    - 부모 노드의 값이 자식 노드의 값보다 크거나 같아야 한다.
    - 트리의 root 노드가 트리에서 가장 큰 값을 가진다.
 ex) 최대 힙
       10
      /  \
     9     8
    / \   / \
   7  6   5  4
  / \
 3  2
 
*최소 힙 속성
    - 부모 노드의 값이 자식 노드의 값보다 작거나 같아야 한다.
    - 트리 root 노드가 트리에서 가장 작은 값을 가진다.
ex) 최소 힙
      1
     / \
    2   3
   / \ / \
  4  5 6  7
 / \
8  9
*/
// MARK: 최대 힙과 최소 힙을 설정하고 유지하는 과정은 유사하지만 비교 연산의 방향이 반대가 된다.

/*
 * 요약
 heapify 함수 : 주어진 인덱스 'i'를 루트로 하는 서브트리를 최대 힙 속성을 만족하도록 재구성
 heapsort 함수 : 배열을 최대 힙으로 변환한 다음, 힙의 루트(최대 값)를 배열의 끝으로 이동시키고 남은 요소에 대해 반복적으로 heapify 함수를 호출하여 배열을 정렬
 이러한 과정으로 주어진 배열이 힙 정렬을 통해 오름차순으로 정렬됨
 
 * 힙 정렬의 주요 개념
 1. 힙(Heap):
    - 힙은 완전 이진 트리 형태를 가지는 자료 구조로, 각 부모 노드가 자식 노드보다 크거나(최대 힙) 작아야(최소 힙) 하는 속성을 가짐
    - 힙은 배열로 쉽게 표현할 수 있고, 힙 속성을 유지하면서 요소를 추가하거나 제거할 수 있음
 
 2. 최대 힙과 최소 힙:
    - 최대 힙(Max-Heap): 부모 노드가 자식 노드보다 크거나 같은 힙.
    - 최소 힙(Min-Heap): 부모 노드가 자식 노드보다 작거나 같은 힙.
 
 * 힙 정렬 알고리즘
 1. 힙 구성(Building the Heap):
    - 주어진 배열을 최대 힙 또는 최소 힙으로 변환
    - 이를 통해 가장 큰 값(최대 힙)이나 가장 작은 값(최소 힙)을 빠르게 찾을 수 있음
 
 2. 정렬(Sorting):
    - 힙의 루트 노드(최대 힙의 경우 가장 큰 값)를 배열의 끝으로 이동시키고, 힙의 크기를 줄임
    - 남은 힙에서 다시 힙 속성을 유지하도록 heapify 함수를 호출
    - 이 과정을 반복하여 전체 배열을 정렬
 */

import Foundation

// MARK: heapify 함수는 힙 구조를 유지하기 위해 필요함
// 주어진 배열에서 최대 힙(Max-Heap)을 유지하기 위해 사용된다. 'i'번째 노드와 그 자식 노드들 간의 힙 속성을 만족하도록 만듦
func heapify(_ array: inout [Int], _ n: Int, _ i: Int) {
    var largest = i // 루트 노드를 가장 큰 값으로 가정
    let left = 2 * i + 1 // 왼쪽 자식 노드(인덱스)
    let right = 2 * i + 2 // 오른쪽 자식 노드(인덱스)
    
    // 왼쪽 자식 노드가 루트 노드보다 큰 경우
    if left < n && array[left] > array[largest] {
        largest = left
    }
    
    // 오른쪽 자식 노드가 현재 가장 큰 노드보다 큰 경우
    if right < n && array[right] > array[largest] {
        largest = right
    }
    
    // 가장 큰 노드가 루트 노드가 아닌 경우
    if largest != i {
        array.swapAt(i, largest) // 루트 노드와 가장 큰 노드를 교환(인덱스로 두개의 값을 바꿔줌)
        heapify(&array, n, largest) // 재귀적으로 힙 속성 복구
    }
}

// MARK: heapSort 함수(힙 정렬)
// 배열을 힙 구조로 만들고, 가장 큰 요소를 배열의 끝으로 이동시킨 후 힙 크기를 줄이고 다시 힙 속성을 유지하면서 정렬
func heapSort(_ array: inout [Int]) {
    let n = array.count
    
    // 1. 최대 힙을 구축(Max-Haep)
    // 배열의 중간 지점부터 시작하여 역순으로 heapify 함수를 호출(이 루프는 배열을 최대 힙으로 변환한다.)
    // * 중간 지점부터 시작하는 이유는 힙의 마지막 레벨의 자식 노드부터 시작하여 상위 노드로 올라가면서 힙 속성을 만족시키기 위함
    for i in stride(from: n / 2 - 1, through: 0, by: -1) {
        heapify(&array, n, i)
    }
    
    // 2. 하나씩 요소를 힙에서 추출하여 정렬
    // 힙의 루트(최대 값)를 배열의 끝으로 이동시키고, 힙의 크기를 줄인 후 남은 부분에 대해 다시 heapify 함수를 호출하여 힙 속성을 유지시킴
    // 이 과정을 배열이 완전히 정렬될 때까지 반복
    for i in stride(from: n - 1, through: 0, by: -1) {
        array.swapAt(0, i)
        heapify(&array, i, 0)
    }
}

// MARK: 예제 순서
/*
1. 힙 구성 (Building the Heap)
초기 배열: [12, 11, 13, 5, 6, 7]

첫 번째 for 루프는 배열을 최대 힙으로 변환, 힙을 구성할 때 배열의 중간 지점에서 시작하여 heapify 함수를 호출

중간 지점 = n / 2 - 1 = '2'(6 / 2 - 1 = '2')
 
 (1). 첫 번째 heapify 호출
    heapify(array: &array, n: 6, i: 2)
 
    - i = 2, 왼쪽 자식 인덱스 = 2 * 2 + 1 = 5, 오른쪽 자식 인덱스 = 2 * 2 + 2 = 6
    - array[2] = 13, array[5] = 7, array[6]은 존재하지 않음
    - 최대 힙 속성을 이미 만족 (13이 7보다 크므로 변경 없음)

    -> 결과: [12, 11, 13, 5, 6, 7]

 (2). 두 번째 heapify 호출
    heapify(array: &array, n: 6, i: 1)

    - i = 1, 왼쪽 자식 인덱스 = 2 * 1 + 1 = 3, 오른쪽 자식 인덱스 = 2 * 1 + 2 = 4
    - array[1] = 11, array[3] = 5, array[4] = 6
    - 최대 힙 속성을 이미 만족 (11이 5와 6보다 크므로 변경 없음)

    -> 결과: [12, 11, 13, 5, 6, 7]

 (3). 세 번째 heapify 호출
    heapify(array: &array, n: 6, i: 0)

    - i = 0, 왼쪽 자식 인덱스 = 2 * 0 + 1 = 1, 오른쪽 자식 인덱스 = 2 * 0 + 2 = 2
    - array[0] = 12, array[1] = 11, array[2] = 13
    - array[2]가 가장 큼 (13)
    - 12와 13을 교환하고 heapify를 다시 호출

    -> 결과: [13, 11, 12, 5, 6, 7]

    - 교환 후 heapify(array: &array, n: 6, i: 2)
        - i = 2, 왼쪽 자식 인덱스 = 5, 오른쪽 자식 인덱스 = 6
        - array[2] = 12, array[5] = 7, array[6]은 존재하지 않음
        - 최대 힙 속성을 이미 만족 (12가 7보다 크므로 변경 없음)

    -> 최종 최대 힙 구성 결과: [13, 11, 12, 5, 6, 7]

2. 힙 정렬 (Heap Sort)
 
두 번째 for 루프는 힙의 루트(최대 값)를 배열의 끝으로 이동시키고 남은 부분에 대해 반복적으로 heapify 함수를 호출하여 배열을 정렬

 (1).첫 번째 루프
    array.swapAt(0, 5)

    - 루트와 마지막 요소 교환: [7, 11, 12, 5, 6, 13]
    - heapify(array: &array, n: 5, i: 0)

    -> 결과: [12, 11, 7, 5, 6, 13]

 (2).두 번째 루프
    array.swapAt(0, 4)

    - 루트와 마지막 요소 교환: [6, 11, 7, 5, 12, 13]
    - heapify(array: &array, n: 4, i: 0)

    -> 결과: [11, 6, 7, 5, 12, 13]

    - 재귀 호출 heapify(array: &array, n: 4, i: 1)
        - i = 1, 왼쪽 자식 인덱스 = 3, 오른쪽 자식 인덱스 = 4
        - array[1] = 6, array[3] = 5, array[4] = 12
        - 최대 힙 속성을 이미 만족 (6이 5보다 큼)

    -> 최종 결과: [11, 6, 7, 5, 12, 13]

 (3).세 번째 루프
    array.swapAt(0, 3)

    - 루트와 마지막 요소 교환: [5, 6, 7, 11, 12, 13]
    - heapify(array: &array, n: 3, i: 0)

    -> 결과: [7, 6, 5, 11, 12, 13]

 (4).네 번째 루프
    array.swapAt(0, 2)

    - 루트와 마지막 요소 교환: [5, 6, 7, 11, 12, 13]
    - heapify(array: &array, n: 2, i: 0)

    -> 결과: [6, 5, 7, 11, 12, 13]

 (5).다섯 번째 루프
    array.swapAt(0, 1)

    - 루트와 마지막 요소 교환: [5, 6, 7, 11, 12, 13]
    - heapify(array: &array, n: 1, i: 0)

    -> 최종 결과: [5, 6, 7, 11, 12, 13]

    -> 최종 정렬된 배열: [5, 6, 7, 11, 12, 13]

*요약
힙 구성: 주어진 배열을 최대 힙으로 변환합니다.
힙 정렬: 최대 힙에서 루트 노드를 배열의 끝으로 보내고, 남은 배열에서 힙 속성을 유지하여 배열을 정렬합니다.
*/

// MARK: - 최대 힙, 최소 힙 예

// 최대 힙
func maxHeapify(_ array: inout [Int], _ n: Int, _ i: Int) {
    var largest = i
    let left = 2 * i + 1
    let right = 2 * i + 2

    if left < n && array[left] > array[largest] {
        largest = left
    }

    if right < n && array[right] > array[largest] {
        largest = right
    }

    if largest != i {
        array.swapAt(i, largest)
        maxHeapify(&array, n, largest)
    }
}

func buildMaxHeap(_ array: inout [Int]) {
    let n = array.count
    for i in stride(from: n / 2 - 1, through: 0, by: -1) {
        maxHeapify(&array, n, i)
    }
}

// 최소 힙 예
func minHeapify(_ array: inout [Int], _ n: Int, _ i: Int) {
    var smallest = i
    let left = 2 * i + 1
    let right = 2 * i + 2

    if left < n && array[left] < array[smallest] {
        smallest = left
    }

    if right < n && array[right] < array[smallest] {
        smallest = right
    }

    if smallest != i {
        array.swapAt(i, smallest)
        minHeapify(&array, n, smallest)
    }
}

func buildMinHeap(_ array: inout [Int]) {
    let n = array.count
    for i in stride(from: n / 2 - 1, through: 0, by: -1) {
        minHeapify(&array, n, i)
    }
}
