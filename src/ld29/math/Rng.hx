package ld29.math;
import flash.errors.Error;

/**
 * ...
 * @author namide.com
 */
class Rng
{
	private static var _CAN_INSTANTIATE:Bool = false;
	private static var _INSTANCE:Rng;
	
	private var _seed:Int;
	
	public function new( seed:Int ) 
	{
		if (_CAN_INSTANTIATE = false) throw new Error( "Singleton can't instance it! Use getInstance()" );
		_seed = seed;
	}
	
	public static inline function getInstance():Rng
	{
        if (_INSTANCE == null)
		{
            _CAN_INSTANTIATE = true;
            _INSTANCE = new Rng( 777 );
            _CAN_INSTANTIATE = false;
        }
        return _INSTANCE;
    }
	
	public function get(maxsize:Int):Int
	{
		var tmp:Int = (_seed * 883) + 883;
		tmp = tmp % 1046527;
		_seed = Std.int(tmp);
		if (_seed <= 0) _seed = 1;
		return tmp % (maxsize + 1);
	}
	
}