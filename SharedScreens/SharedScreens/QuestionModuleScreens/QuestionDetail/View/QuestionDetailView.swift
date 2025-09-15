import CommonUI
import SwiftUI

struct QuestionDetailView: View {
    @ObservedObject var viewModel: QuestionDetailViewModel

    var body: some View {
        ScrollView {
            YHBaseCell(state: .questionDescription(title: viewModel.question.question, text: viewModel.question.questionDescription))

            YHBaseCell(state: .answer(title: Constants.shortAnswerTitle, text: viewModel.question.shortAnswer))

            YHBaseCell(state: .answer(title: Constants.longAnswerTitle, text: viewModel.question.longAnswer))
        }
    }
}

private extension QuestionDetailView {
    enum Constants {
        static let shortAnswerTitle = "Краткий ответ"
        static let longAnswerTitle = "Развернутый ответ"
    }
}

#Preview {
    QuestionDetailView(viewModel: QuestionDetailViewModel(
        question: QuestionDetailModel(
            question: "Какой тег используется для создания ссылок в HTML?",
            questionDescription: "Этот вопрос проверяет знание тега <a>, который используется для создания гиперссылок в HTML, и понимание его базовых атрибутов.",
            shortAnswer: "<p># Пример текста с разной вложенностью и форматированием\n\n## 1. Основной раздел\n\nЭто **основной** текст с *разными* стилями форматирования.\n\n### 1.1 Подраздел\n\n* Элемент списка 1\n\n* Элемент списка 2\n\n  * Вложенный элемент\n\n  * Еще один вложенный\n\n<strong>### 1.2 Код</strong>\n\nВот пример кода на Python:\n\npython\n\nCopy\n\nDownload\n\n```plaintext\ndef hello_world():\n    print(\"Привет, мир!\")\n\nhello_world()\n```\n\n## 2. Дополнительная информация\n\n&gt; Это цитата, которая выделяется для важности.\n\n### 2.1 Таблица\n\n**Заголовок 1Заголовок 2**Данные 1Данные 2Данные 3Данные 4\n\n### 2.2 Форматированный текст\n\nВот `моноширинный` текст, а также **жирный** и *курсив*.\n\n#### 2.2.1 Глубокая вложенность\n\nЭтот текст находится на **третьем** уровне вложенности.\n\n---\n\n### 3. Заключение\n\nСпасибо за внимание! Вот еще один блок кода (JavaScript):\n\njavascript\n\nCopy\n\nDownload\n\n```plaintext\nconst sum = (a, b) =&gt; a + b;\nconsole.log(sum(2, 3)); // 5\n```\n\n**Конец документа.** 🚀</p>",
            longAnswer: "# Пример текста с разной вложенностью и форматированием\n\n## 1. Основной раздел\n\nЭто **основной** текст с *разными* стилями форматирования.\n\n### 1.1 Подраздел\n\n* Элемент списка 1\n\n* Элемент списка 2\n\n  * Вложенный элемент\n\n  * Еще один вложенный\n\n### 1.2 Код\n\nВот пример кода на Python:\n\npython\n\nCopy\n\nDownload\n\n```plaintext\ndef hello_world():\n    print(\"Привет, мир!\")\n\nhello_world()\n```\n\n## 2. Дополнительная информация\n\n> Это цитата, которая выделяется для важности.\n\n### 2.1 Таблица\n\n**Заголовок 1Заголовок 2**Данные 1Данные 2Данные 3Данные 4\n\n### 2.2 Форматированный текст\n\nВот `моноширинный` текст, а также **жирный** и *курсив*.\n\n#### 2.2.1 Глубокая вложенность\n\nЭтот текст находится на **третьем** уровне вложенности.\n\n---\n\n### 3. Заключение\n\nСпасибо за внимание! Вот еще один блок кода (JavaScript):\n\njavascript\n\nCopy\n\nDownload\n\n```plaintext\nconst sum = (a, b) => a + b;\nconsole.log(sum(2, 3)); // 5\n```\n\n**Конец документа.** 🚀"
        )
    ))
}
