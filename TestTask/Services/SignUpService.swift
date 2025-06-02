//
//  SignUpService.swift
//  TestTask
//

import Foundation

import Foundation
import UIKit

struct SignUpService {
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

    func signUp(name: String, email: String, phone: String, positionID: Int, photoName: String, imageData: Data, token: String) async throws -> Bool {
        guard let url = URL(string: "https://frontend-test-assignment-api.abz.agency/api/v1/users") else {
            throw URLError(.badURL)
        }

        let boundary = "Boundary-\(UUID().uuidString)"

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue(token, forHTTPHeaderField: "Token")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()
        let parameters = [
            "name": name,
            "email": email,
            "phone": "+38\(phone)",
            "position_id": "\(positionID)"
        ]

        for (key, value) in parameters {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }

        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"\(photoName)\"\r\n")
        body.append("Content-Type: image/jpeg\r\n\r\n")
        body.append(imageData)
        body.append("\r\n")
        body.append("--\(boundary)--\r\n")

        request.httpBody = body

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { return false }

        if httpResponse.statusCode == 201 {
            return true
        } else {
            let decoded = try JSONDecoder().decode(Response.self, from: data)
            throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: decoded.message])
        }
    }
}
