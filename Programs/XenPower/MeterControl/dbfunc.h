/*
 * File:	dbfuncs.h
 * Author:	Adam Lewis
 * Copyright:	(c) 2006, The University of Louisiana at Lafayette
 */

#ifndef __DBFUNCS__
#define __DBFUNCS__

#include <libpq-fe.h>

PGconn *dbConnect();
PGconn *dbExit(PGconn *conn);
int     dbExecute(char *command);

char   *dbGetTable();
void    dbSetTable(char *table);
int     dbTableExists (char *table);

#endif



