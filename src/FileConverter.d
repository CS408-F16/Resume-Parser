import core.stdc.errno;

import std.array;
import std.exception;
import std.file;
import std.process;
import std.stdio;

static const string TEMPORARY_RESUME = "_tempResume.txt";

void convertFile() {
	auto WordToTxtPID = spawnProcess("WordToTxt");
	if (wait(WordToTxtPID) != 0)
	    writeln("Conversion failed!");
	else
		writeln("File converted to ", TEMPORARY_RESUME);
}

void convertFile(string filePath) {
	auto WordToTxtPID = spawnProcess(["WordToTxt", filePath]);
	writeln(filePath);
	if (wait(WordToTxtPID) != 0)
	    writeln("Conversion failed!");
	else
		writeln("File converted to ", TEMPORARY_RESUME);
}

string[] getFileLines() {
	try
	{
		int ndx = 0;
		File file = File(TEMPORARY_RESUME, "r");
		string[] lines;
		while(!file.eof()) {
			lines[ndx] = file.readln();
			ndx++;
		}
		
		file.close();
		return lines;
	}
	catch (ErrnoException ex)
	{
		switch(ex.errno)
		{
			case EPERM:
			case EACCES:
				// Permission denied
				writeln("You do not have permission to access that file.\nTry another file: ");
				return null;

			case ENOENT:
				// File does not exist
				writeln("The file path you entered does not exist.\nTry again: ");
				return null;

			default:
				// Handle other errors
				writeln("The file path has some type of random error.\nTry again: ");
				return null;
		}
	}
}