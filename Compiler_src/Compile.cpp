#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE *fBuild, *fLink, *fDest;
int build, length;
char *buffer;

int appendFile(const char *filename)
{
	fLink = fopen(filename, "rb");
	if (fLink == NULL) return 0;
	fseek(fLink, 0L, SEEK_END);
	length = ftell(fLink);
	fseek(fLink, 0L, SEEK_SET);
	buffer = (char *)calloc(length + 1, 1);
	fread(buffer, 1, length, fLink);
	fwrite(buffer, strlen(buffer), 1, fDest);
	fclose(fLink);
	free(buffer);
	return 1;
}

int main()
{
	char branch_string[64] = {0};

	fBuild = fopen("build.lua", "r");
	fscanf(fBuild, "build = %d\nbranch = %s\n", &build, branch_string);
	fclose(fBuild);
	fBuild = fopen("build.lua", "w");
	fprintf(fBuild, "build = %d\nbranch = %s\n", ++build, branch_string);
	fclose(fBuild);
	
	remove("Debug/dest.lua");
	fDest = fopen("Debug/dest.lua", "ab");
	if (fDest == NULL) return 0;

	if (appendFile("sprite.lua") == 0)
		return 0;

	if (appendFile("build.lua") == 0)
		return 0;

	if (appendFile("ai_skills_jin.lua") == 0)
		return 0;

	if (appendFile("ai_skills_qun.lua") == 0)
		return 0;

	if (appendFile("ai_skills_shen.lua") == 0)
		return 0;

	if (appendFile("ai_skills_shu.lua") == 0)
		return 0;

	if (appendFile("ai_skills_wei.lua") == 0)
		return 0;

	if (appendFile("ai_skills_wu.lua") == 0)
		return 0;

	if (appendFile("ai_cards.lua") == 0)
		return 0;

	if (appendFile("ai_gamerun.lua") == 0)
		return 0;

	if (appendFile("character.lua") == 0)
		return 0;

	if (appendFile("skills_gamerun.lua") == 0)
		return 0;

	if (appendFile("skills_jin.lua") == 0)
		return 0;

	if (appendFile("skills_qun.lua") == 0)
		return 0;

	if (appendFile("skills_shen.lua") == 0)
		return 0;

	if (appendFile("skills_shu.lua") == 0)
		return 0;

	if (appendFile("skills_wei.lua") == 0)
		return 0;

	if (appendFile("skills_wu.lua") == 0)
		return 0;

	if (appendFile("cards.lua") == 0)
		return 0;

	if (appendFile("run.lua") == 0)
		return 0;

	if (appendFile("ui.lua") == 0)
		return 0;
	
	fclose(fDest);
	return 0;
}
