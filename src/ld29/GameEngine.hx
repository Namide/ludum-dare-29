package ld29;

import flash.display.Sprite;
import ld29.entities.Ground;
import ld29.renderEngine.RenderEngine;

/**
 * ...
 * @author namide.com
 */
class GameEngine extends Sprite
{

	private var _renderEngine:RenderEngine;
	private var _ground:Ground;
	
	public function new() 
	{
		super();
		
		_ground = new Ground();
		_ground.setDiagonal( 200, 100 );
		
		_renderEngine = new RenderEngine();
		addChild( _renderEngine );
		
		_renderEngine.refresh( [], _ground );
	}
	
}