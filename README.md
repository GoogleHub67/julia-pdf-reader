# 📄 Julia PDF Reader & Text Extractor Tool

A native, lightweight command-line interface (CLI) tool written in **Julia** to extract raw plaintext data and structural metadata from digital PDF files without heavy external dependencies.

---

## 🛠️ Requirements & Installation

1. Make sure you have [Julia](https://julialang.org) installed on your machine.
2. Clone this repository (or download the files) to your local computer.
3. Open your terminal or command prompt inside this folder and run the following command to automatically install the required dependencies listed in `Project.toml`:

```bash
julia --project=. -e "using Pkg; Pkg.instantiate()"
```

---

## 🚀 How to Run the Tool

To read a PDF file, invoke the script using the terminal and pass the path of your target document as a trailing argument:

```bash
julia --project=. pdf_reader.jl "path/to/your/document.pdf"
```

### 📋 Features Included
* **Metadata Parsing:** Dynamically logs document metadata properties (Author, Creator, Version).
* **Sequential Extraction:** Iterates through available document blocks, displaying clear terminal dividers per page.
* **Stream Buffer Processing:** Uses fast internal memory streams to process page text safely before garbage collection.

---

## 💡 Troubleshooting Tips

* **Two-Column Layouts:** If reading complex research papers, the extracted text order can sometimes bundle horizontally across columns. For complex structures, you can expand the script using `pdPageGetContentObjects(page)` to separate objects manually.
* **Scanned Files:** If the tool outputs `[Scanned Page or No Text Structural Data Available]`, your file consists of flat image layers. You will need an OCR layer handler like `Tesseract.jl` to handle them.
