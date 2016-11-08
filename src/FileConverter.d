import std.stdio;
import std.process;

void convertFile() {
	auto WordToTxtPID = spawnProcess("WordToTxt");
	if (wait(WordToTxtPID) != 0)
	    writeln("Conversion failed!");
}

void convertFile(string filePath) {
	auto WordToTxtPID = spawnProcess(["WordToTxt", filePath]);
	if (wait(WordToTxtPID) != 0)
	    writeln("Conversion failed!");
}