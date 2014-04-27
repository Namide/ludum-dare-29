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
	
	private var _rockDecal:Float;
	
	public function new( direction:Point, ground:Ground, maxDecal:Float ) 
	{
		_ground = ground;
		_rockDecal = maxDecal;
		
		_near = Math.random();
		
		var width:UInt = 32 + Rng.getInstance().get( 64 );
		var height:UInt = width;
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
		
		//init( _rockDecal );
	}
	
	public function init( decal:Float = -1 ):Void
	{
		if ( decal < 0 ) decal = _rockDecal;
		
		x = StageSettings.W + decal;
		var y2:Float = _ground.getY(x);
		y = y2 - Rng.getInstance().get( 50 );
		
		vX = -3;
		vY = 0;
		
		var minWeight:Float = 0.02;
		var maxWeight:Float = 0.05;
		
		weight = Math.random() * (maxWeight - minWeight) + minWeight;
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