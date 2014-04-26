package ld29.core;

import flash.display.Stage;
import flash.errors.Error;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.utils.Function;
import flash.Vector;

/**
 * ...
 * @author namide.com
 */
class KeyboardHandler
{

	private static var _MAIN:KeyboardHandler;
	
	private var _listKeyPressed:Array<UInt>;
	private var _listKeyCodeHandler:Array<UInt>;
	private var _listCallbackHandler:Array<Function>;
	
	private var _stage:Stage;
	
	public function new( stage:Stage ) 
	{
		if ( _MAIN != null ) throw new Error("Only on instance of KeyboardHandler!");
		_stage = stage;
		restart();
		_MAIN = this;
	}
	
	public function restart():Void
	{
		dispose();
		_stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDown );
		_stage.addEventListener( KeyboardEvent.KEY_UP, keyUp );
	}
	
	public function dispose():Void
	{
		_stage.removeEventListener( KeyboardEvent.KEY_DOWN, keyDown );
		_stage.removeEventListener( KeyboardEvent.KEY_UP, keyUp );
		
		_listKeyPressed = [];
		_listKeyCodeHandler = [];
		_listCallbackHandler = [];
	}
	
	public static function getInstance():KeyboardHandler
	{
		if ( _MAIN == null ) throw new Error("No instance of KeyboardHandler!");
		return _MAIN;
	}
	
	public function addCallback( keyCode:UInt, pCallback:Function ):Void
	{
		_listCallbackHandler.push(pCallback);
		_listKeyCodeHandler.push(keyCode);
	}
	
	public function getKeyPressed( keyCode:UInt ):Bool
	{
		return Lambda.has( _listKeyPressed, keyCode );
	}
	
	private function keyDown( e:KeyboardEvent ):Void
	{
		_listKeyPressed.push( e.keyCode );
	}
	
	private function keyUp( e:KeyboardEvent ):Void
	{
		
		
		if ( Lambda.has( _listKeyCodeHandler, e.keyCode ) )
		{
			var i:Int;
			for ( i in 0..._listKeyCodeHandler.length )
			{
				if ( _listKeyCodeHandler[i] == e.keyCode ) _listCallbackHandler[i]();
			}
		}
		
		while ( Lambda.has( _listKeyPressed, e.keyCode ) )
		{
			_listKeyPressed.splice( Lambda.indexOf( _listKeyPressed, e.keyCode ), 1 );
		}
	}
}