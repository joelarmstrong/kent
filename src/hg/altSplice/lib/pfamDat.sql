# pfamDat.sql was originally generated by the autoSql program, which also 
# generated pfamDat.c and pfamDat.h.  This creates the database representation of
# an object which can be loaded and saved from RAM in a fairly 
# automatic way.

#Data about a pfam global hit.
CREATE TABLE pfamHit (
    model varchar(255) not null,	# Model hit with sequence.
    descript varchar(255) not null,	# Description of Model hit with sequence.
    score double not null,	# Bit score of hit.
    eval double not null,	# E-values of hit.
    numTimesHit int unsigned not null,	# Number of times hit was found in sequence.
              #Indices
    PRIMARY KEY(model)
);

#Data about a pfam domain hit.
CREATE TABLE pfamDHit (
    model varchar(255) not null,	# Model of domain.
    domain int not null,	# Domain number of hit.
    numDomain int not null,	# Number of domains for a hit.
    seqStart int unsigned not null,	# Start in sequence of hit.
    seqEnd int unsigned not null,	# End in sequence of hit.
    seqRep varchar(255) not null,	# String representation of where hit is located in seq, '[.','..','.]','[]'
    hmmStart int unsigned not null,	# Start in profile hmm of hit.
    hmmEnd int unsigned not null,	# End in profile hmm of hit.
    hmmRep varchar(255) not null,	# String representation of where hit is located in seq, '[.','..','.]','[]'
    dScore double not null,	# Score for domain hit.
    dEval double not null,	# Evalue for domain.
    alignment varchar(255) not null,	# Text based alignment.
              #Indices
    PRIMARY KEY(model)
);

#Structure to hold results of one hmmpfam run. Distributed by Sean Eddy. See http://www.genetics.wustl.edu/eddy/software/
CREATE TABLE pfamDat (
    seqName varchar(255) not null,	# Sequence name.
    sequence varchar(255) not null,	# Sequence run against library.
    pfamHitList longblob not null,	# Global hits.
    pfamDHitList longblob not null,	# Domain hits.
              #Indices
    PRIMARY KEY(seqName)
);
