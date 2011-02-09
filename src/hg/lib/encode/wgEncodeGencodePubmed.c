/* wgEncodeGencodePubmed.c was originally generated by the autoSql program, which also 
 * generated wgEncodeGencodePubmed.h and wgEncodeGencodePubmed.sql.  This module links the database and
 * the RAM representation of objects. */

#include "common.h"
#include "linefile.h"
#include "dystring.h"
#include "jksql.h"
#include "wgEncodeGencodePubmed.h"

static char const rcsid[] = "$Id:$";

void wgEncodeGencodePubmedStaticLoad(char **row, struct wgEncodeGencodePubmed *ret)
/* Load a row from wgEncodeGencodePubmed table into ret.  The contents of ret will
 * be replaced at the next call to this function. */
{

ret->transcriptId = row[0];
ret->pubMedId = row[1];
}

struct wgEncodeGencodePubmed *wgEncodeGencodePubmedLoad(char **row)
/* Load a wgEncodeGencodePubmed from row fetched with select * from wgEncodeGencodePubmed
 * from database.  Dispose of this with wgEncodeGencodePubmedFree(). */
{
struct wgEncodeGencodePubmed *ret;

AllocVar(ret);
ret->transcriptId = cloneString(row[0]);
ret->pubMedId = cloneString(row[1]);
return ret;
}

struct wgEncodeGencodePubmed *wgEncodeGencodePubmedLoadAll(char *fileName) 
/* Load all wgEncodeGencodePubmed from a whitespace-separated file.
 * Dispose of this with wgEncodeGencodePubmedFreeList(). */
{
struct wgEncodeGencodePubmed *list = NULL, *el;
struct lineFile *lf = lineFileOpen(fileName, TRUE);
char *row[2];

while (lineFileRow(lf, row))
    {
    el = wgEncodeGencodePubmedLoad(row);
    slAddHead(&list, el);
    }
lineFileClose(&lf);
slReverse(&list);
return list;
}

struct wgEncodeGencodePubmed *wgEncodeGencodePubmedLoadAllByChar(char *fileName, char chopper) 
/* Load all wgEncodeGencodePubmed from a chopper separated file.
 * Dispose of this with wgEncodeGencodePubmedFreeList(). */
{
struct wgEncodeGencodePubmed *list = NULL, *el;
struct lineFile *lf = lineFileOpen(fileName, TRUE);
char *row[2];

while (lineFileNextCharRow(lf, chopper, row, ArraySize(row)))
    {
    el = wgEncodeGencodePubmedLoad(row);
    slAddHead(&list, el);
    }
lineFileClose(&lf);
slReverse(&list);
return list;
}

struct wgEncodeGencodePubmed *wgEncodeGencodePubmedCommaIn(char **pS, struct wgEncodeGencodePubmed *ret)
/* Create a wgEncodeGencodePubmed out of a comma separated string. 
 * This will fill in ret if non-null, otherwise will
 * return a new wgEncodeGencodePubmed */
{
char *s = *pS;

if (ret == NULL)
    AllocVar(ret);
ret->transcriptId = sqlStringComma(&s);
ret->pubMedId = sqlStringComma(&s);
*pS = s;
return ret;
}

void wgEncodeGencodePubmedFree(struct wgEncodeGencodePubmed **pEl)
/* Free a single dynamically allocated wgEncodeGencodePubmed such as created
 * with wgEncodeGencodePubmedLoad(). */
{
struct wgEncodeGencodePubmed *el;

if ((el = *pEl) == NULL) return;
freeMem(el->transcriptId);
freeMem(el->pubMedId);
freez(pEl);
}

void wgEncodeGencodePubmedFreeList(struct wgEncodeGencodePubmed **pList)
/* Free a list of dynamically allocated wgEncodeGencodePubmed's */
{
struct wgEncodeGencodePubmed *el, *next;

for (el = *pList; el != NULL; el = next)
    {
    next = el->next;
    wgEncodeGencodePubmedFree(&el);
    }
*pList = NULL;
}

void wgEncodeGencodePubmedOutput(struct wgEncodeGencodePubmed *el, FILE *f, char sep, char lastSep) 
/* Print out wgEncodeGencodePubmed.  Separate fields with sep. Follow last field with lastSep. */
{
if (sep == ',') fputc('"',f);
fprintf(f, "%s", el->transcriptId);
if (sep == ',') fputc('"',f);
fputc(sep,f);
if (sep == ',') fputc('"',f);
fprintf(f, "%s", el->pubMedId);
if (sep == ',') fputc('"',f);
fputc(lastSep,f);
}

/* -------------------------------- End autoSql Generated Code -------------------------------- */
