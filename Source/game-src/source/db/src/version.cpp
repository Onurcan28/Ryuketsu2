#include <stdio.h>
#include <stdlib.h>
#include "../../common/service.h"

void WriteVersion()
{
	FILE* fp(fopen("VERSION.txt", "w"));
	if (NULL != fp)
	{
		fprintf(fp, "game perforce revision: %s\n", VERSION);
		fclose(fp);
	}
	else
	{
		fprintf(stderr, "cannot open VERSION.txt\n");
		exit(0);
	}
}

