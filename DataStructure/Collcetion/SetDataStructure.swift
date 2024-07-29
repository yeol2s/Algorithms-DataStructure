//
//  SetDataStructure.swift
//  Algorithms
//
//  Created by 유성열 on 7/24/24.
//
// MARK: - 집합(Set)
// MARK: Set은 고유한 값을 저장하는 순서가 없는 컬렉션(중복된 값을 허용하지 않는 고유한 값 사용, 값의 순서가 중요하지 않을 때 사용)
// 중복 요소는 제거가 된다.(합집합, 교집합, 차집합, 대칭차집합 등이 필요한 경우 주로 사용)
// Set의 각 요소도 Hashable하며 검색 속도가 빠름
// 순서가 없으므로 반복문 사용시 실행할 때 마다 순서가 달라짐
/*
 * Set의 특징 :
    - 중복 불가능 : Set은 고유한 값을 저장(같은 값을 여러 번 추가해도 한 번만 저장)
    - 순서 없음 : 순서를 유지하지 않음(값을 순회할 때 마다 순서가 달라짐)
    - 빠른 검색 및 삽입 : 내부적으로 HashTable을 사용하여 값을 저장하므로, 값의 검색, 삽입, 삭제가 빠르다.(일반적으로 O(1)의 시간 복잡도)
    - Set에 저장되는 요소는 반드시 Hashable 프로토콜을 준수해야 한다.
 
 * Set 의 장점 :
    - 중복 요소를 허용하지 않으므로 중복 제거가 필요한 경우 매우 유용
    - 빠른 검색과 수정(해시테이블을 기반으로 하여 요소의 삽입, 삭제, 검색이 평균적으로 O(1)의 시간 복잡도를 가지므로 대량의 데이터를 처리할 때 매우 빠른 성능 제공
    - 집합 연산 지원(수학적 집합 연산을 쉽게 수행 가능)
    - (Hashable) 해시 기반의 데이터 저장 및 검색이 가능
 
 * Set의 단점 :
    - 순서가 없다(순서가 필요한 경우 배열로 변환해야 하는데 추가적인 작업이 발생)
    - 메모리 사용량이 배열보다 많다.(Set은 해시 테이블을 사용하기 때문에 동일한 양의 데이터를 저장하는 배열보다 메모리를 더 많이 사용할 수 있음)
    - 제한된 요소 타입(Set의 요소는 Hashable 프로토콜을 준수해야 하므로 모든 타입의 데이터를 저장할 수 없다.)
 
 * Set의 사용 예 :
    - 중복 제거(데이터의 중복을 자동으로 관리해야 하는 경우 : ex) 데이터 정리, 중복 사용자 제거 등))
    - 집합 연산(두 개 이상의 컬렉션 간의 교집합, 합집합, 차집합 등의 연산이 필요할 때)
    - 빠른 포함 검사 : 특정 요소의 존재 여부를 빠르게 확인해야 하는 경우
*/


import Foundation

class SetDataStructure {
    
    // MARK: Set의 사용
    var nums: Set<Int> = [] // (정식문법) 빈 Set 생성
    //var nums: Set // 단축문법
    //var nums = Set<String>() // 빈 Set 생성
    
    var numbers: Set = [1, 2, 2, 1, 3, 4, 5] // Set의 요소는 순서가 없고 중복이 되지 않으므로 [1, 2, 3, 4, 5] 이렇게 나올 수도 있고 [3, 1, 2, 4, 5] 이렇게 나올 수도 있음
    
    func setBasic() {
        // MARK: Set의 기능
        nums.count // 요소 개수
        nums.isEmpty // 비어있는지 여부
        nums.contains(3) // 인자값을 포함하는지 여부
        nums.randomElement() // 랜덤 요소 추출
        
        // 딕셔너리와 마찬가지로 insert,replace, append 메서드가 없고 update 메서드를 사용한다.(추가만 가능)
        nums.update(with: 4) // 요소 추가(중복되는 요소가 추가되면 기존 요소는 옵셔널 타입으로 반환, 새로운 요소가 추가되면 nil을 반환)
        nums.remove(3) // 삭제한 요소값을 반환(존재하지 않는 요소값을 넣으면 nil을 반환)
        nums.removeAll() // 전체 요소 삭제
        nums.removeAll(keepingCapacity: true) // 전체 요소 삭제(메모리 공간은 유지)
        
        // MARK: Set의 비교
        var aSet: Set = [1, 3, 5]
        var bSet: Set = [5, 3, 1]
        aSet == bSet // true (순서와 상관없이 요소의 값을 가지고만 비교 * 딕셔너리도 마찬가지)

        // MARK: Set 집합 여부 메서드
        var a: Set = [1, 2, 3, 4, 5, 6]
        var b: Set = [1, 3, 5] // 홀수
        var c: Set = [2, 4, 6] // 짝수
        var d: Set = [4, 5, 6, 7, 8, 9]
        
        // 부분집합 여부
        b.isSubset(of: a) // (b Set에게 물어보는 것) "b가 a의 부분 집합인지?" -> true (두 집합이 완전히 동일한 경우에도 부분 집합 관계가 성립)
        b.isStrictSubset(of: a) // (엄격한 (진)부분 집합 여부) "b가 a랑 동일하지 않으면서 정말 부분 집합인지?" -> true (두 집합이 완전히 동일하지 않아야 함)
        
        // 상위집합 여부(다른 집합들을 포함하는 집합)
        a.isSuperset(of: b) // "a가 b의 상위 집합인지?" -> true
        a.isStrictSuperset(of: b) // (엄격한 (진)상위 집합 여부) -> true
        
        // 서로소 여부(서로 다른지)
        b.isDisjoint(with: c) // "b는 c와 서로 완전히 다른지?" -> true
        
        // 합집합(전체합)
        a.union(b) // 1, 2, 3, 4, 5, 6 (a와 b의 합집합 반환)
        b.formUnion(a) // (원본 변경) b의 원본 요소가 변경되어 1, 2, 3, 4, 5, 6 이 됨
        
        // 교집합(겹치는 부분만)
        a.intersection(b) // 1, 3, 5 반환
        a.formIntersection(b) // (원본 변경) a의 원본 요소가 변경되어 1, 3, 5가 됨
        
        // 차집합(대상과 겹치는 부분 삭제)
        a.subtracting(d) // 1, 2, 3 반환(a집합에서 b집합에 포함된 요소를 제외한 새로운 집합 반환 - '7, 8, 9'도 제외되었음 d의 집합이기 때문)
        a.subtract(d) // (상동) 원본 변경
        
        // 대칭차집합(대상과 겹치는 부분 삭제하고 겹치지 않는 부분은 가져옴)
        a.symmetricDifference(d) // 1, 2, 3, 7, 8, 9 (차집합과 비슷하지만 겹치는 부분만 제외되고 d의 값도 가져옴)
        a.formSymmetricDifference(d) // (상동) 원본 변경
        
        // MARK: Set을 정렬하려면?
        nums.sorted() // sroted() 메서드를 통해 정렬하게 되면 배열(Array)로 리턴이 된다.
    }
}
