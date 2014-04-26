package ld29.entities;
import ld29.renderEngine.components.Graphic;

/**
 * ...
 * @author namide.com
 */
class Entity
{

	public static inline var TYPE_ROCK:UInt = 0;
	public static inline var TYPE_PLAYER:UInt = 1;
	
	public var x:Float;
	public var y:Float;
	
	public var w:UInt;
	public var h:UInt;
	
	public var vX:Float;
	public var vY:Float;
	
	public var type:UInt;
	
	public var graphic:Graphic;
	
	public function new( width:UInt, height:UInt ) 
	{
		w = width;
		h = height;
		
		vX = 0;
		vY = 0;
	}
	
	public function hitTest( entity:Entity ):Bool
	{
		if ( x + w <= entity.x ) return false;
		if ( y + h <= entity.y ) return false;
		if ( x > entity.x + entity.w ) return false;
		if ( x > entity.y + entity.h ) return false;
		return true;
	}
	
}