import Foundation
import PlaygroundSupport

// Enable indefinite execution to allow the async task to complete
PlaygroundPage.current.needsIndefiniteExecution = true

// Function to make a GET request
func makeGetRequest(url: URL) {
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            PlaygroundPage.current.finishExecution()
            return
        }
        
        guard let data = data else {
            print("No data received")
            PlaygroundPage.current.finishExecution()
            return
        }
        
        let responseString = String(data: data, encoding: .utf8)
        print("GET Response: \(responseString ?? "Unable to convert data to string")")
        
        PlaygroundPage.current.finishExecution()
    }
    
    task.resume()
}

// Function to make a POST request
func makePostRequest(url: URL, body: [String: Any]) {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = jsonData
    } catch {
        print("Error serializing JSON: \(error.localizedDescription)")
        PlaygroundPage.current.finishExecution()
        return
    }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            PlaygroundPage.current.finishExecution()
            return
        }
        
        guard let data = data else {
            print("No data received")
            PlaygroundPage.current.finishExecution()
            return
        }
        
        let responseString = String(data: data, encoding: .utf8)
        print("POST Response: \(responseString ?? "Unable to convert data to string")")
        
        PlaygroundPage.current.finishExecution()
    }
    
    task.resume()
}

// URL for the request
let urlString = "https://birdifyapplication.azurewebsites.net/api/golfers"
guard let url = URL(string: urlString) else {
    print("Invalid URL")
    PlaygroundPage.current.finishExecution()
}

// Choose the request type: "GET" or "POST"
let requestType = "POST"

if requestType == "GET" {
    makeGetRequest(url: url)
} else if requestType == "POST" {
    // Data to be posted
    let postData: [String: Any] = [
        "id": "12345",
        "name": "John Doe",
        "handicap": 10,
        "scores": [0, 1, 2, 3, 4, 5]
    ]
    
    makePostRequest(url: url, body: postData)
}
