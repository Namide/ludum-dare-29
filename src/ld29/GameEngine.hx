package ld29;

import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.Lib;
import ld29.entities.BackgroundSquare;
import ld29.entities.EntitiesContainer;
import ld29.entities.Entity;
import ld29.entities.Ground;
import ld29.entities.Player;
import ld29.physicEngine.PhysicEngine;
import ld29.renderEngine.RenderEngine;
import ld29.settings.StageSettings;

/**
 * ...
 * @author namide.com
 */
class GameEngine extends Sprite
{
	private var _lastRealTime:UInt;
	private var _restTime:UInt;
	private var _gameTime:UInt;
	
	
	private var _entitiesContainer:EntitiesContainer;
	private var _renderEngine:RenderEngine;
	private var _physicEngine:PhysicEngine;
	private var _ground:Ground;
	
	private var _player:Player;
	
	private var _slope:Point;
	
	public function new() 
	{
		super();
		
		_lastRealTime = Lib.getTimer();
		_restTime = 0;
		_gameTime = 0;
		
		_entitiesContainer = new EntitiesContainer();
		
		
		_ground = new Ground();
		_ground.setDiagonal( 200, 100 );
		_slope = _ground.getDirection();
		
		_player = new Player( 16, 16 );
		_entitiesContainer.add( _player );
		
		_renderEngine = new RenderEngine();
		addChild( _renderEngine );
		
		_physicEngine = new PhysicEngine();
		
		
		for ( i in 0...100 )
		{
			var rock:Entity = new BackgroundSquare( _slope );
			_entitiesContainer.add( rock );
		}
		
		
		addEventListener( Event.ENTER_FRAME, onEnterFrame );
		addStageListeners();
	}
	private function addStageListeners( e:Event = null ):Void
	{
		if ( stage == null ) return addEventListener( Event.ADDED_TO_STAGE, addStageListeners );
		
		removeEventListener( Event.ADDED_TO_STAGE, addStageListeners );
		resize();
		stage.addEventListener( Event.RESIZE, resize );
	}
	
	private function resize( e:Event = null ):Void
	{
		var pScreen:Float = stage.stageWidth / stage.stageHeight;
		var pRender:Float = StageSettings.W / StageSettings.H;
		var scale:Float = ( pRender > pScreen ) ? ( stage.stageWidth / StageSettings.W ) : ( stage.stageHeight / StageSettings.H );
		_renderEngine.scaleX =
		_renderEngine.scaleY = scale;
		
		_renderEngine.x = Math.round( ( stage.stageWidth - _renderEngine.width ) * 0.5 );
		_renderEngine.y = Math.round( ( stage.stageHeight - _renderEngine.height ) * 0.5 );
	}
	
	private function onEnterFrame(e:Event = null):Void
	{
		_restTime += Lib.getTimer() - _lastRealTime;
		_lastRealTime = Lib.getTimer();
		
		var allEntities:Iterable<Entity> = null;
		if ( _restTime < 21 ) return;
		while ( _restTime > 20 )
		{
			allEntities = refresh();
			_restTime -= 20;
		}
		
		_renderEngine.refresh( allEntities, _ground );
	}
	
	private inline function randomize(t:UInt):Float
	{
		return (Math.sin( t * 0.001 ) + 1) * 0.5;
	}
	public function refresh():Iterable<Entity>
	{
		_gameTime += 1;
		_ground.setDiagonal( randomize(_gameTime) * StageSettings.W * 0.5 , (1 - randomize(_gameTime) ) * StageSettings.H * 0.5 );
		
		var allEntities:Iterable<Entity> = _entitiesContainer.getAll();
		
		for ( entity in allEntities )
		{
			entity.updateInputs();
		}
		
		_physicEngine.updatePos( allEntities, _ground );
		_physicEngine.updateVelocity( allEntities, _ground );
		
		return allEntities;
	}
	
}