table clinVarBed
"Browser extensible data (12 fields) plus information about a ClinVar entry"
    (
    string chrom;        "Chromosome (or contig, scaffold, etc.)"
    uint   chromStart;   "Start position in chromosome"
    uint   chromEnd;     "End position in chromosome"
    string name;         "Name of item"
    uint   score;      "Score from 0-1000"
    char[1] strand;    "+ or -"
    uint thickStart;   "Start of where display should be thick (start codon)"
    uint thickEnd;     "End of where display should be thick (stop codon)"
    uint reserved;     "Used as itemRgb as of 2004-11-22"
    int blockCount;    "Number of blocks"
    int[blockCount] blockSizes; "Comma separated list of block sizes"
    int[blockCount] chromStarts; "Start positions relative to chromStart"
    lstring origName;         "ClinVar Variation Report"
    string clinSign;         "Clinical significance"
    string type;         "Type of Variant"
    string geneId;         "NCBI Entrez Gene ID"
    string geneSym;         "NCBI Entrez Gene Symbol"
    string snpId;         "dbSNP ID"
    string nsvId;         "dbVar ID"
    string rcvAcc;         "ClinVar Allele Submission"
    string testedInGtr;         "Genetic Testing Registry"
    lstring phenotype;         "Phenotype identifiers"
    string origin;         "Data origin"
    string assembly;         "Genome assembly"
    string cytogenetic;         "Cytogenetic status"
    string reviewStatus;         "Review status"
    lstring hgvsCod;         "coding HGVS"
    lstring hgvsProt;         "protein HGVS"
    string numSubmit;         "number of submitters"
    string lastEval;         "last evaluation"
    string guidelines;         "guidelines"
    lstring otherIds;         "other identifiers e.g. OMIM IDs, etc."
    )
