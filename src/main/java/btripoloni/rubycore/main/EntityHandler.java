package btripoloni.rubycore.main;

import java.util.Random;

import net.minecraft.entity.EntityList;
import cpw.mods.fml.common.registry.EntityRegistry;


public class EntityHandler {
	public static void registerEntities(Class entityClass, String name){
		int entityId = EntityRegistry.findGlobalUniqueEntityId();
		long x = name.hashCode();
		Random random = new Random(x);
		int mainColor = random.nextInt() *  16777215;
		int subColor = random.nextInt() *  16777215;
		/*int mainColor = m * 16777215;
		int subColor = s * 16777215;*/
		
		EntityRegistry.registerGlobalEntityID(entityClass, name, entityId);
		EntityRegistry.registerModEntity(entityClass, name, entityId, BaseMod.instance, 64, 1, true);
		EntityList.entityEggs.put(Integer.valueOf(entityId), new EntityList.EntityEggInfo(entityId, mainColor, subColor));
	}
}
