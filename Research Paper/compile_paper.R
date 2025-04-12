# Script to compile the LaTeX paper.tex file to PDF
# This script requires tinytex package in R

# Check if tinytex is installed, install if not
if (!require("tinytex")) {
  install.packages("tinytex")
  library(tinytex)
}

# Install LaTeX if not installed
if (!tinytex:::is_tinytex()) {
  message("TinyTeX is not installed. Installing TinyTeX...")
  tinytex::install_tinytex()
}

# Set working directory to the Research Paper directory
# Change this path if needed
setwd("Research Paper")

# Compile LaTeX document (run twice for proper cross-references)
message("Compiling LaTeX document...")
system2("pdflatex", "paper.tex")
system2("pdflatex", "paper.tex")

# Check if compilation was successful
if (file.exists("paper.pdf")) {
  message("Compilation successful. PDF created at: Research Paper/paper.pdf")
} else {
  message("Compilation failed. Check for errors in the LaTeX document.")
}

# Clean up auxiliary files
message("Cleaning up auxiliary files...")
aux_files <- list.files(pattern = "\\.(aux|log|out|toc)$")
file.remove(aux_files)

message("Done.") 