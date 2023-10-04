import Foundation

protocol AuthenticationService {
  func authenticate(username: String, password: String) async throws -> Bool
}

class DefaultAuthenticationService: AuthenticationService {
  private let userRepository: UserRepositoryProtocol
  
  init(userRepository: UserRepositoryProtocol) {
    self.userRepository = userRepository
  }
  
  func authenticate(username: String, password: String) async throws -> Bool {
    let user = try await userRepository.getUser(username: username)
    
    if user.password == password {
      return true
    } else {
      throw AuthenticationError.incorrectPassword
    }
  }
}
