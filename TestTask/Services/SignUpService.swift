//
//  SignUpService.swift
//  TestTask
//

import Foundation
import UIKit

struct SignUpService {

    /// Fetch an authorization token from the API
    func getToken() async -> String? {
        guard let url = URL(string: "https://frontend-test-assignment-api.abz.agency/api/v1/token") else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(TokenResponse.self, from: data)
            return decoded.success ? decoded.token : nil
        } catch {
            print("Token fetch error: \(error)")
            return nil
        }
    }

    /// Load all available positions from the API
    func loadAllPositions() async -> [Position] {
        guard let url = URL(string: "https://frontend-test-assignment-api.abz.agency/api/v1/positions") else { return [] }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(PositionsResponse.self, from: data)
            return decoded.success ? (decoded.positions ?? []) : []
        } catch {
            print("Load positions error: \(error)")
            return []
        }
    }

    /// Send a multipart/form-data POST request to register a new user
    func signUp(name: String, email: String, phone: String, positionID: Int, photoName: String, imageData: Data, token: String) async throws -> Bool {
        // Prepare the request URL
        guard let url = URL(string: "https://frontend-test-assignment-api.abz.agency/api/v1/users") else {
            throw URLError(.badURL)
        }

        let boundary = "Boundary-\(UUID().uuidString)"

        // Set up the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue(token, forHTTPHeaderField: "Token")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        // Construct the multipart/form-data body
        var body = Data()
        let parameters = [
            "name": name,
            "email": email,
            "phone": "+38\(phone)",
            "position_id": "\(positionID)"
        ]

        // Add text parameters
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }

        // Add image data as "photo" field
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"\(photoName)\"\r\n")
        body.append("Content-Type: image/jpeg\r\n\r\n")
        body.append(imageData)
        body.append("\r\n")
        body.append("--\(boundary)--\r\n")

        request.httpBody = body

        // Send the request and check the response
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { return false }

        if httpResponse.statusCode == 201 {
            // User created successfully
            return true
        } else {
            // Parse error response from server
            let decoded = try JSONDecoder().decode(Response.self, from: data)
            throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: decoded.message])
        }
    }
}
