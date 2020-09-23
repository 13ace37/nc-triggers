#include <sourcemod>

public Plugin myinfo = {
	name = "nc-triggers",
	author = "ace",
	description = "noclip-triggers disables trigger_teleport while noclipping.",
	version = "0.1",
	url = "https://github.com/13ace37/noclip-triggers"
};

public void OnEntityCreated(int entity, const char[] classname) {
	if( (classname[0] == 't' ||  classname[0] == 'l') ? (StrEqual(classname, "trigger_teleport", false) ) : false)
	{
		SDKHook(entity, SDKHook_Use, ingnoreTriggers);
		SDKHook(entity, SDKHook_StartTouch, ingnoreTriggers);
		SDKHook(entity, SDKHook_Touch, ingnoreTriggers);
		SDKHook(entity, SDKHook_EndTouch, ingnoreTriggers);
	}
}

public Action ingnoreTriggers(int entity, int client) //add command to !options
{
	if (!(client > 0 && client <= MaxClients) || !IsPlayerAlive(client)) return Plugin_Continue;

	if(GetEntityMoveType(client) != MOVETYPE_NOCLIP) return Plugin_Continue;

	return Plugin_Handled;
} 
