package ld29.settings;
import flash.errors.Error;

/**
 * ...
 * @author namide.com
 */
class StageSettings
{

	public static var SCARE_W:Array<UInt> = [16, 24, 32];
	public static var SCARE_H:Array<UInt> = [16, 24, 32];
	
	public static inline var W:UInt = 640;
	public static inline var H:UInt = 360;
	
	public function new() 
	{
		throw new Error( "static class!" );
	}
	
}