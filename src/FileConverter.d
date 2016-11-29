import std.array;
import std.file;
import std.stdio;
import std.process;

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