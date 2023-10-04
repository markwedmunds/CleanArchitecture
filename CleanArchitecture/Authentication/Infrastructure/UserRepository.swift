import Foundation

enum AuthenticationError: Error {
  case userNotFound
  case incorrectPassword
  case unknownError
}

protocol UserRepositoryProtocol {
  func getUser(username: String) async throws -> User
}

class InMemoryUserRepository: UserRepositoryProtocol {
  private var users = [
    User(id: UUID(), username: "demo", password: "password")
  ]
  
  func getUser(username: String) async throws -> User {
    if let user = users.first(where: { $0.username == username }) {
      return user
    } else {
      throw AuthenticationError.userNotFound
    }
  }
}
