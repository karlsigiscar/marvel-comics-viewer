import Foundation

struct Config: Codable {
    public let apiKeyPrivate: String
    public let apiKeyPublic: String
    public let rootURL: String
    public let endpoints: Endpoints
    
    init?() {
        let propertyListDecoder = PropertyListDecoder()
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist") else {
            return nil
        }
        
        let configURL = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: configURL)
            self = try propertyListDecoder.decode(Config.self, from: data)
        } catch {
            return nil
        }
    }
    
    func buildURLString(endpoint: String, match: String? = nil, timeStamp: String, hash: String, id: String? = nil) -> String {
        var urlString = "\(rootURL)\(endpoint)?ts=\(timeStamp)&apikey=\(apiKeyPublic)&hash=\(hash)"
        if let match = match, let id = id {
            urlString = urlString.replacingOccurrences(of: "{\(match)}", with: "\(id)")
        }
        return urlString
    }

    struct Endpoints: Codable {
        public let charactersList: String
        public let character: String
        public let characterComics: String
        public let characterEvents: String
        public let characterSeries: String
        public let characterStories: String
        public let comicsList: String
        public let comic: String
        public let comicCharacters: String
        public let comicCreators: String
        public let comicEvents: String
        public let comicStories: String
        public let creatorsList: String
        public let creator: String
        public let creatorComics: String
        public let creatorEvents: String
        public let creatorSeries: String
        public let creatorStories: String
        public let eventsList: String
        public let event: String
        public let eventCharacters: String
        public let eventComics: String
        public let eventCreators: String
        public let eventSeries: String
        public let eventStories: String
        public let seriesList: String
        public let series: String
        public let seriesCharacters: String
        public let seriesComics: String
        public let seriesCreators: String
        public let seriesEvents: String
        public let seriesStories: String
        public let storiesList: String
        public let story: String
        public let storyCharacters: String
        public let storyComics: String
        public let storyCreators: String
        public let storyEvents: String
        public let storySeries: String
    }
}
