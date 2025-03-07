//
//  Objects.swift
//  Almofireproj
//
//  Created by Mohammad Aboelnasr on 07/03/2025.
//

import Foundation
import Alamofire

struct MyObjects: Identifiable, Codable {
    var id, name: String
    var data: DataClass?
}

struct DataClass: Codable {
    var color, capacity: String?
    var capacityGB: Int?
    var price: Double?
    var generation: String?
    var year: Int?
    var cpuModel, hardDiskSize: String?
    var strapColour, caseSize: String?
    var description: String?
    var screenSize: Double?
    
    enum CodingKeys: String, CodingKey {
        case color, capacity, price, generation, year, description
        case capacityGB = "capacity GB"
        case cpuModel = "CPU model"
        case hardDiskSize = "Hard disk size"
        case strapColour = "Strap Colour"
        case caseSize = "Case Size"
        case screenSize = "Screen size"
    }
    
    // Custom initialization to handle String/Double type variations for price
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        color = try container.decodeIfPresent(String.self, forKey: .color)
        capacity = try container.decodeIfPresent(String.self, forKey: .capacity)
        capacityGB = try container.decodeIfPresent(Int.self, forKey: .capacityGB)
        generation = try container.decodeIfPresent(String.self, forKey: .generation)
        year = try container.decodeIfPresent(Int.self, forKey: .year)
        cpuModel = try container.decodeIfPresent(String.self, forKey: .cpuModel)
        hardDiskSize = try container.decodeIfPresent(String.self, forKey: .hardDiskSize)
        strapColour = try container.decodeIfPresent(String.self, forKey: .strapColour)
        caseSize = try container.decodeIfPresent(String.self, forKey: .caseSize)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        screenSize = try container.decodeIfPresent(Double.self, forKey: .screenSize)
        
        // Handle price that could be either Double or String
        if let priceDouble = try? container.decodeIfPresent(Double.self, forKey: .price) {
            price = priceDouble
        } else if let priceString = try? container.decodeIfPresent(String.self, forKey: .price),
                  let priceValue = Double(priceString) {
            price = priceValue
        } else {
            price = nil
        }
    }
}

class ObjectsApicall {
    func fetchObjects() async throws -> [MyObjects] {
        let url = "https://api.restful-api.dev/objects"
        let response = try await AF.request(url)
            .validate()
            .serializingDecodable([MyObjects].self)
            .value
        return response
    }
}

@MainActor
class ObjectsMVVM: ObservableObject {
    @Published var objects: [MyObjects] = [] // Fixed naming to MyObject

    func fetchObjects() {
        Task {
            do {
                self.objects = try await ObjectsApicall().fetchObjects()
            } catch {
                print("Error: \(error)")
            }
        }
    }
}
