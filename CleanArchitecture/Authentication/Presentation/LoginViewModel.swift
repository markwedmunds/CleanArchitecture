import Foundation

@MainActor
class LoginViewModel: ObservableObject {
  @Published var username: String = ""
  @Published var password: String = ""
  @Published var isLoggedIn: Bool = false
  @Published var errorMessage: String? = nil
  
  private let loginUseCase: LoginUseCaseProtocol
  
  init(loginUseCase: LoginUseCaseProtocol) {
    self.loginUseCase = loginUseCase
  }
  
  func login() async {
    do {
      isLoggedIn = try await loginUseCase.execute(username: username, password: password)
      errorMessage = nil
    } catch let error as AuthenticationError {
      switch error {
      case .userNotFound:
        errorMessage = "User not found"
      case .incorrectPassword:
        errorMessage = "Incorrect password"
      case .unknownError:
        errorMessage = "An unknown error occurred"
      }
    } catch {
      errorMessage = error.localizedDescription
    }
  }
}

