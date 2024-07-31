//
//  ArrayDataStructure.swift
//  Algorithms
//
//  Created by 유성열 on 7/19/24.
//
// MARK: - 배열(Array)
// MARK: 데이터를 (Index 0부터)순서대로 저장(순서가 있음), 중복 값 저장 가능
// 순서가 있는 컬렉션, 같은 타입의 값을 저장하며 배열은 0부터 시작하는 인덱스를 가지고 인덱스를 통해 요소에 접근
// 한개의 배열에는 동일한 데이터 타입만 담을 수 있다.
// startIndex는 0, endIndex는 메모리 공간에 있는 인덱스의 끝의 값을 알려주므로 실제로는 endIndex - 1로 접근해야 마지막 요소에 접근 가능하다.
// 배열 비교시 저장 순서도 비교함(개별 요소 비교)

/*
 * 배열의 특징 : 
    - 인덱스 기반 접근 : 배열은 내부적으로 연속된 메모리 블록을 사용하므로 배열은 인덱스를 사용하여 요소에 빠르게 접근 가능
    - 값의 순서가 보장(추가한 요소 순서대로)
    - 배열은 제네릭 타입(다양한 타입을 포함할 수 있음)
    - 크기 조정 : 배열은 동적으로 크기를 조정할 수 있음, 요소를 추가하거나 제거할 때 배열의 크기는 자동으로 조정된다.(일반적으로 상수 시간 O(1)의 복잡도를 가짐)
    - 고유 요소 보장하지 않음 : 배열은 중복된 요소를 허용하므로, 고유한 요소를 필요로 하는 경우 추가적인 처리가 필요
 
 * 배열의 장점 :
    - 빠른 접근 시간 : 배열은 인덱스를 기반으로 한 빠른 요소 접근이 가능(특정 위치의 요소에 대한 조회나 수정이 매우 빠름)(정렬된 배열은 비정렬 배열에 비해 검색 속도가 더 빠름)
    - 메모리 효율성 : 배열은 연속된 메모리 공간에 요소를 저장하므로, 메모리 캐시 효율성이 높다.
        * 배열은 연속된 메모리에 저장되지만, 요소가 추가되거나 제거될 때마다 항상 연속된 메모리에 저장되는 것이 보장되지는 않는다.
          배열은 요소가 추가될 때 마다 내부적으로 현재 크기와 필요한 크기를 비교하여 필요에 따라 크기를 조절하는데, 이 때 크기를 조정할 때마다 새로운 메모리 블록을 할당하고 기존 요소를 복사하는 경우가 일반적임
          이 과정에서 연속된 메모리 구조는 보존될 수 있지만 항상 보장되지 않는다. (메모리가 재할당되므로 이전 메모리 공간이 해제될 수 있으므로 새로 할당된 메모리 공간이 이전 공간과 물리적으로 연속된 것이 아닐 수 있다.)
        * 배열은 일반적으로 크기를 조정할 때 미리 여유 공간을 할당한다.(예를 들어, 요소를 추가할 때마다 일정 크기 이상의 여유 공간을 확보하여 새로운 요소를 추가하는 경우 추가적인 요소를 위해 새로운 메모리 공간을 할당하는 횟수를 줄 일 수 있음)
    - 다양한 활용 : 배열은 다양한 데이터 저장과 접근 패턴에 유용(데이터를 정렬하거나 필터링하는 등의 작업 수행)
 
 * 배열의 단점 :
    - 중간 삽입/삭제의 비효율성 : 배열은 특정 인덱스에 요소를 삽입하거나 삭제할 때, 그 위치 이후의 모든 요소를 이동시켜야 하는 경우가 발생함(평균적으로 O(n)의 시간 복잡도를 가지므로 많은 삽입/삭제 연산이 필요한 경우 성능이 저하됨)
    - 고정된 크기의 초기 할당 : 배열은 초기에 크기를 정해주지 않으면 작은 크기로 시작하여 요소를 추가할 때 마다 동적으로 크기를 조정하는데, 큰 배열을 초기에 생성할 경우 불필요한 메모리 사용 발생
    - 검색 시 성능 저하 가능성 : 배열은 인덱스 기반으로 접근이 빠르지만, 특정 요소를 검색하는 경우 배열 전체를 순회해야 할 수 있으므로 최악의 경우 O(n)의 시간 복잡도가 발생할 수 있다.
*/

import Foundation

class ArrayDataStructure {
    
    // MARK: 빈 배열 생성
    var nums: Array<Int> = []
    // var nums: Array<Int>()
    // var nums: [Int] = []
    // var nums: [Int]()
    
