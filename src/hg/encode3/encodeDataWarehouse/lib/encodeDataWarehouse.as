
table edwUser
"Someone who submits files to or otherwise interacts with big data warehouse"
    (
    uint id primary auto;      "Autoincremented user ID"
    string email unique;   "Email address - required"
    )

table edwHost
"A web host we have collected files from - something like www.ncbi.nlm.gov or google.com"
    (
    uint id primary auto;            "Autoincremented host id"
    string name unique;        "Name (before DNS lookup)"
    bigInt lastOkTime;   "Last time host was ok in seconds since 1970"
    bigInt lastNotOkTime;  "Last time host was not ok in seconds since 1970"
    bigInt firstAdded;     "Time host was first seen"
    lstring errorMessage; "If non-empty contains last error message from host. If empty host is ok"
    bigInt openSuccesses;  "Number of times files have been opened ok from this host"
    bigInt openFails;      "Number of times files have failed to open from this host"
    bigInt historyBits; "Open history with most recent in least significant bit. 0 for connection failed, 1 for success"
    )

table edwSubmitDir
"An external data directory we have collected a submit from"
    (
    uint id primary auto;            "Autoincremented id"
    lstring url index[64];        "Web-mounted directory. Includes protocol, host, and final '/'"
    uint hostId index;        "Id of host it's on"
    bigInt lastOkTime;   "Last time submit dir was ok in seconds since 1970"
    bigInt lastNotOkTime;  "Last time submit dir was not ok in seconds since 1970"
    bigInt firstAdded;     "Time submit dir was first seen"
    lstring errorMessage; "If non-empty contains last error message from dir. If empty dir is ok"
    bigInt openSuccesses;  "Number of times files have been opened ok from this dir"
    bigInt openFails;      "Number of times files have failed to open from this dir"
    bigInt historyBits; "Open history with most recent in least significant bit. 0 for upload failed, 1 for success"
    )

table edwFile
"A file we are tracking that we intend to and maybe have uploaded"
    (
    uint id primary auto;                    "Autoincrementing file id"
    uint submitId index;              "Links to id in submit table"
    uint submitDirId index;           "Links to id in submitDir table"
    lstring submitFileName index[32];     "File name in submit relative to submit dir"
    lstring edwFileName unique[32];        "File name in big data warehouse relative to edw root dir"
    bigInt startUploadTime;     "Time when upload started - 0 if not started"
    bigInt endUploadTime;       "Time when upload finished - 0 if not finished"
    bigInt updateTime;          "Update time (on system it was uploaded from)"
    bigInt size;                "File size in manifest"
    char[32] md5 index;               "md5 sum of file contents"
    lstring tags;               "CGI encoded name=val pairs from manifest"
    lstring errorMessage; "If non-empty contains last error message from upload. If empty upload is ok"
    string deprecated; "If non-empty why you shouldn't user this file any more."
    string replacedBy; "If non-empty license plate of file that replaces this one."
    )

table edwSubmit
"A data submit, typically containing many files.  Always associated with a submit dir."
    (
    uint id primary auto;                 "Autoincremented submit id"
    lstring url index[32];              "Url to validated.txt format file. We copy this file over and give it a fileId if we can." 
    bigInt startUploadTime;   "Time at start of submit"
    bigInt endUploadTime;     "Time at end of upload - 0 if not finished"
    uint userId index;        "Connects to user table id field"
    uint submitFileId index;       "Points to validated.txt file for submit."
    uint submitDirId index;    "Points to the submitDir"
    uint fileCount;          "Number of files that will be in submit if it were complete."
    uint oldFiles;           "Number of files in submission that were already in warehouse."
    uint newFiles;           "Number of files in submission that are newly uploaded."
    bigInt byteCount;        "Total bytes in submission including old and new"
    bigInt oldBytes;         "Bytes in old files."
    bigInt newBytes;         "Bytes in new files (so far)."
    lstring errorMessage; "If non-empty contains last error message. If empty submit is ok"
    )

table edwSubscriber
"Subscribers can have programs that are called at various points during data submission"
    (
    uint id primary auto;             "ID of subscriber"
    string name;         "Name of subscriber"
    double runOrder;     "Determines order subscribers run in. In case of tie lowest id wins."
    string filePattern;  "A string with * and ? wildcards to match files we care about"
    string dirPattern;   "A string with * and ? wildcards to match hub dir URLs we care about"
    lstring tagPattern;  "A cgi-encoded string of tag=wildcard pairs."
    string onFileEndUpload;     "A unix command string to run with a %u where file id goes"
    )

