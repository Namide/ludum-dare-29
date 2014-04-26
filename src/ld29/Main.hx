package ld29;

import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import ld29.core.KeyboardHandler;
import ld29.entities.Entity;

/**
 * ...
 * @author namide.com
 */
class Main 
{
	private static var _kh:KeyboardHandler;
	
	static function main() 
	{
		var stage:Stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		
		stage.focus = stage;
		_kh = new KeyboardHandler( stage );
		
		var g:GameEngine = new GameEngine();
		Lib.current.addChild( g );
		
	}
	
}