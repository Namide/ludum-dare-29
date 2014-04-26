package ld29.entities;
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.ui.Keyboard;
import ld29.core.KeyboardHandler;
import ld29.renderEngine.components.Graphic;
import ld29.settings.StageSettings;

@:bitmap("ld29/assets/bg-over.png")
class OverBD extends flash.display.BitmapData
{
    
}

/**
 * ...
 * @author namide.com
 */
class OverSquare extends Entity
{

	private var _velocity:Float;
	private var _direction:Point;
	private var _ground:Ground;
	private var _near:Float;
	
	public function new( direction:Point, ground:Ground) 
	{
		_ground = ground;
		_near = Math.random() * Math.random() * Math.random();
		
		var width:UInt = Math.round(8 + 16 * _near);
		var height:UInt = Math.round(8 + 16 * _near);
		_velocity = StageSettings.SPEED_IN + _near * ( StageSettings.SPEED_OVER - StageSettings.SPEED_IN );
		
		
		super(width, height);
		
		type = Entity.TYPE_GRAPHIC_OVER;
		
		graphic = new Graphic( width, height, true );
		
		var color:UInt =  ( Math.round( Math.random() * 0x88 ) << 24 );
		color |= ( Math.round( Math.random() * 0xFF ) << 16 );
		color |= (Math.round ( Math.random() * 0xFF ) << 8 );
		color |= (Math.round ( Math.random() * 0xFF ));
		graphic.bd.fillRect( graphic.bd.rect, color );
		
		/*var overBD:BitmapData = new OverBD(128, 128);
		var m:Matrix = new Matrix();
		m.createBox( graphic.bd.width / overBD.width, graphic.bd.height / overBD.height );
		graphic.bd.draw( overBD, m );*/
		
		_direction = direction;
		
		init(true);
	}
	
	private function init(first:Bool = false):Void
	{
		if ( first )
		{
			x = StageSettings.W * Math.random();
			var y2:Float = _ground.getY(x) - 10;
			y = y2 + _near * (StageSettings.H - y2);
		}
		else
		{
			x = StageSettings.W;
			var y2:Float = _ground.getY(StageSettings.W) - 10;
			y = y2 + (_near) * ( StageSettings.H - y2);
		}
	}
	
	public override function updateInputs( speed:Float ):Void
	{
		x += _direction.x * _velocity * speed;
		y += _direction.y * _velocity * speed;
		//trace(_direction);
		
		if ( y > StageSettings.H ) init();
	}
	
}