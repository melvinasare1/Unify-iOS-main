//
//  UniversitySelectViewModel.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 04/03/2021.
//

import Observable

class UniversitySelectViewModel {

    public var universityObservable: MutableObservable<[University]>
    public var filteredUniversity: [University] = []
    public var isSearching: Bool = false
    public var userId: String?

    init(userId: String?) {
        self.userId = userId
        universityObservable = MutableObservable([])
    }

    func checkIfUsersLoggedIn(_ completion: @escaping (Bool) -> Void) {
        if userId == "" {
            AccountManager.account.signout()
            completion(false)
            return
        }
        completion(true)
    }

    func uni(for indexPath: IndexPath) -> University? {
        return universityObservable.wrappedValue.object(at: indexPath.row)
    }

    func retrieveUniversityData(_ completion: @escaping ([University]) -> Void) {
        NetworkManager.shared.fetchUnivertyData { university in
            completion(university)
        }
    }
}
