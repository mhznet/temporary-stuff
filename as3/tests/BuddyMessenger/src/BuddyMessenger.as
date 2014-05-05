import com.smartfoxserver.v2.SmartFox;
import com.smartfoxserver.v2.core.SFSBuddyEvent;
import com.smartfoxserver.v2.core.SFSEvent;
import com.smartfoxserver.v2.entities.Buddy;
import com.smartfoxserver.v2.entities.SFSBuddy;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.entities.variables.BuddyVariable;
import com.smartfoxserver.v2.entities.variables.ReservedBuddyVariables;
import com.smartfoxserver.v2.entities.variables.SFSBuddyVariable;
import com.smartfoxserver.v2.requests.JoinRoomRequest;
import com.smartfoxserver.v2.requests.buddylist.AddBuddyRequest;
import com.smartfoxserver.v2.requests.buddylist.BlockBuddyRequest;
import com.smartfoxserver.v2.requests.buddylist.BuddyMessageRequest;
import com.smartfoxserver.v2.requests.buddylist.GoOnlineRequest;
import com.smartfoxserver.v2.requests.buddylist.InitBuddyListRequest;
import com.smartfoxserver.v2.requests.buddylist.RemoveBuddyRequest;
import com.smartfoxserver.v2.requests.buddylist.SetBuddyVariablesRequest;
import com.smartfoxserver.v2.util.ClientDisconnectionReason;

import flash.events.Event;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.managers.PopUpManager;

import components.ChatTab;

[Embed(source="assets/icon_available.png")]
public static var iconAvailable:Class;

[Embed(source="assets/icon_away.png")]
public static var iconAway:Class;

[Embed(source="assets/icon_occupied.png")]
public static var iconOccupied:Class;

[Embed(source="assets/icon_offline.png")]
public static var iconOffline:Class;

[Embed(source="assets/icon_blocked.png")]
public static var iconBlocked:Class;

public static const BUDDYVAR_AGE:String = SFSBuddyVariable.OFFLINE_PREFIX + "age";
public static const BUDDYVAR_MOOD:String = "mood";

private var sfs:SmartFox;
private var alert:Alert;
private var _isBuddyListInited:Boolean;

private function init():void
{
	// Get reference to SmartFoxServer connection
	sfs = loginPanel.connector.connection;
	
	// Add listeners
	// NOTE: for sake of simplicty, most buddy-related events cause the whole
	// buddylist in the interface to be recreated from scratch, also if those
	// events are caused by the current user himself. A more refined approach should
	// update the specific list items.
	sfs.addEventListener(SFSEvent.LOGIN, onLogin);
	sfs.addEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost);
	sfs.addEventListener(SFSBuddyEvent.BUDDY_LIST_INIT, onBuddyListInit);
	sfs.addEventListener(SFSEvent.MODERATOR_MESSAGE, onModeratorMessage);
	sfs.addEventListener(SFSBuddyEvent.BUDDY_ERROR, onBuddyError);
	sfs.addEventListener(SFSBuddyEvent.BUDDY_ONLINE_STATE_UPDATE, onBuddyListUpdate);
	sfs.addEventListener(SFSBuddyEvent.BUDDY_VARIABLES_UPDATE, onBuddyListUpdate);
	sfs.addEventListener(SFSBuddyEvent.BUDDY_ADD, onBuddyListUpdate);
	sfs.addEventListener(SFSBuddyEvent.BUDDY_REMOVE, onBuddyListUpdate);
	sfs.addEventListener(SFSBuddyEvent.BUDDY_BLOCK, onBuddyListUpdate);
	sfs.addEventListener(SFSBuddyEvent.BUDDY_MESSAGE, onBuddyMessage);
	
	isBuddyListInited = false;
}

protected function onModeratorMessage(event:SFSEvent):void
{
	trace ("Ae ae ae");
}

[Bindable]
public function set isBuddyListInited(value:Boolean):void
{
	_isBuddyListInited = value;
}
public function get isBuddyListInited():Boolean
{
	return _isBuddyListInited;
}

//---------------------------------
// User interaction event handlers
//---------------------------------

/**
 * Set current user nickname.
 * This can be done if the current user is online in the buddy system only. 
 */
