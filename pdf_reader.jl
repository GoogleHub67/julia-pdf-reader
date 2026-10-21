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

    # 1. Open the PDF document handle
    doc = pdDocOpen(file_path)
    
    # 2. Get and display document metadata (Producer, Author, etc.)
    info = pdDocGetInfo(doc)
    println("="^40)
    println("📄 Document Metadata:")
    for (key, val) in info
        println("  - $key: $val")
    end
    println("="^40)

    # 3. Get total page count
    npage = pdDocGetPageCount(doc)
    println("📖 Total Pages Found: $npage\n")

    # 4. Loop through each page and extract text
    for i in 1:npage
        println("--- [ Page $i of $npage ] ---")
        
        # Get handle for the specific page
        page = pdDocGetPage(doc, i)
        
        # Extract text into an IOBuffer stream, then print it
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

    # 5. Safely close the document handle to free up memory
    pdDocClose(doc)
end

# Example Usage:
# Provide a valid path to a local PDF file to test it out
# read_pdf("my_document.pdf")
