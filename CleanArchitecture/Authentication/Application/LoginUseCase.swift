import Foundation

protocol LoginUseCaseProtocol {
  func execute(username: String, password: String) async throws -> Bool
}

class DefaultLoginUseCase: LoginUseCaseProtocol {
  private let authenticationService: AuthenticationService
  
  init(authenticationService: AuthenticationService) {
    self.authenticationService = authenticationService
  }
  
  func execute(username: String, password: String) async throws -> Bool {
    return try await authenticationService.authenticate(username: username, password: password)
  }
}
