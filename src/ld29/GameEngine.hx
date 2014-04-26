package ld29;

import flash.display.Sprite;
import flash.events.Event;
import ld29.entities.EntitiesContainer;
import ld29.entities.Entity;
import ld29.entities.Ground;
import ld29.entities.Player;
import ld29.physicEngine.PhysicEngine;
import ld29.renderEngine.RenderEngine;

/**
 * ...
 * @author namide.com
 */
class GameEngine extends Sprite
{
	private var _entitiesContainer:EntitiesContainer;
	private var _renderEngine:RenderEngine;
	private var _physicEngine:PhysicEngine;
	private var _ground:Ground;
	
	private var _player:Player;
	
	public function new() 
	{
		super();
		
		_entitiesContainer = new EntitiesContainer();
		
		_ground = new Ground();
		_ground.setDiagonal( 200, 100 );
		
		_player = new Player( 16, 16 );
		_entitiesContainer.add( _player );
		
		_renderEngine = new RenderEngine();
		addChild( _renderEngine );
		
		_physicEngine = new PhysicEngine();
		
		//_renderEngine.refresh( [], _ground );
		
		addEventListener( Event.ENTER_FRAME, refresh );
	}
	
	
	public function refresh(e:Event = null):Void
	{
		var allEntities:Iterable<Entity> = _entitiesContainer.getAll();
		
		if ( _player != null ) _player.updateInputs();
		
		_physicEngine.updatePos( allEntities, _ground );
		_physicEngine.updateVelocity( allEntities, _ground );
		
		_renderEngine.refresh( allEntities, _ground );
	}
	
}