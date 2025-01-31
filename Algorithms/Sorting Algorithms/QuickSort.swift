//
//  QuickSort.swift
//  Algorithms
//
//  Created by 유성열 on 7/9/24.
//
// MARK: - 퀵 정렬(Quick Sort)
// MARK: 분할 정복 알고리즘의 하나로, pivot을 기준으로 리스트를 두 부분으로 나누어 재귀적으로 정렬(재귀 사용)
// MARK: 정렬하기 전에 배열에 있는 숫자 중 하나를 피벗으로 설정해준다.(피벗을 설정하는 방법은 여러가지가 있지만, 쉬운 방법으로는 배열의 가장 왼쪽에 있는 값을 피벗으로 설정) 그리고 배열의 시작과 끝을 가리키는 'left'와 'right'가 있다. 그리고 피벗을 제외한 배열의 양쪽에서 값을 비교하기 위한 변수가 필요함. (leftStartIndex, rightStartIndex) * 중간 값을 피벗으로 선택할 수도 있음)
/*
 퀵 정렬의 성능은 피벗을 기준으로 배열을 반으로 나누는 것은 log n 으로 볼 수 있음(데이터 한 개가 될 때까지 반으로 나누므로)
 그리고 이렇게 나눠진 단계를 배열의 요소 개수만큼인 n 만큼 진행해야 하니 n을 곱해서 n log n 이다.(이 작업을 데이터 n번 만큼 반복해야 하므로 n을 곱함)
 -> 평균 시간 복잡도 O(n log n) : 피벗 선택이 균형 잡힌 경우, 즉 각 재귀 호출마다 리스트가 거의 반으로 나뉠 때 발생
 -> 최악의 시간 복잡도 O(n2) : 피벗 선택이 불균형하게 이루어질 때, 예를 들어 이미 정렬된 배열에서 첫 번째나 마지막 요소를 피벗으로 선택한 경우에 발생할 수 있음
 -> 최선의 시간 복잡도 O(n log n) : 피벗이 항상 리스트를 정확히 반으로 나누는 경우
 */

/*
 * 퀵 정렬의 작동 방식
 (1) 피벗 선택 : 배열에서 임의의 요소를 피벗으로 선택(피벗은 배열을 분할하는 기준이 됨)
 (2) 분할 : 피벗을 기준으로 배열을 두 부분으로 분할(피벗보다 작은 요소들은 피벗의 왼쪽, 큰 요소들은 피벗의 오른쪽 위치하게 됨)
 (3) 재귀적 정렬 : 피벗을 제외한 두 부분 배열에 대해 재귀적으로 퀵 정렬을 수행
 
 1. leftStartIndex는 오른쪽으로 이동하다가 피벗보다 큰 값을 만나면 멈춤
 2. left가 멈추면 rightStartIndex가 이동하고, 왼쪽으로 이동하다가 피벗보다 작은 값을 만나면 멈춤
 3. 두 개의 인덱스가 멈추면 이 둘의 값을 교환
 4. 그리고 다시 left가 이동하고, 그 이후 right가 이동하고.. 이런식
 5. 서로 지나쳤다면 더 이상 이동하지 않는다.(이때 left는 right 오른쪽에 있기 데ㅚ고, right는 left 왼쪽에 있게 된다.) -> 이 상태에서 pivot과 rightStartIndex의 값을 교환해주게 되면 rightStartIndex를 기준으로 왼쪽에 있는 값들은 전부 기준보다 작은 값이다.(오른쪽은 기준보다 큰 값이 됨)
 6. 여기까지가 기준 값이 정렬된 것이다. (피벗 값이 정렬되고 그 위치에 있게 디며, 이후에 더 이상 이동하지 않음)
 7. 이젠 왼쪽의 배열을 위와 같은 방식으로 정렬하고 그리고 오른쪽도 같은 방법으로 정렬시킨다.(일단 중간값을 먼저 맞추는 듯 하다.)
*/

/*
 * 실행 예시
 ex) 배열 [3, 6, 8, 10, 1, 2, 1]
 
 1. 피벗 선택 : 첫 번째 요소인 '3'을 피벗으로 선택
 2. 분할 :
    - 피벗 '3'보다 작은 요소들 '[1, 2, 1]'
    - 피벗 '3'보다 큰 요소들 '[6, 8, 10]'
 3. 결합 :
    - 재귀적으로 정렬된 작은 요소들 '[1, 1, 2]'
    - 피벗 '[3]'
    - 재귀적으로 정렬된 큰 요소들 '[6, 8, 10]'
 
 ----> 정렬된 배열 '[1, 1, 2, 3, 6, 8, 10]
 */

import Foundation

// 배열의 요소들 간의 대소 비교가 필요하므로 Comparable 프로토콜 채택된 제네릭타입만 받아주도록 설정하였음(그게 아니라면 커스텀해야함)
func quickSort<T: Comparable>(_ array: [T]) -> [T] {
    // 배열이 비어있거나 요소가 하나뿐인 경우 이미 정렬된 상태
    guard array.count > 1 else { return array }
    
    // 배열의 첫 번째 요소를 피벗으로 선택
    let pivot = array[0]
    
    // 피벗보다 작은 요소들(필터함수로 작은 요소들 배열 반환)
    // dropFirst() 메서드는 첫 번째 요소(또는 지정된 (n)개수만큼)을 제거하고 '새로운' 시퀀스나 컬렉션을 반환함(원본 데이터는 변경되지 않고, 새로운 서브 시퀀스나 서브 컬렉션이 생성되어 반환)
    let less = array.dropFirst().filter { $0 <= pivot } // leftStartIndex
    
    // 피벗보다 큰 요소들
    let greater = array.dropFirst().filter { $0 > pivot } // rightStartIndex
    
    // 재귀적으로 정렬 후 피벗을 가운데 두고 결합
    return quickSort(less) + [pivot] + quickSort(greater)
}