private function onSetNickBtClick():void
{
	var nick:BuddyVariable = new SFSBuddyVariable(ReservedBuddyVariables.BV_NICKNAME, ti_nick.text);
	sfs.send(new SetBuddyVariablesRequest([nick]));
}

/**
 * Set current user state.
 * This can be done if the current user is online in the buddy system only.
 */
private function onStateDdChange():void
{
	var state:BuddyVariable = new SFSBuddyVariable(ReservedBuddyVariables.BV_STATE, dd_states.selectedLabel);
	sfs.send(new SetBuddyVariablesRequest([state]));
}

/**
 * Make current user go online/offline in the buddy list system.
 */
private function onOnlineCbChange():void
{
	sfs.send(new GoOnlineRequest(cb_online.selected));
}

/**
 * Set current user age.
 * This can be done if the current user is online in the buddy system only.
 */
private function onSetAgeBtClick():void
{
	var age:BuddyVariable = new SFSBuddyVariable(BUDDYVAR_AGE, ns_age.value);
	sfs.send(new SetBuddyVariablesRequest([age]));
}

/**
 * Set current user mood.
 * This can be done if the current user is online in the buddy system only.
 */
private function onSetMoodBtClick():void
{
	var mood:BuddyVariable = new SFSBuddyVariable(BUDDYVAR_MOOD, ti_mood.text);
	sfs.send(new SetBuddyVariablesRequest([mood]));
}

/**
 * Add a buddy.
 */
private function onAddBuddyBtClick():void
{
	if (ti_buddyName.text != "")
	{
		sfs.send(new AddBuddyRequest(ti_buddyName.text));
		ti_buddyName.text = "";
	}
}

/**
 * Remove a buddy.
 */
private function onRemoveBuddyBtClick():void
{
	sfs.send(new RemoveBuddyRequest(ls_buddies.selectedItem.name));
}

/**
 * Block/unblock a buddy.
 */
private function onBlockBuddyBtClick():void
{
	var isBlocked:Boolean = ls_buddies.selectedItem.isBlocked;
	sfs.send(new BlockBuddyRequest(ls_buddies.selectedItem.name, !isBlocked));
}

/**
 * Start a chat with the buddy.
 */
private function onBuddyListDoubleClick():void
{
	var buddy:Buddy = ls_buddies.selectedItem as SFSBuddy;
	
	if (!buddy.isBlocked)
		addChatTab(buddy, true);
}

private function onAlertClosed(evt:Event):void
{
	removeAlert();
}

//---------------------------------
// SmartFoxServer event handlers
//---------------------------------

/**
 * On login, show the lobby view.
 */
private function onLogin(evt:SFSEvent):void
{
	// Move to main view, and display user name
	mainView.selectedChild = view_main;
	lb_myUserName.text = sfs.mySelf.name;
	
	// Initialize buddy list system
	sfs.send(new InitBuddyListRequest());
	sfs.send(new JoinRoomRequest("The Lobby"));
}

/**
 * On connection lost, go back to login panel view and display disconnection error message.
 */
private function onConnectionLost(evt:SFSEvent):void
{
	// Reset interface
	reset();
	
	// Remove alert, if displayed
	removeAlert();
	
	// Show disconnection message, unless user chose voluntarily to close the connection
	if (evt.params.reason != ClientDisconnectionReason.MANUAL)
	{
		var msg:String = "Connection lost";
		
		switch (evt.params.reason)
		{
			case ClientDisconnectionReason.IDLE:
				msg += "\nYou have exceeded the maximum user idle time";
				break;
			
			case ClientDisconnectionReason.KICK:
				msg += "\nYou have been kicked";
				break;
			
			case ClientDisconnectionReason.BAN:
				msg += "\nYou have been banned";
				break;
			
			case ClientDisconnectionReason.UNKNOWN:
				msg += " due to unknown reason\nPlease check the server-side log";
				break;
		}
		
		loginPanel.ta_error.text = msg;
	}
	
	// Show login view
	mainView.selectedChild = view_connecting;
}

/**
 * Initialize interface when buddy list data is received.
 */
