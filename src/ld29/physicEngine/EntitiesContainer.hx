package ld29.physicEngine;
import ld29.entities.Entity;

/**
 * ...
 * @author namide.com
 */
class EntitiesContainer
{

	private var entityPlayer:Entity;
	
	private var entitiesGraphics:Array<Entity>;
	private var entitiesRocks:Array<Entity>;
	
	public function new() 
	{
		entitiesGraphics = [];
		entitiesRocks = [];
	}
	
}