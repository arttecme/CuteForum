package forum.cute.utils;

public class Macro
{
	public static boolean isInvalid(String str)
	{
		if(str == null) { return true; }
		if("".equals(str.trim())) { return true; }
		return false;
	}
}
