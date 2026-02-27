# compiler

紀錄編譯器課程之上課lab實作以及作業

## 主要內容

1.詞法分析 (Lexical Analysis / Scanner)

主要內容：讀取原始程式碼（Source Code），將字元序列轉換為有意義的標記（Tokens），例如關鍵字、變數名稱、運算子等。使用 Lex、Flex 等工具，或是自行撰寫正規表示式（Regular Expressions）與狀態機（FSM）來完成。

2.語法分析 (Syntax Analysis / Parser)

主要內容：根據程式語言的文法規則（Context-Free Grammar），檢查 Tokens 的排列是否合法，並建立抽象語法樹（Abstract Syntax Tree, AST）。使用 Yacc、Bison 等解析器生成工具。
