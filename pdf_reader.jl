using PDFIO

"""
    read_pdf(file_path::String)

Opens a PDF file, prints out basic document metadata, and extracts 
the text from all available pages.
"""
function read_pdf(file_path::String)
    if !isfile(file_path)
        println("❌ Error: File not found at '$file_path'")
        return
    end

    doc = pdDocOpen(file_path)
    info = pdDocGetInfo(doc)
    
    println("="^40)
    println("📄 Document Metadata:")
    for (key, val) in info
        println("  - $key: $val")
    end
    println("="^40)

    npage = pdDocGetPageCount(doc)
    println("📖 Total Pages Found: $npage\n")

    for i in 1:npage
        println("--- [ Page $i of $npage ] ---")
        page = pdDocGetPage(doc, i)
        io = IOBuffer()
        pdPageExtractText(io, page)
        page_text = String(take!(io))
        
        if isempty(strip(page_text))
            println("[Scanned Page or No Text Structural Data Available]")
        else
            println(page_text)
        end
        println()
    end

    pdDocClose(doc)
end

# CLI Argument Parser Execution
if !isempty(ARGS)
    read_pdf(ARGS[1])
else
    println("⚠️ Usage: julia pdf_reader.jl <path_to_pdf_file>")
end
