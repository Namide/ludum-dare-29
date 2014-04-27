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
	public static inline var TYPE_GRAPHIC_UNDER:UInt = 2;
	public static inline var TYPE_GRAPHIC_OVER:UInt = 3;
	
	public var onGround:Bool = false;
	
	public var x:Float;
	public var y:Float;
	
	public var w:UInt;
	public var h:UInt;
	
	public var vX:Float;
	public var vY:Float;
	
	public var type:UInt;
	
	public var graphic:Graphic;
	public var anchorY:Float;
	
	public var weight:Float;
	
	public function new( width:UInt, height:UInt ) 
	{
		w = width;
		h = height;
		
		vX = 0;
		vY = 0;
		anchorY = height - 1;
		
		weight = 1;
	}
	
	public function updateInputs( speed:Float ):Void
	{
		
	}
	
	public function hitTest( entity:Entity ):Bool
	{
		//if ( type == TYPE_GRAPHIC || entity.type == TYPE_GRAPHIC ) return false;
		if ( x + w <= entity.x ) 		return false;
		if ( y + h <= entity.y ) 		return false;
		if ( x > entity.x + entity.w ) 	return false;
		if ( x > entity.y + entity.h ) 	return false;
		return true;
	}
	
}