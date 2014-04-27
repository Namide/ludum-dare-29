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
		
		var width:UInt = Math.round(1 + 8 * near);
		var height:UInt = Math.round(1 + 8 * near);
		_velocity = StageSettings.SPEED_BACK + near * ( StageSettings.SPEED_IN - StageSettings.SPEED_BACK );
		
		
		super(width, height);
		
		type = Entity.TYPE_GRAPHIC_UNDER;
		
		graphic = new Graphic( width, height, true );
		
		var color:UInt =  ( Math.round( Math.random() * 0x55 ) << 24 );
		color |= ( Math.round( Math.random() * 0xFF ) << 16 );
		color |= (Math.round ( Math.random() * 0xFF ) << 8 );
		color |= (Math.round ( Math.random() * 0xFF ) << 0 );
		
		graphic.bd.fillRect( graphic.bd.rect, color );
		
		
		
		
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
	
	public override function updateInputs( speed:Float ):Void
	{
		x += _direction.x * _velocity * speed;
		y += _direction.y * _velocity * speed;
		//trace(_direction);
		
		if ( y > StageSettings.H ) init();
	}
	
}