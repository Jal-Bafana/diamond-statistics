# Diamond Dataset Analysis Research Paper

This directory contains a professional LaTeX research paper analyzing the diamond dataset from the PNS Project.

## Paper Contents

The research paper presents a comprehensive statistical analysis of the diamond dataset, examining:

- Descriptive statistics and data distributions
- Correlation analysis of diamond characteristics
- Various regression models (linear, polynomial, log-transformed)
- Advanced statistical techniques (decision trees, random forests)
- Key insights and visualizations
- Practical implications and future research directions

## Compiling the LaTeX Document

To compile the LaTeX document into a PDF, you can use one of the following methods:

### Using pdflatex (Command Line)

```bash
pdflatex paper.tex
pdflatex paper.tex  # Run twice for proper cross-references
```

### Using a LaTeX Editor

1. Open `paper.tex` in your preferred LaTeX editor (TeXworks, TeXstudio, Overleaf, etc.)
2. Use the editor's build/compile function to generate the PDF

## Required LaTeX Packages

The paper uses several LaTeX packages that should be included in most standard LaTeX distributions:

- inputenc, babel
- graphicx
- amsmath, amssymb
- natbib
- hyperref
- geometry
- booktabs
- multicol
- float
- url
- xcolor
- listings
- subfigure

If any packages are missing, you may need to install them through your LaTeX distribution's package manager.

## Images and References

The paper references visualizations created in the main project. For a complete compilation with images, you should:

1. Copy the relevant image files from the `plots` and `plots/high_quality` directories to a subdirectory within this Research Paper directory
2. Update the image paths in the LaTeX file if necessary

## Additional Notes

- The paper is formatted for A4 paper with standard margins
- The bibliography uses the natbib package with a numerical citation style 