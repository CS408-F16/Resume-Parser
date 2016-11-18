module Data.ContactInfo;

class ContactInfo {
	string name;
	string mailingAddress;
	string emailAddress;
	string phoneNumber;
}

public enum ContactFlag
{
	Name,
	Email,
	Mailing,
	Phone
}