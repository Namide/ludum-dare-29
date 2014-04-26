package ld29.entities;
import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Shape;
import flash.geom.Point;
import ld29.settings.StageSettings;

/**
 * ...
 * @author namide.com
 */
class Ground
{

	private var _x1:Float;
	private var _y1:Float = StageSettings.H;
	
	private var _x2:Float = StageSettings.W;
	private var _y2:Float;
	
	private var _a:Float;
	private var _b:Float;
	
	private var _normal:Point;
	private var _direction:Point;
	
	/*private var _p1:Point;
	private var _p2:Point;
	private var _p3:Point;*/
	
	public var shape:Shape;
	
	public function new() 
	{
		shape = new Shape();
		_normal = new Point();
		_direction = new Point();
		
		setDiagonal( 0, 0 );
	}
	
	public function setDiagonal( x1:Float, y2:Float )
	{
		_x1 = x1;
		_y2 = y2;
		
		_a = (_y1 - _y2) / (_x1 - _x2);
		_b = _y1 - (_a * _x1);
		
		//trace( _a * 0 + _b );
		
		_normal.setTo( _y1 - _y2, _x2 - _x1 );
		_normal.normalize( 1 );
		
		_direction.setTo( _x1 - _x2, _y2 - _y1 );
		_direction.normalize( 1 );
		
		/*_p1 = new Point(_x1, _y1);
		_p2 = new Point(_x2, _y2);
		_p3 = new Point(StageSettings.W, StageSettings.H);*/
		
		shape.graphics.clear();
		
		shape.graphics.lineStyle( 10, 0xFF0000, 1, false, LineScaleMode.VERTICAL, CapsStyle.NONE, JointStyle.MITER, 10);
		shape.graphics.beginFill( 0xFFD700, 1 );
		shape.graphics.moveTo(0, StageSettings.H - _y2);
		shape.graphics.lineTo(StageSettings.W - _x1, 0);
		shape.graphics.lineTo(StageSettings.W - _x1, StageSettings.H - _y2);
		shape.graphics.lineTo(0, StageSettings.H - _y2); 
		shape.graphics.endFill();
	}
	
	public inline function getX():Float { return _x1; }
	public inline function getY():Float	{ return _y2; }
	
	public inline function getDirection():Point	{ return _direction; }
	
	public inline function isUnder( x:Float, y:Float ):Bool
	{
		return y < _a * x + _b;
	}
	
	public inline function getAngleRad():Float
	{
		return Math.atan( _a );
	}
	
	/*public inline function getPoints():Array<Point>
	{
		return [ _p1, _p2, _p3 ];
	}*/
	
	public inline function applyBounce( direction:Point ):Point
	{
		var d:Float = 2 * (direction.x * _normal.x + direction.y * _normal.y);
		direction.x = direction.x - d * _normal.x;
		direction.y = direction.y - d * _normal.y;
		return direction;
	}
}