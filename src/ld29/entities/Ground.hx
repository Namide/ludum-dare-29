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

	public var x:Float;
	public var y:Float;
	
	//private var x:Float;
	private var _y1:Float = StageSettings.H;
	
	private var _x2:Float = StageSettings.W;
	//private var y:Float;
	
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
	
	public function setDiagonal( x:Float, y:Float )
	{
		this.x = x;
		this.y = y;
		
		_a = (_y1 - y) / (x - _x2);
		_b = _y1 - (_a * x);
		
		//trace( _a * 0 + _b );
		
		_normal.setTo( _y1 - y, _x2 - x );
		_normal.normalize( 1 );
		
		_direction.setTo( x - _x2, _y1 - y );
		_direction.normalize( 1 );
		
		/*_p1 = new Point(x, _y1);
		_p2 = new Point(_x2, y);
		_p3 = new Point(StageSettings.W, StageSettings.H);*/
		
		shape.graphics.clear();
		//shape.graphics.lineStyle( 10, 0xFF0000, 1, false, LineScaleMode.VERTICAL, CapsStyle.NONE, JointStyle.MITER, 10);
		shape.graphics.beginFill( 0xFFD700, 1 );
		shape.graphics.moveTo(0, StageSettings.H - y);
		shape.graphics.lineTo(StageSettings.W - x, 0);
		shape.graphics.lineTo(StageSettings.W - x, StageSettings.H - y);
		shape.graphics.lineTo(0, StageSettings.H - y); 
		shape.graphics.endFill();
	}
	
	/*public inline function getX():Float { return x; }
	public inline function getY():Float	{ return y; }*/
	
	public inline function getDirection():Point	{ return _direction; }
	
	public inline function getY( x:Float ):Float
	{
		return _a * x + _b;
	}
	
	public inline function isUnder( x:Float, y:Float ):Bool
	{
		return y > _a * x + _b;
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
		//var v:Float = direction.length;
		var d:Float = 2 * (direction.x * _normal.x + direction.y * _normal.y);
		if ( d > 10 || d < -10 ) trace(d, direction.x, direction.y, _normal);
		direction.x = direction.x - d * _normal.x;
		direction.y = direction.y - d * _normal.y;
		return direction;
	}
}