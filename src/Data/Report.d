module Data.Report;

import Data.Section;

class Report {
	Section[] sections;
	
	public void addSection(Section s) {
		sections ~= s;
	}
	
	override
	{
		// Here we see the import statement used in the scope of the override
		import std.stdio;
		
		string toString() {
			string val;
			foreach(Section s; sections) {
				val ~= s.toString();
			}
			return val;
		}
	}
}