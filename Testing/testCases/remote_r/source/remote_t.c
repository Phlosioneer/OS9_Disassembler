
#include <stdio.h>

/* Test remote static storage (aka uninit data) */
remote unsigned int bigarray[1000000];

/* Test remote init data */
remote char loremIpsum[] =
#include "loremIp.h"


main()
{
	register unsigned int i;
	for (i = 0; i < 10000; i++) {
		bigarray[i] = i;
	}
	printf("Remote string: %s", loremIpsum);
}