#include <stdio.h>

int main(int argc, char* argv[]) {
	printf("Hello world!\n");
	printf("Brought to you by %s, with %d argument%s.\n", argv[0], argc, argc>1?"s":"");
	return 0;
}
