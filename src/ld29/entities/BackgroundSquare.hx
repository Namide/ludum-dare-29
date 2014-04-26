package ld29.entities;
import flash.geom.Point;
import flash.ui.Keyboard;
import ld29.core.KeyboardHandler;
import ld29.renderEngine.components.Graphic;
import ld29.settings.StageSettings;

/**
 * ...
 * @author namide.com
 */
class BackgroundSquare extends Entity
{

	private var _velocity:Float;
	private var _direction:Point;
	
	public function new( direction:Point ) 
	{
		var near:Float = Math.random();
		
		var width:UInt = Math.round(8 + 32 * near);
		var height:UInt = Math.round(8 + 32 * near);
		_velocity = 1 + 5 * near;
		
		
		super(width, height);
		
		type = Entity.TYPE_GRAPHIC_UNDER;
		
		graphic = new Graphic( width, height, true );
		graphic.bd.fillRect( graphic.bd.rect, 0x66CCCCCC );
		
		
		
		
		_direction = direction;
		
		init(true);
	}
	
	private function init(first:Bool = false):Void
	{
		if ( first )
		{
			x = StageSettings.W * Math.random();
			y = StageSettings.H * Math.random();
		}
		else if ( Math.random() < 0.5 )
		{
			x = (StageSettings.W + w) * Math.random();
			y = - h;
		}
		else
		{
			x = StageSettings.W;
			y = StageSettings.H * Math.random() * 0.5;
		}
		
	}
	
	public override function updateInputs():Void
	{
		x += _direction.x * _velocity;
		y += _direction.y * _velocity;
		//trace(_direction);
		
		if ( y > StageSettings.H ) init();
	}
	
}