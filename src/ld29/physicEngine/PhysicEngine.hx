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
			if ( entity.type == Entity.TYPE_GRAPHIC_UNDER || 
				 entity.type == Entity.TYPE_GRAPHIC_OVER	)
			{
				continue;
			}
			
			if ( entity.onGround ) entity.onGround = false;
			
			
			
			entity.vY += G;
			entity.x += entity.vX;
			entity.y += entity.vY;
			if ( entity.type == Entity.TYPE_PLAYER )
			{
				entity.vX *= FRICTION;
			}
			
			x = entity.x + entity.w * 0.5;
			y = entity.y + entity.anchorY;
			if ( ground.isUnder( x, y ) )
			{
				entity.y = ground.getY(x) - entity.anchorY;
				entity.vY = 0;
				entity.onGround = true;
			}
			
		}
	}
	
	public function updateVelocity( entities:Iterable<Entity>, ground:Ground ):Void
	{
		var x:Float, y:Float;
		var p:Point = new Point();
		for ( entity in entities )
		{
			if ( entity.type == Entity.TYPE_GRAPHIC_UNDER )
			{
				continue;
			}
			
			x = entity.x + entity.w * 0.5;
			y = entity.y + entity.anchorY;
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