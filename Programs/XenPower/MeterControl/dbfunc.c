/*
 * File: 	dbfunc.c
 * Purpose:	Functions for directly accessing a PostgreSQL databse via the libpq library.
 * Copyright:	(c)The University of Louisiana at Lafayette, All Rights Rerserved
 * Note:
 * Database access functions are based upon those found in the Crossbow
 * Technolgy's XListen application
 */

#include <libpq-fe.h>

static char *g_server = "localhost";      //!< Postgres server IP or hostname 
static char *g_port   = "5432";           //!< Postgres server port
static char *g_user   = "xenpower";      //!< Postgres server user
static char *g_passwd = "xen";            //!< Postgres server password
static char *g_dbname = "xenpower";      //!< Postgres database to use
static char *g_table  = "";                //!< Postgres table to use


char * dbGetTable()            { return g_table; }
void   dbSetTable(char *table) { g_table = table; }

/*
 * Function: dbExit(PGconn *conn)
 *
 * Release the connection to the database
 */
PGconn *dbExit(PGconn *conn)
{
    PQfinish(conn);
    return NULL;
}

/*
 * Function: dbConnect()
 * Connect to Postgres with the current settings through libpq.
 */
PGconn *dbConnect()
{
     char       *pgoptions, *pgtty;
     PGconn     *conn;
     /*
      * begin, by setting the parameters for a backend connection if the
      * parameters are null, then the system will try to use reasonable
      * defaults by looking up environment variables or, failing that,
      * using hardwired constants
      */
     pgoptions = NULL;           /* special options to start up the backend
                                  * server */
     pgtty = NULL;               /* debugging tty for the backend server */
     /* make a connection to the database */
     conn = PQsetdbLogin(g_server, g_port, pgoptions, pgtty,
			 g_dbname, g_user, g_passwd);
     /*
      * check to see that the backend connection was successfully made
      */
     if (PQstatus(conn) == CONNECTION_BAD)
     {
         fprintf(stderr, "error: Connection to database '%s' failed.\n",
		 g_dbname);
         fprintf(stderr, "%s", PQerrorMessage(conn));
         conn = dbExit(conn);
     }
     return conn;
}

/*
 * Function: dbExecute()
 * Executes the given SQL command through the Postgres library (libpq)
 *
 */
int dbExecute(char *command)
{
    int errno = 0;
#ifdef DEBUG
    fprintf(stderr, "%s\n", command);
#endif
    PGconn *conn = dbConnect();
    PQsendQuery(conn, command);
    PGresult *res = PQgetResult(conn);
    if (res != NULL)
    {
	errno = PQresultStatus(res);
	if (errno > PGRES_COMMAND_OK)
	  fprintf(stderr, "dbExecute(): DATABASE command failed: %i\n", errno);
	PQclear(res);
    }
    /* close the connection to the database and cleanup */
    PQfinish(conn);
    return errno;
}

/*
 * Function: dbRowCount()
 * Returns number of records returned by given command.
 */
int dbRowCount(char *command)
{
    int errno = 0, tuples = 0;
    PGconn *conn = dbConnect();
    PQsendQuery(conn, command);
    PGresult *res = PQgetResult(conn);
    errno = PQresultStatus(res); 
    if (errno > PGRES_TUPLES_OK) { 
	fprintf(stderr, "error: DATABASE command failed: %i\n", errno);
	return 0;
    }
    tuples = PQntuples(res);
    PQfinish(conn);
    return tuples;
}


/*
 * Function:	dbTableExists(char * table)
 * Returns whether table exists.
 */
int dbTableExists(char *table)
{
    char command[256];
    sprintf(command, "select relname from pg_class where relname='%s'", table);
    // return number of columns returned
    return dbRowCount(command);
}
