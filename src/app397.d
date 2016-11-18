import std.stdio;
import core.stdc.stdlib;
import std.array;
import std.string;
import std.regex;
import std.file;

import core.stdc.errno;
import std.exception;

import FileConverter;

// does not support spacing or symbols in the match function I use, if you wanna use it make a check to change it over when you wanna do it LOL I dont wanna do that though
void _main() 
{

	// make sure it is all lowercase because when it checks it makes the words in .txt doc lowerCase
	string[3] sections;

	// first [] is the number of values in each array, second [] is number of arrays
	string[3][3] sectionsSearches;


	// sectionsSearches[0].length  would tell you how many values are held in first []
	// sectionsSearches.length would tell you how many arrays there are, so second [] value
	

	sections[0] = "goals";

	// stuff to search for in goals section
	sectionsSearches[0][0] = "sleeping";
	sectionsSearches[0][1] = "eatting";
	sectionsSearches[0][2] = "gold";

	sections[1] = "experience";

	// stuff to search for in experience section
	sectionsSearches[1][0] = "5years";
	sectionsSearches[1][1] = "java";
	sectionsSearches[1][2] = "c";

	sections[2] = "education";

	// stuff to search for in education section
	sectionsSearches[2][0] = "college";
	sectionsSearches[2][1] = "pomona";
	sectionsSearches[2][2] = "valedictorian";

	writeln(sectionsSearches[1][2]);




	// it accepts either of these format of file paths idk what yours accepts exactly
	// C://Users//Pimpsupreme//Documents//Visual Studio 2013//Projects//ConsoleApp1//ConsoleApp1//tempResume.txt
	// tempResume.txt
	// these were just test filepaths i used to check if it could recognize a real path from a one that didnt exist


	//another way of checking file paths in D
	/*
	if(exists("tempResume.txt"))
	{
		writeln("exists");
	}
	*/


	writeln("Enter resume document to be parsed: ");

	// will loop until a valid path is chosen
	while(true)
	{
		try
		{
			string fileName = readln();
			
			// need to split to remove /n from the end of the file name entered
			string[] splitLine = fileName.split("\n");

			// only reason we do this is to check if the entered file exists before we send it in
			// this file variable isn't used
			File file = File(splitLine[0], "r");
			
			// send in fileName we entered for it to be converted to a tempResume.txt
			///convertFile(splitLine[0]);

			//convertFile takes in the file and converts it into tempResume.txt
			parseTxtFile(sections, sectionsSearches);

			break;
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
	}
	

	// mine immediately closed so i added this to check the info, just take it out if it is annoying
	system("PAUSE");

}


// tempResume.txt
// apparently needs lengths specified???
void parseTxtFile(string[3] section, string[3][3] sectionGoals)
{
	bool foundSection = false;
	int currentSection = 0;

	int[sectionGoals[0].length][sectionGoals.length]  sectionGoalsValues;

	// opens file in read mode
	File file = File("tempResume.txt", "r");



	int count = 1;

	while (!file.eof()) 
	{
		string line = chomp(file.readln());

			              // splits based on infinite white space
		string[] splitLine = line.split();

		// check through each word in this line of the .txt file
		writeln("Line ", count);
		count++;


			// we assume this means a new section or something so check which section it is, assume two words might be section and only 1 is just a \n
			if (splitLine.length <= 2 && splitLine.length >= 1)
			{
				//writeln("is this a section? ", splitLine[0]);

				for (int j = 0; j < section.length+1; j++)
				{
					// means we found a section that we dont care about (assuming every two word lines is a section)
					if (j >= section.length)
					{
						foundSection = false;
						break;
					}
					
					// just check first word
					// check what section it is
					if (matchFirst(toLower(splitLine[0]), section[j]))
					{
						foundSection = true;
						currentSection = j;
						writeln("Current section = ", splitLine[0], " ", currentSection);
						//system("PAUSE");
						break;
					}
				}
			}  // we are in a section we want to parse
			else if (foundSection == true && splitLine.length > 0)
			{
				// runs through each word of the line looking for each of the keywords we care about in the currentSection
				for (int j = 0; j < sectionGoals[currentSection].length; j++)
				{
					//writeln("j = ", j, "sectionGoals[currentSection].length = ", sectionGoals[currentSection].length);
					for( int i = 0; i < splitLine.length; i++ )
					{
						
						//writeln("Current word = ", splitLine[i], "i = ", i);
						//system("PAUSE");
						


						// makes all the characters of the word lower case for check and looks for the parsed word inside this word (ex: if looking for gold: gold.., gold, and ,gold....en all works
						// drawback is that funky stuff works as well like: mcgoldenchicken, which if we are looking for gold probably shouldn't count, but chances of that are pretty low
						// so it seems acceptable
						if (matchFirst(toLower(splitLine[i]), sectionGoals[currentSection][j]))
						{
							writeln(splitLine[i]);
						}
					}
					

				}
			}
			else 
			{
				// else we are not in a section we care about and we aren't looking 
				//  at a line that could be a section either, we just ignore the line then
			}


		

	}


	file.close();

}
