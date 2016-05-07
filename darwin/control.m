// 16 august 2015
#import "uipriv_darwin.h"

void uiDarwinControlSyncEnableState(uiDarwinControl *c, int state)
{
	(*(c->SyncEnableState))(c, state);
}

void uiDarwinControlSetSuperview(uiDarwinControl *c, NSView *superview)
{
	(*(c->SetSuperview))(c, superview);
}

BOOL uiDarwinControlChildrenShouldAllowSpaceAtTrailingEdge(uiDarwinControl *c)
{
	return (*(c->ChildrenShouldAllowSpaceAtTrailingEdge))(c);
}

BOOL uiDarwinControlChildrenShouldAllowSpaceAtBottom(uiDarwinControl *c)
{
	return (*(c->ChildrenShouldAllowSpaceAtBottom))(c);
}

void uiDarwinSetControlFont(NSControl *c, NSControlSize size)
{
	[c setFont:[NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:size]]];
}

#define uiDarwinControlSignature 0x44617277

uiDarwinControl *uiDarwinAllocControl(size_t n, uint32_t typesig, const char *typenamestr)
{
	return uiDarwinControl(uiAllocControl(n, uiDarwinControlSignature, typesig, typenamestr));
}

BOOL uiDarwinShouldStopSyncEnableState(uiDarwinControl *c, BOOL enabled)
{
	int ce;

	ce = uiControlEnabled(uiControl(c));
	// only stop if we're going from disabled back to enabled; don't stop under any other condition
	// (if we stop when going from enabled to disabled then enabled children of a disabled control won't get disabled at the OS level)
	if (!ce && enabled)
		return YES;
	return NO;
}
