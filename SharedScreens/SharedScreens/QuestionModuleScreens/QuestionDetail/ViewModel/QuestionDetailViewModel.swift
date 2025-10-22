import Foundation

public final class QuestionDetailViewModel {
    let question: QuestionsModel

    init(question: QuestionsModel) {
        self.question = question
    }
    
    var formattedShortAnswer: String {
        parseHTML(question.shortAnswer)
    }
    
    var formattedLongAnswer: String {
        parseHTML(question.longAnswer)
    }
}

private extension QuestionDetailViewModel {
    
    func parseHTML(_ html: String?) -> String {
        guard let html = html, !html.isEmpty else {
            return ""
        }
        
        guard let data = html.data(using: .utf8) else {
            return html
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return html
        }
        
        return attributedString.string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
