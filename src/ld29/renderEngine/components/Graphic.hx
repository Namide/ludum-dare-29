package ld29.renderEngine.components;
import flash.display.BitmapData;

/**
 * ...
 * @author namide.com
 */
class Graphic
{

	public var bd:BitmapData;
	
	public function new( width:UInt, height:UInt, alpha:Bool = false ) 
	{
		bd = new BitmapData( width, height, alpha, 0xFF00FF00 );
	}
	
}