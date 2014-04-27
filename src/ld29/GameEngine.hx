package ld29;

import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.Lib;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.ui.Keyboard;
import ld29.core.KeyboardHandler;
import ld29.core.SimpleSound;
import ld29.core.SoundManager;
import ld29.entities.BackgroundSquare;
import ld29.entities.EntitiesContainer;
import ld29.entities.Entity;
import ld29.entities.Ground;
import ld29.entities.OverSquare;
import ld29.entities.Player;
import ld29.entities.Rock;
import ld29.physicEngine.PhysicEngine;
import ld29.renderEngine.RenderEngine;
import ld29.settings.StageSettings;

@:font("ld29/assets/PressStart2P-Regular.ttf", range = "")
class PressStart2P extends flash.text.Font
{
	public function new() 
	{ 
		super();
	}
}


/**
 * ...
 * @author namide.com
 */
class GameEngine extends Sprite
{
	private static inline var FONT_NAME:String = "Press Start 2P";
	
	private var _lastRealTime:UInt;
	private var _restTime:UInt;
	private var _gameTime:UInt;
	
	private var _startTime:UInt;
	private var _bestTime:UInt = 0;
	private var _score:TextField;
	private var _textFormat:TextFormat;
	
	private var _sounds:SoundManager;
	
	private var _entitiesContainer:EntitiesContainer;
	private var _renderEngine:RenderEngine;
	private var _physicEngine:PhysicEngine;
	private var _ground:Ground;
	
	private var _player:Player;
	private var _speed:Float;
	
	private var _slope:Point;
	
	
	public function new() 
	{
		super();
		_sounds = SoundManager.getInstance();
		KeyboardHandler.getInstance().addCallback( Keyboard.M, _sounds.mutteOnOff );
		
		
		// TIME
		_lastRealTime = Lib.getTimer();
		_restTime = 0;
		_gameTime = 0;
		
		// CONTAINER
		_entitiesContainer = new EntitiesContainer();
		
		
		// GROUND
		_ground = new Ground();
		_ground.setDiagonal( 200, 100 );
		_slope = _ground.getDirection();
		
		
		// PLAYER
		_player = new Player( 16, 16 );
		_entitiesContainer.add( _player );
		
		
		// GRAPHIC
		for ( i in 0...300 )
		{
			var rock:Entity = new BackgroundSquare( _slope );
			_entitiesContainer.add( rock );
		}
		for ( i in 0...25 )
		{
			var rock:Entity = new OverSquare( _slope, _ground );
			_entitiesContainer.add( rock );
		}
		
		
		// ROCKS
		var numRock:Int = 5;
		var decal:Float = StageSettings.W * 0.5 * numRock;
		for ( i in 0...numRock )
		{
			var rock:Rock = new Rock( _slope, _ground, decal );
			rock.init( decal * (i+1) / numRock );
			_entitiesContainer.add( rock );
		}
		/*var rock:Entity = new Rock( _slope, _ground );
		_entitiesContainer.add( rock );*/
		
		
		// RENDER
		_renderEngine = new RenderEngine();
		addChild( _renderEngine );
		
		
		//PHYSIC
		_physicEngine = new PhysicEngine();
		
		
		//SCORE
		var font:Font = new PressStart2P();
		_textFormat = new TextFormat( font.fontName/*GameEngine.FONT_NAME*/, 12, 0xCCCCCC );
		_textFormat.align = TextFormatAlign.LEFT;
		
		_score = new TextField();
		_score.embedFonts = true;
		_score.multiline = true;
		_score.width = StageSettings.W * 0.5;
		_score.x = 10;
		_score.y = 20;
		addChild( _score );
		
		/*var scoreTF:TextFormat = new TextFormat( textFormat.font, textFormat.size * 1.5, 0xff8a00 );
		var nameTF:TextFormat = new TextFormat( textFormat.font, textFormat.size * 1.3, 0xFFFFFF );
		var placeTF:TextFormat = new TextFormat( textFormat.font, textFormat.size, 0xFFFFFF );*/
		
		
		addEventListener( Event.ENTER_FRAME, onEnterFrame );
		addStageListeners();
		
		restart();
		
		
	}
	
	private function restart():Void
	{
		
		if ( _bestTime < _gameTime - _startTime ) _bestTime = _gameTime - _startTime;
		_startTime = _gameTime;
		
		_player.x = StageSettings.W * 0.5;
		_player.y = _ground.getY( _player.x ) - 200;
		
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
		
		_score.text = "MOUNT!\n\n";
		if ( _bestTime > 0 ) _score.text += "Best: " + Math.round(_bestTime/30) + "\n";
		_score.text += "Score: " + Math.round((_gameTime - _startTime)/30) + "\n\n";
		_score.text += "Sound: " + ( (_sounds.getAllMutted())?"off":"on" );
		
		_score.setTextFormat( _textFormat );
		//scoreT.text = place + " " + score + " " + name;
		//scoreT.setTextFormat( textFormat );
	}
	
	private inline function randomize(t:UInt):Float
	{
		//return (Math.sin( t * 0.1 ) + 1) * 0.5;
		return (Math.sin( t * 0.001 ) + 1) * 0.5;
	}
	public function refresh():Iterable<Entity>
	{
		_gameTime += 1;
		_ground.setDiagonal( randomize(_gameTime) * StageSettings.W * 0.5 , (1 - randomize(_gameTime) ) * StageSettings.H * 0.5 );
		_speed = 1 + _gameTime / 10000;
		
		var allEntities:Iterable<Entity> = _entitiesContainer.getAll();
		var allEntitiesActive:Iterable<Entity> = _entitiesContainer.getAllActives();
		var allEntitiesRock:Iterable<Entity> = _entitiesContainer.getAllRocks();
		
		for ( entity in allEntities )
		{
			entity.updateInputs( _speed );
		}
		
		_physicEngine.updatePos( allEntitiesActive, _ground );
		_physicEngine.updateCollide( _player, allEntitiesRock );
		_physicEngine.updateVelocity( allEntities, _ground );
		
		if ( _player.y > StageSettings.H ) restart();
		
		return allEntities;
	}
	
}