    // MARK: 배열 요소 저장
    var numbers = [1, 2, 3, 4, 5]
    // var numbers = Array(1...45) // (범위연산자 사용) 1~45까지 숫자를 생성해서 배열에 넣음
    
    // MARK: 인덱스 범위로 요소 접근
    // numbers[0..<2] // 첫 번째 요소(인덱스: 0)부터 두 번째 요소(인덱스 1)까지 포함
    
    // MARK: 특정 값으로 초기화된 배열을 생성
    let array = [Int?](repeating: nil, count: 5) // 옵셔널 [Int?] 타입의 배열 생성 repeating: 배열의 모든 요소를 'nil'로 초기화, count: 배열의 크기 지정(5개의 요소)
    // let array = [Int](repeating: 0, count 4) // 논옵셔널
    
    // MARK: 배열의 배열(2차원 배열, 다차원 배열)
    var arrays = [[Int]]()
    // arrays.append([1, 2, 3])
    // arrays.append([4, 5, 6])
    // print(arrays) // [[1, 2, 3], [4, 5, 6]]
    
    /*
    // 2차원 배열의 선언과 초기화
    var arrays: [[Int]] = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
    ]
    
    // 특정 요소에 접근
    let element = arrays[1][2] // 2차원 배열의 두 번째 행, 세 번째 열의 요소에 접근([행],[열])
    print(element) // 출력 : 6
    */
    
    
    // MARK: 배열의 접근
    func arrayAccess() {
        numbers[0] // 첫 번째 인덱스 접근
        numbers[0] = 7 // 첫 번째 인덱스 요소 값 변경
        
        numbers.first // 0번 인덱스 요소 꺼내옴(복사)(옵셔널로 반환하고 비어있다면 nil 반환)
        numbers.last // 마지막 인덱스 요소 꺼내옴(복사)(옵셔널 반환)
        
        numbers.startIndex // 시작 인덱스(항상 '0'이 나옴)
        numbers.endIndex // 마지막 인덱스(배열 메모리 공간에서의 인덱스의 끝의 값. 실제 요소 요소 접근을 위해서는 'endIndex - 1' 을 해줘야함)
        
        numbers.index(1, offsetBy: 2) // 1번 인덱스부터 2만큼 떨어진 인덱스 -> 3번 인덱스
        
        numbers.firstIndex(of: 2) // 인덱스 앞부터 찾았을 때 정수 '2'는 몇번째 인덱스?(옵셔널)
        numbers.lastIndex(of: 2) // 인덱스 뒤부터 찾았을 때 정수 '2'는 몇번째 인덱스?(옵셔널)
        // firstIndex 사용 예)
        if let index = numbers.firstIndex(of: 3) { // 특정 값의 인덱스를 찾고
            numbers.remove(at: index) // 해당 인덱스의 요소 삭제 ('3' 삭제)
        }
        
        // MARK: '배열의 배열' 접근
        // var arrays = [[1, 2, 3], [4, 5, 6]] // [[Int]]
        // arrays[0][2] // 0번째 배열의 2번째 Index 접근 -> '3'

    }
    
