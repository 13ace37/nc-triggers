#include <sourcemod>
#include <sdkhooks>

public Plugin myinfo = {
	name = "nc-triggers",
	author = "ace",
	description = "noclip-triggers disables trigger_teleport while noclipping.",
	version = "0.2",
	url = "https://github.com/13ace37/noclip-triggers"
};

bool g_iDisableTriggers[MAXPLAYERS + 1];

public void OnPluginStart(){

	RegConsoleCmd("sm_nct", Command_ToggleNcTriggers, "on/off - toggle triggers while noclipping");
	RegConsoleCmd("sm_nocliptriggers", Command_ToggleNcTriggers, "on/off - toggle triggers while noclipping");

}


public Action Command_ToggleNcTriggers(int client, int args) {
	if (g_iDisableTriggers[client]) {
		g_iDisableTriggers[client] = false;
		PrintToChat(client, "[NCT] Triggers are now disabled while noclipping!");
	} else {
		g_iDisableTriggers[client] = true;
		PrintToChat(client, "[NCT] Triggers are now enabled while noclipping!");
	}
	return Plugin_Handled;
}

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

	if (g_iDisableTriggers[client]) return Plugin_Continue;

	return Plugin_Handled;
} 
