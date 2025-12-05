#include <stdio.h>
#include "../../common/service.h"

void WriteVersion()
{
	FILE* fp = fopen("VERSION.txt", "w");

	if (fp)
	{
		fprintf(fp, "Game Version: %s\n", VERSION);
		fclose(fp);
	}
}