private function onBuddyListInit(evt:SFSBuddyEvent):void
{
	// Populate list of buddies
	onBuddyListUpdate(evt);
	
	// Set current user details as buddy
	
	// Nick
	ti_nick.text = sfs.buddyManager.myNickName;
	
	// States
	var states:Array = sfs.buddyManager.buddyStates;
	dd_states.dataProvider = states;
	var state:String = (sfs.buddyManager.myState != null ? sfs.buddyManager.myState : "");
	if (states.indexOf(state) > -1)
		dd_states.selectedIndex = states.indexOf(state);
	else
		dd_states.selectedIndex = 0;
	
	// Online
	cb_online.selected = sfs.buddyManager.myOnlineState;
		
	// Buddy variables
	var age:BuddyVariable = sfs.buddyManager.getMyVariable(BUDDYVAR_AGE);
	ns_age.value = ((age != null && !age.isNull()) ? age.getIntValue() : 30);
	
	var mood:BuddyVariable = sfs.buddyManager.getMyVariable(BUDDYVAR_MOOD);
	ti_mood.text = ((mood != null && !mood.isNull()) ? mood.getStringValue() : "");
	
	isBuddyListInited = true;
}

/**
 * Build buddies list.
 */
private function onBuddyListUpdate(evt:SFSBuddyEvent):void
{
	var buddies:ArrayCollection = new ArrayCollection();
	
	for each (var buddy:Buddy in sfs.buddyManager.buddyList)
	{
		buddies.addItem(buddy);
		
		// Refresh the buddy chat tab (if open) so that it matches the buddy state
		var tab:ChatTab = stn_chats.getChildByName(buddy.name) as ChatTab;
		if (tab != null)
		{
			tab.buddy = buddy;
			tab.refresh();
			
			// If a buddy was blocked, close its tab
			if (buddy.isBlocked)
				stn_chats.removeChild(tab);
		}
	}
	
	ls_buddies.dataProvider = buddies;
}

/**
 * Message received from a buddy.
 */
private function onBuddyMessage(evt:SFSBuddyEvent):void
{
	var isItMe:Boolean = evt.params.isItMe;
	var sender:Buddy = evt.params.buddy;
	var message:String = evt.params.message;
	
	var buddy:Buddy;
	
	if (isItMe)
	{
		var buddyName:String = (evt.params.data as ISFSObject).getUtfString("recipient");
		buddy = sfs.buddyManager.getBuddyByName(buddyName);
	}
	else
		buddy = sender;
	
	if (buddy != null)
	{
		var tab:ChatTab = addChatTab(buddy, false);
		tab.displayMessage("<b>" + (isItMe ? "You" : tab.getDisplayedName()) + ":</b> " + message);
	}
}

private function onBuddyError(evt:SFSBuddyEvent):void
{
	showAlert("The following error occurred in the buddy list system: " + evt.params.errorMessage);
}

//---------------------------------
// Other methods
//---------------------------------

private function reset():void
{
	isBuddyListInited = false;
	ls_buddies.dataProvider = null;
}

private function addChatTab(buddy:Buddy, focus:Boolean):ChatTab
{
	var tab:ChatTab = stn_chats.getChildByName(buddy.name) as ChatTab;
	
	if (tab == null)
	{
		tab = new ChatTab();
		tab.buddy = buddy;
		
		stn_chats.addChild(tab);
	}
	
	if (focus)
		stn_chats.selectedChild = tab;
	
	return tab;
}

/**
 * Called by the ChatTab component when the Send button is clicked.
 */
public function sendMessageToBuddy(message:String, buddy:Buddy):void
{
	// Add a custom parameter containing the recipient name,
	// so that we are able to write messages in the proper chat tab
	var params:ISFSObject = new SFSObject();
	params.putUtfString("recipient", buddy.name);
	var bdyMsn:BuddyMessageRequest = new BuddyMessageRequest(message, buddy, params)
	sfs.send(bdyMsn);
}

private function showAlert(message:String):void
{
	// Remove previous alert, if any
	removeAlert()
	
	// Show alert
	alert = Alert.show(message, "Warning", Alert.OK, null, onAlertClosed);
}

private function removeAlert():void
{
	if (alert != null)
		PopUpManager.removePopUp(alert);
	
	alert = null;
}
