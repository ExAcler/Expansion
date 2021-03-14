#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
	FILE *fBuild, *fLink, *fDest;
	int build, length;
	char *buffer;
	
	fBuild = fopen("build.txt", "r");
	fscanf(fBuild, "%d", &build);
	fclose(fBuild);
	fBuild = fopen("build.txt", "w");
	fprintf(fBuild, "%d", ++build);
	fclose(fBuild);
	
	remove("Debug/dest.lua");
	fDest = fopen("Debug/dest.lua", "ab");
	if (fDest == NULL) return 0;
	
	fLink = fopen("sprite.lua", "rb");
	if (fLink == NULL) return 0;
	fseek(fLink, 0L, SEEK_END);
	length = ftell(fLink);
	fseek(fLink, 0L, SEEK_SET);
	buffer = (char *)calloc(length + 1, 1);
	fread(buffer, length, 1, fLink);
	fwrite(buffer, strlen(buffer), 1, fDest);
	fclose(fLink);
	free(buffer);
	
	fLink = fopen("ai.lua", "rb");
	if (fLink == NULL) return 0;
	fseek(fLink, 0L, SEEK_END);
	length = ftell(fLink);
	fseek(fLink, 0L, SEEK_SET);
	buffer = (char *)calloc(length + 1, 1);
	fread(buffer, length, 1, fLink);
	fwrite(buffer, strlen(buffer), 1, fDest);
	fclose(fLink);
	free(buffer);

	fLink = fopen("character.lua", "rb");
	if (fLink == NULL) return 0;
	fseek(fLink, 0L, SEEK_END);
	length = ftell(fLink);
	fseek(fLink, 0L, SEEK_SET);
	buffer = (char *)calloc(length + 1, 1);
	fread(buffer, length, 1, fLink);
	fwrite(buffer, strlen(buffer), 1, fDest);
	fclose(fLink);
	free(buffer);
	
	fLink = fopen("skills.lua", "rb");
	if (fLink == NULL) return 0;
	fseek(fLink, 0L, SEEK_END);
	length = ftell(fLink);
	fseek(fLink, 0L, SEEK_SET);
	buffer = (char *)calloc(length + 1, 1);
	fread(buffer, 1, length, fLink);
	fwrite(buffer, strlen(buffer), 1, fDest);
	fclose(fLink);
	free(buffer);
	
	fLink = fopen("cards.lua", "rb");
	if (fLink == NULL) return 0;
	fseek(fLink, 0L, SEEK_END);
	length = ftell(fLink);
	fseek(fLink, 0L, SEEK_SET);
	buffer = (char *)calloc(length + 1, 1);
	fread(buffer, 1, length, fLink);
	fwrite(buffer, strlen(buffer), 1, fDest);
	fclose(fLink);
	free(buffer);
	
	fLink = fopen("run.lua", "rb");
	if (fLink == NULL) return 0;
	fseek(fLink, 0L, SEEK_END);
	length = ftell(fLink);
	fseek(fLink, 0L, SEEK_SET);
	buffer = (char *)calloc(length + 1, 1);
	fread(buffer, length, 1, fLink);
	fwrite(buffer, strlen(buffer), 1, fDest);
	fclose(fLink);
	free(buffer);
	
	fLink = fopen("ui.lua", "rb");
	if (fLink == NULL) return 0;
	fseek(fLink, 0L, SEEK_END);
	length = ftell(fLink);
	fseek(fLink, 0L, SEEK_SET);
	buffer = (char *)calloc(length + 1, 1);
	fread(buffer, length, 1, fLink);
	fwrite(buffer, strlen(buffer), 1, fDest);
	fclose(fLink);
	free(buffer);
	
	fclose(fDest);
	return 0;
}
