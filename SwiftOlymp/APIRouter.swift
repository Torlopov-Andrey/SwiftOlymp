import Foundation
import Alamofire

enum APIRouter {
    
    case news
    case detail(newsId: String)
}

extension APIRouter: URLRequestConvertible {
    
    static let version: Int = 1
    static let apiURL: URL = URL(string: "https://api.tinkoff.ru/")!
    static let userAgent: String = {
        return "TinkoffTest:Torlopov.Andrey)"
    }()

    private struct Components {
        
        var version: Int = APIRouter.version
        var path: String!
        var parameters: [String: Any] = [:]
        var headers: [String: String] = [:]
        var encoding: ParameterEncoding = URLEncoding.default
    }

    func asURLRequest() throws -> URLRequest {
        let components = self.components
        
        let url = APIRouter.apiURL
            .appendingPathComponent("v\(components.version)")
            .appendingPathComponent(components.path)

        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-type")
        request.setValue(APIRouter.userAgent, forHTTPHeaderField: "User-Agent")
        
        for header in components.headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }

        return try components.encoding.encode(request, with: components.parameters)
    }

    private var components: Components {
        var components = Components()

        switch self {
        case .news:
            components.path = "news"
        case .detail(let newsId):
            components.path = "news_content"
            components.parameters["id"] = newsId
        }
        
        return components
    }

    private var method: HTTPMethod {
        return .get
    }
}

