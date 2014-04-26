package ld29.entities;
import ld29.entities.Entity;

/**
 * ...
 * @author namide.com
 */
class EntitiesContainer
{

	private var _entityPlayer:Entity;
	
	private var _entitiesGraphicsUnder:Array<Entity>;
	private var _entitiesGraphicsOver:Array<Entity>;
	private var _entitiesRocks:Array<Entity>;
	
	
	public function new() 
	{
		_entitiesGraphicsUnder = [];
		_entitiesGraphicsOver = [];
		_entitiesRocks = [];
	}
	
	public function add( entity:Entity ):Void
	{
		if ( entity.type == Entity.TYPE_PLAYER )
		{
			_entityPlayer = entity;
		}
		else if ( entity.type == Entity.TYPE_GRAPHIC_UNDER )
		{
			_entitiesGraphicsUnder.push(entity);
		}
		else if ( entity.type == Entity.TYPE_ROCK )
		{
			_entitiesRocks.push(entity);
		}
		else if ( entity.type == Entity.TYPE_GRAPHIC_OVER )
		{
			_entitiesGraphicsOver.push(entity);
		}
	}
	
	public function remove( entity:Entity ):Void
	{
		if ( entity.type == Entity.TYPE_PLAYER )
		{
			_entityPlayer = null;
		}
		else if ( entity.type == Entity.TYPE_GRAPHIC_UNDER )
		{
			if ( Lambda.has( _entitiesGraphicsUnder, entity ) )
			{
				_entitiesGraphicsUnder.splice( Lambda.indexOf( _entitiesGraphicsUnder, entity ), 1 );
			}
		}
		else if ( entity.type == Entity.TYPE_ROCK )
		{
			if ( Lambda.has( _entitiesRocks, entity ) )
			{
				_entitiesRocks.splice( Lambda.indexOf( _entitiesRocks, entity ), 1 );
			}
		}
		else if ( entity.type == Entity.TYPE_GRAPHIC_OVER )
		{
			if ( Lambda.has( _entitiesGraphicsOver, entity ) )
			{
				_entitiesGraphicsOver.splice( Lambda.indexOf( _entitiesGraphicsOver, entity ), 1 );
			}
		}
	}
	
	public function getAll():Iterable<Entity>
	{
		
		return Lambda.concat( 
						Lambda.concat( _entitiesGraphicsUnder, _entitiesRocks ),
						Lambda.concat( [_entityPlayer], _entitiesGraphicsOver )
					);
	}
	
}