import XCTest
@testable import CleanArchitecture

class MockAuthenticationService: AuthenticationService {
  var shouldAuthenticate = false
  
  func authenticate(username: String, password: String) -> Bool {
    return shouldAuthenticate
  }
}

final class AuthenticationServiceTests: XCTestCase {
  var userRepository: UserRepositoryProtocol!
  var authenticationService: AuthenticationService!
  
  override func setUp() {
    super.setUp()
    userRepository = InMemoryUserRepository()
    authenticationService = DefaultAuthenticationService(userRepository: userRepository)
  }
  
  func testValidAuthentication() async throws {
    do {
      _ = try await authenticationService.authenticate(username: "demo", password: "password")
      XCTAssertTrue(true) // Indicates success since no error was thrown
    } catch {
      XCTFail("Expected successful authentication but error was thrown: \(error)")
    }
  }
  
  func testInvalidAuthentication() async throws {
    do {
      _ = try await authenticationService.authenticate(username: "demo", password: "wrongPassword")
      XCTFail("Expected incorrect password error but authentication passed")
    } catch let error as AuthenticationError {
      XCTAssertEqual(error, AuthenticationError.incorrectPassword)
    }
  }
  
  func testNonexistentUser() async throws {
    do {
      _ = try await authenticationService.authenticate(username: "nonexistent", password: "password")
      XCTFail("Expected user not found error but authentication passed")
    } catch let error as AuthenticationError {
      XCTAssertEqual(error, AuthenticationError.userNotFound)
    }
  }
}
