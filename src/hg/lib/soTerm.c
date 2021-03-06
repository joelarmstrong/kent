/* soTerm - Sequence Ontology terms that we use for compatibility with Ensembl & others. */

/* Copyright (C) 2014 The Regents of the University of California 
 * See README in this or parent directory for licensing information. */

#include "common.h"
#include "soTerm.h"

char *soTermToString(enum soTerm termNumber)
/* Translate termNumber to its string equivalent.  Do not modify or free result. */
{
switch (termNumber)
    {
    case regulatory_region_variant : return "regulatory_region_variant"; break;
    case stop_retained_variant : return "stop_retained_variant"; break;
    case exon_loss : return "exon_loss"; break;
    case splice_acceptor_variant : return "splice_acceptor_variant"; break;
    case splice_donor_variant : return "splice_donor_variant"; break;
    case complex_transcript_variant : return "complex_transcript_variant"; break;
    case stop_lost : return "stop_lost"; break;
    case coding_sequence_variant : return "coding_sequence_variant"; break;
    case initiator_codon_variant : return "initiator_codon_variant"; break;
    case missense_variant : return "missense_variant"; break;
    case stop_gained : return "stop_gained"; break;
    case frameshift_variant : return "frameshift_variant"; break;
    case nc_transcript_variant : return "nc_transcript_variant"; break;
    case mature_miRNA_variant : return "mature_miRNA_variant"; break;
    case NMD_transcript_variant : return "NMD_transcript_variant"; break;
    case _5_prime_UTR_variant : return "5_prime_UTR_variant"; break;
    case _3_prime_UTR_variant : return "3_prime_UTR_variant"; break;
    case incomplete_terminal_codon_variant : return "incomplete_terminal_codon_variant"; break;
    case intron_variant : return "intron_variant"; break;
    case intergenic_variant : return "intergenic_variant"; break;
    case splice_region_variant : return "splice_region_variant"; break;
    case upstream_gene_variant : return "upstream_gene_variant"; break;
    case downstream_gene_variant : return "downstream_gene_variant"; break;
    case TF_binding_site_variant : return "TF_binding_site_variant"; break;
    case non_coding_exon_variant : return "non_coding_transcript_exon_variant"; break;
    case protein_altering_variant : return "protein_altering_variant"; break;
    case synonymous_variant : return "synonymous_variant"; break;
    case inframe_deletion : return "inframe_deletion"; break;
    case inframe_insertion : return "inframe_insertion"; break;
    default:
	errAbort("soTermToString: don't recognize term %u", termNumber);
    }
return "ERROR"; // never get here
}

// Map term strings back to integer IDs:
struct strId
{
    char *str;
    int id;
};

static struct strId strToId[] =
    {
      { "regulatory_region_variant", regulatory_region_variant },
      { "stop_retained_variant", stop_retained_variant },
      { "exon_loss", exon_loss },
      { "splice_acceptor_variant", splice_acceptor_variant },
      { "splice_donor_variant", splice_donor_variant },
      { "complex_transcript_variant", complex_transcript_variant },
      { "stop_lost", stop_lost },
      { "coding_sequence_variant", coding_sequence_variant },
      { "initiator_codon_variant", initiator_codon_variant },
      { "missense_variant", missense_variant },
      { "stop_gained", stop_gained },
      { "frameshift_variant", frameshift_variant },
      { "nc_transcript_variant", nc_transcript_variant },
      { "mature_miRNA_variant", mature_miRNA_variant },
      { "NMD_transcript_variant", NMD_transcript_variant },
      { "5_prime_UTR_variant", _5_prime_UTR_variant },
      { "3_prime_UTR_variant", _3_prime_UTR_variant },
      { "incomplete_terminal_codon_variant", incomplete_terminal_codon_variant },
      { "intron_variant", intron_variant },
      { "intergenic_variant", intergenic_variant },
      { "splice_region_variant", splice_region_variant },
      { "upstream_gene_variant", upstream_gene_variant },
      { "downstream_gene_variant", downstream_gene_variant },
      { "TF_binding_site_variant", TF_binding_site_variant },
      { "non_coding_exon_variant", non_coding_exon_variant },
      { "protein_altering_variant", protein_altering_variant },
      { "synonymous_variant", synonymous_variant },
      { "inframe_insertion", inframe_insertion },
      { "inframe_deletion", inframe_deletion },
      { NULL, 0 }
    };

int soTermStringToId(char *soTermStr)
/* Translate soTermStr into its numeric ID.  Return -1 if soTermStr is not recognized. */
{
if (isEmpty(soTermStr))
    return -1;
int i;
for (i = 0;  strToId[i].str != NULL;  i++)
    {
    if (sameString(soTermStr, strToId[i].str))
        return strToId[i].id;
    }
return -1;
}
