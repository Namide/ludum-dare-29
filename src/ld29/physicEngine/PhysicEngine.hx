package ld29.physicEngine;
import flash.geom.Point;
import ld29.core.SoundManager;
import ld29.entities.Entity;
import ld29.entities.Ground;
import ld29.entities.Player;
import ld29.settings.StageSettings;

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
	
	public function updateCollide( player:Player, rocks:Iterable<Entity> ):Void
	{
		if( player.onRock ) player.onRock = false;
		
		for ( rock in rocks )
		{
			if ( player.hitTest(rock) )
			{
				var x:Float = (rock.x + rock.w) - (player.x + player.w);
				var y:Float = (rock.y + rock.h) - (player.y + player.h);
				
				if ( Math.abs(y) < Math.abs(x) )
				{
					if ( x < 0 )
					{
						player.x = rock.x + rock.w;
						if ( player.vX < 0 ) player.vX = rock.vX;
					}
					else
					{
						player.x = rock.x - player.w;
						if ( player.vX > 0 ) player.vX = rock.vX;
					}
					player.vY = rock.vY;
				}
				else
				{
					if ( y < 0 )
					{
						player.y = rock.y + rock.h;
						if ( player.vY < 0 ) player.vY = rock.vY;
					}
					else
					{
						player.y = rock.y - player.h;
						if ( player.vY > 0 ) player.vY = rock.vY;
						
						player.onRock = true;
					}
					player.vX = rock.vX;
				}
			}
		}
	}
	
	public function updatePos( entitiesActive:Iterable<Entity>, ground:Ground ):Void
	{
		var x:Float, y:Float;
		for ( entity in entitiesActive )
		{
			/*if ( entity.type == Entity.TYPE_GRAPHIC_UNDER || 
				 entity.type == Entity.TYPE_GRAPHIC_OVER	)
			{
				continue;
			}*/
			
			if ( entity.onGround ) entity.onGround = false;
			
			
			
			entity.vY += G * entity.weight;
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
				
				if (	entity.type == Entity.TYPE_ROCK &&
						entity.y + entity.h > 0 &&
						entity.y < StageSettings.H )
				{
					SoundManager.getInstance().playRandom();
				}
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