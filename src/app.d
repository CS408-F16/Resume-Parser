import std.stdio;
import std.string;
import std.regex;
import std.array;

import FileConverter;
import Data.Section;

void main(string[] args) {
	writeln("------Start Resume Parser------");
	
	if(args.length > 1) {
		writeln("Converting file: ", args[1]);
		//convertFile(chomp(args[1]));
	}
	else {
		writeln("No file specified. Converting Resume.docx.");
		convertFile();
	}
	
	File resume = File(TEMPORARY_RESUME, "r");
	string[] currentLine;
	int[string] keywords = getKeywords();
	
	while(!resume.eof())
	{
		currentLine = split(resume.readln(), regex(" "));
		
		
		foreach(string wd; currentLine) {
			if(toLower(wd).replace(",", "") in keywords) {
				keywords[toLower(wd).replace(",", "")]++;
			}
		}
		
	}
	
	string[] keys = keywords.keys;
	
	foreach(string K; keys) {
		writeln(K, ":\t", keywords[K]);
	}
	
	resume.close();
	writeln("------End Resume Parser------");
	
}

public int[string] getKeywords() {
	int[string] keywords;
	
	File file = File("keywords.txt", "r");
	string currentLine;
	while(!file.eof())
	{
		currentLine = file.readln();
		if(currentLine.length > 0)
			//keywords[currentLine[0..$-1]] = 0;
			keywords[chomp(currentLine)] = 0;
			
	}
	
	return keywords;
}
