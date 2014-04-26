package ld29;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import ld29.entities.Entity;

/**
 * ...
 * @author namide.com
 */

class Main 
{
	
	static function main() 
	{
		
		var g:GameEngine = new GameEngine();
		Lib.current.addChild( g );
		
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		// entry point
	}
	
}