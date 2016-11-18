module Data.Section;

enum SectionType
{
	Education,
	Experience,
	Skills,
	Objective
}

class Section {
	SectionType type;
	string[] lines;
	
	override
	{
		string toString() {
			string val;
			
			// Because we don't have a default, D likes us to use "final switch"
			final switch(type)
			{
				case SectionType.Education:
					val ~= "Education\n";
					break;
				case SectionType.Experience:
					val ~= "Experience\n";
					break;
				case SectionType.Skills:
					val ~= "Skills\n";
					break;
				case SectionType.Objective:
					val ~= "Objective\n";
					break;
				
			}
			
			foreach(string ln; lines) {
				val ~= ln;
			}
			
			return val;
		}
	}
}