    // MARK: - 배열의 변경
    func arrayChange() {
        // 삽입(insert)
        numbers.insert(3, at: 4) // 4번째 Index에 값 삽입(추가되는 것)(중간에 삽입하면 이후 값들은 인덱스가 뒤로 밀림)
        numbers.insert(contentsOf: [0, 1, 2], at: 0) // contentsOf: 배열 형태로 삽입
        
        // 교체(replace)
        numbers[0] = 7 // 해당 Index의 값 변경
        numbers[0...2] = [5, 6, 7] // 범위 Index의 값 변경 (빈 배열 할당은 범위만큼 삭제)
        numbers.replaceSubrange(0...2, with: [5, 6, 7]) // replaceSubrange(): 범위만큼 교체하는 함수
        
        // 추가(append)
        numbers += [6] // 배열 마지막 끝에 추가
        numbers.append(6) // 배열 마지막 끝에 추가
        numbers.append(contentsOf: [6, 7, 8]) // 배열 마지막 끝에 배열형태로 추가(합쳐짐)
        
        // 삭제(remove)
        numbers[0...2] = [] // 범위만큼 삭제(빈 배열)
        numbers.remove(at: 3) // 해당 Index의 값 삭제
        numbers.removeSubrange(0...2) // removeSubrange(): 범위 Index 만큼 삭제하는 함수
        
        // First, Last 인덱스 삭제(배열이 비어있는지 확인을 잘 해야함, 비어있는데 삭제를 한다면 에러 발생)
        numbers.removeFirst() // 맨 앞 요소 삭제하고 삭제된 요소는 반환
        numbers.removeFirst(2) // 맨 앞 2개 요소 삭제(반환 안함)(2번 Index가 아닌 2개를 삭제한다는 의미)
        numbers.removeLast() // 맨 뒤 요소 삭제하고 삭제된 요소는 반환
        numbers.removeLast(2) // 맨 뒤 요소 삭제(반환 안함)
        // 제거 및 옵셔널로 반환하는 메서드
        // MARK: remove / pop 메서드는 배열의 상태에 따라 안전한 처리가 필요한 경우 'pop'을 사용하고 배열이 비어있지 않다는 것을 보장할 수 있을 때는 'remove' 메서드를 사용하는 것이 좋음.
        // numbers.popFirst() // 배열의 첫 번째 요소를 제거하고 반환하는데 해당 요소를 옵셔널로 반환한다. (배열이 비어있는 경우 nil을 반환하므로 배열이 비어있어도 안전하게 호출 가능
        // numbers.popLast() // 배열의 마지막 요소를 제거하고 해당 요소를 옵셔널 반환
        
        numbers.removeAll() // 배열 요소 모두 삭제
        //numbers.removeAll(where: <#T##(Int) throws -> Bool#>) // 조건을 만족하는 모든 데이터 삭제((클로저)배열의 각 요소를 인자로 받아 Bool 반환 -> true를 반환하면 해당 요소가 삭제)
        // numbers.removeAll { $0 == 3 } // 값이 3인 모든 요소 삭제
        numbers.removeAll(keepingCapacity: true) // 메모리 공간에 저장공간은 일단 두고 데이터(요소)만 날림(메모리 공간을 유지하므로 추후 할당시에 더 빠르게 할당) keepingCapacity : 용량 유지
    }
    
    // MARK: - 배열의 기능
    func arrayBasic() {
        // MARK: 기본 기능
        numbers.count // 요소의 개수
        numbers.isEmpty // 요소가 비어있는지 여부(Bool)
        numbers.contains(3) // 포함여부를 물어보는 함수(인자값으로 전달 -> Bool)
        numbers.randomElement() // 요소중 랜덤으로 하나의 요소 추출(옵셔널)
        numbers.swapAt(0, 1) // Index 값으로 두 요소의 값을 교환
        
        // MARK: 기타 기능
        // 컬렉션에서 정렬 관련한 메서드의 이름이
        // 동사 원형(sort(), reverse(), shuffle() 등)인 경우는 -> '직접적으로 요소의 값을 변경(리턴하지 않음)'
        // 분사 형태(ing, ed)-(sorted(), reversed(), shuffled() 등)인 경우는 -> '직접 변환하지 않고 '배열'을 리턴함'
        numbers.sort() // 배열을 오름차순으로 직접 정렬(배열 반환 안함)
        numbers.sorted() // 배열을 오름차순으로 정렬 후 배열을 반환(원본 배열 유지)(배열 반환)
        
        numbers.reverse() // 배열을 역순으로 직접 정렬(배열 리턴 안함)
        numbers.reversed() // 배열을 역순으로 정렬 후 배열을 반환(원본 유지)(배열 반환)
        
        numbers.sorted().reversed() // (체이닝) 배열을 오름차순 정렬 후 -> 역순으로 '읽을 수 있도록' 함(reversed()가 반환하는 타입은 'ReversedCollection' 타입으로 읽기만 가능하므로 실제 사용하려면 Array()로 감싸줘야 함)
        
        numbers.shuffle() // 배열 요소 위치 랜덤 변경(직접 변경)(배열 반환 안함)
        numbers.shuffled() // 배열 요소 위치 랜덤 변경(원본 유지)(배열 반환)
        
        for i in numbers.enumerated() { // 배열 요소들을 네임드 튜플 형태로 한개씩 전달(offest: Index, element: 요소값)으로 전달
            print("\(i.0), \(i.1)") // "\(i.offset), \(i.element)" 튜플에 접근하는 것
        }
//        for (index, number) in numbers.enumerated() { // 바로 뽑아서 튜플에 담기
//            print("\(index), \(number)")
//        }
        
        numbers.dropFirst() // 첫 번째 요소를 제거한 새로운 Sequence 타입을 반환(원본 유지), 정수의 경우 반환 타입은 'ArraySlice'이고 문자열 경우 반환 타입은 'Substring'으로 반환
        
        // 배열에서 가장 큰 값, 작은 값 찾기(옵셔널로 반환)(min() : 가장 작은 값)
        if let maxNumber = numbers.max() {}
    }
}


