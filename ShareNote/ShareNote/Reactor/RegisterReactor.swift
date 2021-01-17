//
//  RegisterReactor.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/17.
//

import Foundation
import ReactorKit

class RegisterReactor: Reactor {
    enum Action {
    }
    
    enum Mutation {
    }
    
    struct State {
    }
    
    var initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
    }
}
