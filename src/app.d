import std.stdio;

import FileConverter;
import Data.Section;

void main(string[] args) {
	writeln("------Start Resume Parser------");
	
	if(args.length > 1) {
		writeln("Converting file: ", args[1]);
		//convertFile(args[0]);
	}
	else {
		writeln("No file specified. Converting Resume.docx.");
		convertFile();
	}
	
	File resume = File(TEMPORARY_RESUME, "r");
	string currentLine;
	
	while(!resume.eof())
	{
		currentLine = resume.readln();
		writeln(currentLine);
	}
	
	resume.close();
	writeln("------End Resume Parser------");
	
}
