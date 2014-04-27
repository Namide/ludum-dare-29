package ld29.entities;
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.ui.Keyboard;
import ld29.core.KeyboardHandler;
import ld29.math.Rng;
import ld29.renderEngine.components.Graphic;
import ld29.settings.StageSettings;


/**
 * ...
 * @author namide.com
 */
class Rock extends Entity
{

	private var _velocity:Float;
	private var _direction:Point;
	private var _ground:Ground;
	private var _near:Float;
	
	public function new( direction:Point, ground:Ground) 
	{
		_ground = ground;
		
		_near = Math.random();
		
		var width:UInt = Math.round(16 + 16 * _near);
		var height:UInt = Math.round(16 + 16 * _near);
		_velocity = StageSettings.SPEED_IN;
		
		
		super(width, height);
		
		type = Entity.TYPE_ROCK;
		
		graphic = new Graphic( width, height, true );
		
		var color:UInt =  ( 0xFF << 24 );
		color |= ( Math.round( Math.random() * 0xFF ) << 16 );
		color |= (Math.round ( Math.random() * 0xFF ) << 8 );
		color |= (Math.round ( Math.random() * 0xFF ));
		graphic.bd.fillRect( graphic.bd.rect, color );
		
		_direction = direction;
		
		init(true);
	}
	
	private function init(first:Bool = false):Void
	{
		x = StageSettings.W;
		var y2:Float = _ground.getY(StageSettings.W);
		y = y2 - Rng.getInstance().get( 50 );
		
		vX = -3;
		vY = 0;
		weight = Math.random() * 0.1;
	}
	
	public override function updateInputs( speed:Float ):Void
	{
		//x += _direction.x * _velocity * speed;
		//y += _direction.y * _velocity * speed;
		//trace(_direction);
		//vX = -speed;
		if ( y > StageSettings.H ) init();
	}
	
}