package ld29.physicEngine;
import flash.geom.Point;
import ld29.entities.Entity;
import ld29.entities.Ground;

/**
 * ...
 * @author namide.com
 */
class PhysicEngine
{

	private static inline var G:Float = 1;
	private static inline var FRICTION:Float = 0.2;
	
	
	public function new() 
	{
		
	}
	
	public function updatePos( entities:Iterable<Entity>, ground:Ground ):Void
	{
		var x:Float, y:Float;
		for ( entity in entities )
		{
			
			entity.vY += G;
			entity.x += entity.vX;
			entity.y += entity.vY;
			if ( entity.type == Entity.TYPE_PLAYER )
			{
				entity.vX *= FRICTION;
			}
			
			x = entity.x + entity.w * 0.5;
			y = entity.y + entity.h - 4;
			if ( ground.isUnder( x, y ) )
			{
				entity.y = ground.getY(x) + 4 - entity.h;
				entity.vY = 0;
			}
			
		}
	}
	
	public function updateVelocity( entities:Iterable<Entity>, ground:Ground ):Void
	{
		var x:Float, y:Float;
		var p:Point = new Point();
		for ( entity in entities )
		{
			x = entity.x + entity.w * 0.5;
			y = entity.y + entity.h - 4;
			if ( (entity.vY > 0 || entity.vX > 0) && ground.isUnder( x, y ) )
			{
				p.setTo( entity.vX, entity.vY );
				ground.applyBounce( p );
				entity.vX = p.x;
				entity.vY = p.y;
			}
		}
	}
	
	
}