table edwAssembly
"An assembly - includes reference to a two bit file, and a little name and summary info."
    (
    uint id primary auto;    "Assembly ID"
    uint taxon; "NCBI taxon number"
    string name;  "Some human readable name to distinguish this from other collections of DNA"
    string ucscDb;  "Which UCSC database (mm9?  hg19?) associated with it."
    uint twoBitId;  "File ID of associated twoBit file"
    bigInt baseCount;  "Count of bases including N's"
    bigInt realBaseCount;   "Count of non-N bases in assembly"
    )

table edwValidFile
"A file that has been uploaded, the format checked, and for which at least minimal metadata exists"
    (
    uint id primary auto;          "ID of validated file"
    char[16] licensePlate index;  "A abc123 looking license-platish thing."
    uint fileId index;      "Pointer to file in main file table"
    string format;    "What format it's in from manifest"
    string outputType index[16]; "What output_type it is from manifest"
    string experiment index[16]; "What experiment it's in from manifest"
    string replicate;  "What replicate it is from manifest"
    string validKey;  "The valid_key tag from manifest"
    string enrichedIn; "The enriched_in tag from manifest"
    string ucscDb;    "Something like hg19 or mm9"

    bigint itemCount; "# of items in file: reads for fastqs, lines for beds, bases w/data for wig."
    bigint basesInItems; "# of bases in items"
    bigint sampleCount; "# of items in sample if we are just subsampling as we do for reads." 
    bigint basesInSample; "# of bases in our sample"
    string sampleBed;   "Path to a temporary bed file holding sample items"
    double mapRatio;    "Proportion of items that map to genome"
    double sampleCoverage; "Proportion of assembly covered by at least one item in sample"
    double depth;   "Estimated genome-equivalents covered by possibly overlapping data"
    )

table edwQaEnrichTarget
"A target for our enrichment analysis."
    (
    uint id primary auto;    "ID of this enrichment target"
    uint assemblyId index; "Which assembly this goes to"
    string name index;  "Something like 'exon' or 'promoter'"
    uint fileId;    "A simple BED 3 format file that defines target. Bases covered are unique"
    bigint targetSize;  "Total number of bases covered by target"
    )

table edwQaEnrich
"An enrichment analysis applied to file."
    (
    uint id primary auto;    "ID of this enrichment analysis"
    uint fileId index;  "File we are looking at skeptically"
    uint qaEnrichTargetId;  "Information about an target for this analysis"
    bigInt targetBaseHits;  "Number of hits to bases in target"
    bigInt targetUniqHits;  "Number of unique bases hit in target"
    double coverage;    "Coverage of target - just targetUniqHits/targetSize"
    double enrichment;  "Amount we hit target/amount we hit genome"
    double uniqEnrich;  "coverage/sampleCoverage"
    )

table edwQaPairSampleOverlap
"A comparison of the amount of overlap between two samples that cover ~0.1% to 10% of target."
    (
    uint id primary auto;    "Id of this qa pair"
    uint elderFileId index;   "Id of elder (smaller fileId) in correlated pair"
    uint youngerFileId index;  "Id of younger (larger fileId) in correlated pair"
    bigInt elderSampleBases;   "Number of bases in elder sample"
    bigInt youngerSampleBases; "Number of bases in younger sample"
    bigInt sampleOverlapBases; "Number of bases that overlap between younger and elder sample"
    double sampleSampleEnrichment; "Amount samples overlap more than expected."
    )

table edwQaPairCorrelation
"A correlation between two files of the same type."
    (
    uint id primary auto;    "Id of this correlation pair"
    uint elderFileId index;   "Id of elder (smaller fileId) in correlated pair"
    uint youngerFileId index;  "Id of younger (larger fileId) in correlated pair"
    double pearsonInEnriched;  "Pearson's R inside enriched areas where there is overlap"
    double pearsonOverall; "Pearson's R over all places where both have data"
    double pearsonClipped; "Pearson's R clipped at two standard deviations up from the mean" 
    )

table edwJob
"A job to be run asynchronously and not too many all at once."
    (
    uint id primary auto;    "Job id"
    lstring commandLine; "Command line of job"
    bigInt startTime; "Start time in seconds since 1970"
    bigInt endTime; "End time in seconds since 1970"
    lstring stderr; "The output to stderr of the run - may be nonembty even with success"
    int returnCode; "The return code from system command - 0 for success"
    )

table edwSubmitJob
"A submission job to be run asynchronously and not too many all at once."
    (
    uint id primary auto;    "Job id"
    lstring commandLine; "Command line of job"
    bigInt startTime; "Start time in seconds since 1970"
    bigInt endTime; "End time in seconds since 1970"
    lstring stderr; "The output to stderr of the run - may be nonembty even with success"
    int returnCode; "The return code from system command - 0 for success"
    )