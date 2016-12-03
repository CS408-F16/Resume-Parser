import core.stdc.errno;

import std.array;
import std.exception;
import std.regex;
import std.stdio;
import std.string;

import FileConverter;


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
	
	try
	{
		File resume = File(TEMPORARY_RESUME, "r");
		string[] currentLine;
		int[string] keywords = getKeywords();
		int[string] actionWords = getActionWords();
		int wordCount;
		int keywordCount;
		int actionWordCount;
	
		while(!resume.eof())
		{
			currentLine = split(resume.readln(), regex(" "));
		
			foreach(string wd; currentLine) {
				if(toLower(wd).replace(",", "") in keywords) {
					keywords[toLower(wd).replace(",", "")]++;
					keywordCount++;
				}
				if(toLower(wd).replace(",", "") in actionWords) {
					actionWords[toLower(wd).replace(",", "")]++;
					actionWordCount++;
				}
				wordCount++;
			}
		}
		
		resume.close();
		
		string[] keys = keywords.keys;
		int[string] usedKeywords;
		string[] actions = actionWords.keys;
		int[string] usedActionWords;
	
		foreach(string K; keys) {
			if(keywords[K] > 0)
				usedKeywords[K] = keywords[K];
		}
		foreach(string A; actions) {
			if(actionWords[A] > 0)
				usedActionWords[A] = actionWords[A];
		}
		
		keys = usedKeywords.keys;
		foreach(string K; keys) {
			writeln(K, ":\t", keywords[K]);
		}
		actions = usedActionWords.keys;
		foreach(string A; actions) {
			writeln(A, ":\t", actionWords[A]);
		}
		
		writeln("Word count: ", wordCount);
		writeln("Keyword count: ", keywordCount);
		writeln("Action Word count: ", actionWordCount);	
	}
	
	catch (ErrnoException ex)
	{
		switch(ex.errno)
		{
			case EPERM:
			case EACCES:
				// Permission denied
				writeln("You do not have permission to access that file.\nTry another file: ");
				break;

			case ENOENT:
				// File does not exist
				writeln("The file path you entered does not exist.\nTry again: ");
				break;

			default:
				// Handle other errors
				writeln("The file path has some type of random error.\nTry again: ");
				break;
		}
	}
	
	
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
			keywords[chomp(currentLine)] = 0;
			
	}
	
	return keywords;
}

public int[string] getActionWords() {
	int[string] actionWords;
	
	File file = File("actionWords.txt", "r");
	string currentLine;
	while(!file.eof())
	{
		currentLine = file.readln();
		if(currentLine.length > 0)
			actionWords[chomp(currentLine)] = 0;
			
	}
	
	return actionWords;
}
